import argparse
import os
import subprocess
import yaml


def get_args():
    parser = argparse.ArgumentParser(
        prog="muxy",
        description="Handy utility for creating or attaching to tmux sessions",
    )
    parser.add_argument('-l', '--loop',
        action="store_true",
        help="Re-prompt after tmux exits"
    )
    parser.add_argument('--tmuxinator-dir',
        default=f"{os.environ["HOME"]}/.config/tmuxinator",
        help="The directory to search for tmuxinator sessions (default: ~/.config/tmuxinator)"
    )
    args = parser.parse_args()
    args.in_tmux = "TMUX" in os.environ and bool(os.environ["TMUX"])
    if args.in_tmux and args.loop:
        print("Inside tmux! Ignoring -l/--loop")
        args.loop = False
    return args


def get_active_sessions():
    try:
        output = subprocess.check_output('tmux ls -F "#{session_name}"', shell=True)
        return list(filter(lambda x: x.strip(), output.decode("utf-8").split("\n")))
    except subprocess.CalledProcessError:
        return []


def get_saved_sessions(tmuxinator_dir):
    sessions = {}
    for d in os.scandir(tmuxinator_dir):
        if d.is_file() and (d.name.endswith(".yml") or d.name.endswith(".yaml")):
            profile = ".".join(d.name.split(".")[:-1])
            name = profile
            with open(d.path) as f:
                try:
                    y = yaml.safe_load(f)
                    if "name" in y:
                        name = y["name"]
                except yaml.YAMLError as exc:
                    print(f"Error parsing {d.path}\n{exc}")
            sessions[name] = profile
    return sessions


def get_choices(tmuxinator_dir):
    choices = {}

    active_sessions = get_active_sessions()
    saved_sessions = get_saved_sessions(tmuxinator_dir)

    default = 0
    while str(default) in active_sessions or str(default) in saved_sessions:
        default += 1
    choices["New session..."] = (str(default), False, False)

    for name in active_sessions:
        choices[name] = (name, True, False)
    for name, profile in saved_sessions.items():
        if name in choices:
            choice = choices[name]
            choices[name] = (choice[0], choice[1], True)
        else:
            choices[name] = (profile, False, True)

    return choices


def fmt_choice(choice):
    display, (_, is_active, is_saved) = choice
    match is_active, is_saved:
        case True, True:
            return f'{{{{ Bold "{display}" }}}}'
        case True, False:
            return f'{{{{ Bold (Italic "{display}") }}}}'
        case False, True:
            return f'{{{{ "{display}" }}}}'
        case False, False:
            return f'{{{{ Faint (Italic "{display}") }}}}'
        case _:
            raise ValueError


def prompt(choices):
    choices_fmt = "\n".join(map(fmt_choice, choices.items()))
    fmt_cmd = "gum format -t template"
    filter_cmd = "gum filter --no-strip-ansi --no-strict --placeholder 'Select a tmux session'"
    cmd = f"echo '{choices_fmt}' | {fmt_cmd} | {filter_cmd}"
    try:
        output = subprocess.check_output(cmd, shell=True)
        selected = output.decode("utf-8")[:-1]  # Take newline off the end; might not want to .strip()
        if selected not in choices:
            return "new", selected.strip()
        choice = choices[selected]
        name, is_active, is_saved = choice
        match is_active, is_saved:
            case True, _:
                return "attach", name
            case False, True:
                return "start", name
            case False, False:
                return "new", name
            case _:
                raise ValueError
    except subprocess.CalledProcessError:
        return None


def get_tmux_cmds(kind, name, in_tmux):
    match kind:
        case "attach":
            return [
                ["tmux", ("attach" if not in_tmux else "switch"), "-t", name],
            ]
        case "start":
            return [
                ["tmuxinator", "start", name],
            ]
        case "new":
            if not in_tmux:
                return [
                    ["tmux", "new", "-s", name],
                ]
            else:
                return [
                    ["tmux", "new", "-d", "-s", name],
                    ["tmux", "switch", "-t", name],
                ]
        case _:
            raise ValueError


def launch(choice, in_tmux):
    cmds = get_tmux_cmds(*choice, in_tmux)
    for cmd in cmds:
        subprocess.run(cmd)


def prompt_and_launch(tmuxinator_dir, in_tmux):
    choices = get_choices(tmuxinator_dir)
    choice = prompt(choices)
    if choice:
        launch(choice, in_tmux)
        return True
    else:
        return False


def main():
    args = get_args()
    should_loop = True
    while should_loop:
        should_loop = prompt_and_launch(args.tmuxinator_dir, args.in_tmux) and args.loop


if __name__ == "__main__":
    main()
