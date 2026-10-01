{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "claude-swap";
  version = "0.26.0";

  src = fetchFromGitHub {
    owner = "realiti4";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ypE/fxgMr+SSF/8blI2YVqcr9coW3YcGzC/NiogyadQ=";
  };

  pyproject = true;
  build-system = [ python3.pkgs.hatchling ];

  pythonRelaxDeps = true;

  dependencies = with python3.pkgs; [
    textual
    truststore
  ];

  # Linux: skip Windows-only keyring dependency (it has a sys_platform == 'win32' marker,
  # but nixpkgs dependency resolution can miss markers)
  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail '"keyring>=25.0.0; sys_platform == '"'"'win32'"'"'",' ""
  '';

  # no tests packaged in the sdist path we care about
  doCheck = false;

  meta = with lib; {
    description = "Multi-account switcher for Claude Code";
    homepage = "https://github.com/realiti4/claude-swap";
    license = licenses.mit;
    mainProgram = "claude-swap";
    platforms = platforms.unix;
  };
}
