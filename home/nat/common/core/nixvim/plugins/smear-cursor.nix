# Smear the cursor when making large motions
{
  programs.nixvim = {
    plugins.smear-cursor = {
      enable = true;
      settings = {
        # The smear is a bit distracting for smaller movements
        smear_between_neighbor_lines = false;

        ## Faster smear
        # stiffness = 0.8;
        # trailing_stiffness = 0.6;
        # stiffness_insert_mode = 0.7;
        # damping = 0.95;
        # damping_insert_mode = 0.95;
        # distance_stop_animating = 0.5;
      };
    };
  };
}
