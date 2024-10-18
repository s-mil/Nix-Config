{ ... }: {
  stylix.targets.alacritty.enable = false;
  xdg.configFile."alacritty/theme_catppuccin.toml".text = ''
    [[colors.indexed_colors]]
    color = "#FAB387"
    index = 16

    [[colors.indexed_colors]]
    color = "#F5E0DC"
    index = 17

    [colors.bright]
    black = "#585B70"
    blue = "#89B4FA"
    cyan = "#94E2D5"
    green = "#A6E3A1"
    magenta = "#F5C2E7"
    red = "#F38BA8"
    white = "#A6ADC8"
    yellow = "#F9E2AF"

    [colors.cursor]
    cursor = "#F5E0DC"
    text = "#1E1E2E"

    [colors.dim]
    black = "#45475A"
    blue = "#89B4FA"
    cyan = "#94E2D5"
    green = "#A6E3A1"
    magenta = "#F5C2E7"
    red = "#F38BA8"
    white = "#BAC2DE"
    yellow = "#F9E2AF"

    [colors.hints.end]
    background = "#A6ADC8"
    foreground = "#1E1E2E"

    [colors.hints.start]
    background = "#F9E2AF"
    foreground = "#1E1E2E"

    [colors.normal]
    black = "#45475A"
    blue = "#89B4FA"
    cyan = "#94E2D5"
    green = "#A6E3A1"
    magenta = "#F5C2E7"
    red = "#F38BA8"
    white = "#BAC2DE"
    yellow = "#F9E2AF"

    [colors.primary]
    background = "#1E1E2E"
    bright_foreground = "#CDD6F4"
    dim_foreground = "#CDD6F4"
    foreground = "#CDD6F4"

    [colors.search.focused_match]
    background = "#A6E3A1"
    foreground = "#1E1E2E"

    [colors.search.matches]
    background = "#A6ADC8"
    foreground = "#1E1E2E"

    [colors.selection]
    background = "#F5E0DC"
    text = "#1E1E2E"

    [colors.vi_mode_cursor]
    cursor = "#B4BEFE"
    text = "#1E1E2E"

    [colors.footer_bar]
    background = "#A6ADC8"
    foreground = "#1E1E2E"
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

    env:
      WINIT_X11_SCALE_FACTOR: "1.0"

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
