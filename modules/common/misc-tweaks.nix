{
  lib,
  ...
}:
{
  options.misc-tweaks = {
    sddmFontSize = lib.mkOption {
      type = lib.types.int;
      description = "Login screen font size";
    };
  };
}

