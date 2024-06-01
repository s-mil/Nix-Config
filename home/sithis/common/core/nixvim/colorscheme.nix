{ inputs, pkgs, ... }: {
  programs.nixvim = {
    colorschemes = {
      catppuccin = {
        enable = true;

        settings = {
          flavour = "mocha";

          transparent_background = true;
        };
      };
    };
  };
}
