# home.nix
{pkgs,...}: {

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "mauve";
        flavor = "mocha";
      };
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };

    font = {
        name = "Hack Nerd Font";
        size = 15;
    };

    gtk2.extraConfig = "gtk-enable-animations=1\ngtk-primary-button-warps-slider=0\ngtk-toolbar-style=3\ngtk-menu-images=1\ngtk-button-images=1\ngtk-cursor-theme-size=24";
    
    gtk3.extraConfig = {
      gtk-button-images = true;
      gtk-enable-animations = true;
      gtk-menu-images = true;
      gtk-toolbar-style = 3;
    };

    gtk4.extraConfig = {
      gtk-button-images = true;
      gtk-enable-animations = true;
      gtk-menu-images = true;
      gtk-toolbar-style = 3;
    };
  };
}
