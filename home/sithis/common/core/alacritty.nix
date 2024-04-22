{ config, pkgs, ... }: {

  xdg.configFile."alacritty/theme_catppuccin.yml".text = ''
    colors:
      primary:
          background: "#1E1E2E" # base
          foreground: "#CDD6F4" # text
          # Bright and dim foreground colors
          dim_foreground: "#CDD6F4" # text
          bright_foreground: "#CDD6F4" # text

      # Cursor colors
      cursor:
          text: "#1E1E2E" # base
          cursor: "#F5E0DC" # rosewater
      vi_mode_cursor:
          text: "#1E1E2E" # base
          cursor: "#B4BEFE" # lavender

      # Search colors
      search:
          matches:
              foreground: "#1E1E2E" # base
              background: "#A6ADC8" # subtext0
          focused_match:
              foreground: "#1E1E2E" # base
              background: "#A6E3A1" # green
          footer_bar:
              foreground: "#1E1E2E" # base
              background: "#A6ADC8" # subtext0

      # Keyboard regex hints
      hints:
          start:
              foreground: "#1E1E2E" # base
              background: "#F9E2AF" # yellow
          end:
              foreground: "#1E1E2E" # base
              background: "#A6ADC8" # subtext0

      # Selection colors
      selection:
          text: "#1E1E2E" # base
          background: "#F5E0DC" # rosewater

      # Normal colors
      normal:
          black: "#45475A" # surface1
          red: "#F38BA8" # red
          green: "#A6E3A1" # green
          yellow: "#F9E2AF" # yellow
          blue: "#89B4FA" # blue
          magenta: "#F5C2E7" # pink
          cyan: "#94E2D5" # teal
          white: "#BAC2DE" # subtext1

      # Bright colors
      bright:
          black: "#585B70" # surface2
          red: "#F38BA8" # red
          green: "#A6E3A1" # green
          yellow: "#F9E2AF" # yellow
          blue: "#89B4FA" # blue
          magenta: "#F5C2E7" # pink
          cyan: "#94E2D5" # teal
          white: "#A6ADC8" # subtext0

      # Dim colors
      dim:
          black: "#45475A" # surface1
          red: "#F38BA8" # red
          green: "#A6E3A1" # green
          yellow: "#F9E2AF" # yellow
          blue: "#89B4FA" # blue
          magenta: "#F5C2E7" # pink
          cyan: "#94E2D5" # teal
          white: "#BAC2DE" # subtext1

      indexed_colors:
          - { index: 16, color: "#FAB387" }
          - { index: 17, color: "#F5E0DC" }

  '';
  programs.alacritty = { enable = true; };
  xdg.configFile."alacritty/alacritty.yml".text = ''
    import:
      # all alacritty themes can be found at
      #    https://github.com/alacritty/alacritty-theme
      - ~/.config/alacritty/theme_catppuccin.yml

    window:
      # Background opacity
      #
      # Window opacity as a floating point number from `0.0` to `1.0`.
      # The value `0.0` is completely transparent and `1.0` is opaque.
      opacity: 0.93


      # Allow terminal applications to change Alacritty's window title.
      dynamic_title: true



    scrolling:
      # Maximum number of lines in the scrollback buffer.
      # Specifying '0' will disable scrolling.
      history: 10000

      # Scrolling distance multiplier.
      #multiplier: 3

    # Font configuration
    font:
      normal:
        family: Hack Nerd Font
        style: Regular
      bold:
        family: Hack Nerd Font
        style: Bold
      italic:
        family: Hack Nerd Font
        style: Italic
      bold_italic:
        family: Hack Nerd Font
        style: Bold Italic
      size: 18
  '';
}
