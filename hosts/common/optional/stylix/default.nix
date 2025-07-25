{ pkgs, config, ... }: {

  stylix = {

    image = ./background.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "Hack" ]; };
        name = "Hack Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 18;
        terminal = 18;
        desktop = 15;
        popups = 15;
      };
    };
    targets.plymouth.enable = false;
    # cursor = {
    #   package = pkgs.catppuccin-cursors.mochaDark;
    #   name = "Catppuccin-Mocha-Dark-Cursors";
    # };

  };
}
