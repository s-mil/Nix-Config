{ config, pkgs, unstable, ... }:
{
    programs.tmux = {
        enable = true;
        package = unstable.tmux;
        baseIndex = 1;
        keyMode = "vi";
        mouse = true;
        prefix = "C-Spcae";
        terminal = "screen-256color";
        plugins = with pkgs;
        [
            {
                plugin = "tmuxPlugins.sensible";
            
            }
            {
                plugin = "tmuxPlugins.catppuccin";
                    extraConfig = '' 
                    set -g @catppuccin_flavour 'mocha'
                    set -g @catppuccin_window_tabs_enabled on
                    set -g @catppuccin_date_time "%H:%M"
                    '';
            
            }
            {
                plugin = "tmuxPlugins.vim-tmux-navigator";
            
            }
            {
                plugin = "tmuxPlugins.yank";
            
            }
        ];
    };
}
