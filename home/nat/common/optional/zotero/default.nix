# Copied from https://github.com/crisbour/nix-hm-config/blob/59d4bf32bd13a539a1da76fdd7c7ba9b41d30cc6/home/features/productivity/zotero/default.nix
{ pkgs, config, ... }:
let
  doc = config.xdg.userDirs.documents;
  citekeyFormat = ''shorttitle(n=3).lower.condense("-") + "-" + auth.lower + "-" + year + postfix(format="%(n)s")'';
in
{
  programs.zotero = {
    enable = true;
    package = pkgs.unstable.zotero;

    profiles.default = {
      extensions = with pkgs.zotero-addons; [
        zotero-better-bibtex
        zotmoov
      ];

      settings = {
        "extensions.zotero.sync.storage.enabled" = false;
        "extensions.zotero.dataDir" = "${doc}/.zotero";
        "extensions.zotero.attachmentRenameTemplate" =
          ''{{firstCreator suffix=" "}}{{ suffix=" - " }}{{if shortTitle}}{{shortTtile}}{{else}}{{title truncate="100"}}{{end}}'';
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # zotero-better-bibtex
        "extensions.zotero.translators.better-bibtex.citekeyFormat" = citekeyFormat;
        "extensions.zotero.translators.better-bibtex.citekeyFormatEditing" = citekeyFormat;

        # zotmoove
        "extensions.zotmoov.dst_dir" = "${doc}/papers";
      };

      userChrome = builtins.readFile ./userChrome.css;
    };
  };

  # Zotero requires libreoffice
  home.packages = [ pkgs.libreoffice ];
}
