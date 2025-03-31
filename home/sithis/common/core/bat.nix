# https://github.com/sharkdp/bat
# https://github.com/eth-p/bat-extras

{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      # Show line numbers, Git modifications and file header (but no grid)
      style = "numbers,changes,header";
      theme = "Dracula";
    };

    extraPackages = with pkgs.bat-extras; [
      batwatch
      batgrep # search through and highlight files using ripgrep
      batdiff # Diff a file against the current git index, or display the diff between to files - removed for error
      batman # read manpages using bat as the formatter
    ];
  };
}
