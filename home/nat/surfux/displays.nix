let
  internal-on = [
    { criteria = "$INTERNAL"; status = "enable"; }
  ];
in
{
  my.kanshi = {
    outputs."INTERNAL" = {
      criteria = "eDP-1";
      scale = 1.75;
    };
    profiles = [
      {
        # In the office; secondary monitor goes above internal
        name = "work";
        outputs = [
          {
            criteria = "$INTERNAL";
            status = "enable";
            position = "35,1200";
          }
          {
            criteria = "PNP(AOC) 2460X D02E9BA000209";
            status = "enable";
            position = "0,0";
          }
        ];
      }

      {
        name = "default";
        outputs = internal-on;
      }
      {
        name = "misc-ext";
        outputs = internal-on ++ [
          { criteria = "*"; status = "enable"; }
        ];
      }
    ];
  };
}
