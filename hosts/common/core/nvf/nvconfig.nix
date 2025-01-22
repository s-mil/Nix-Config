{ pkgs, lib, ... }:
{
  programs.nvf = {
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    enableManpages = true;
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      useSystemClipboard = true;
      spellcheck = {
        enable = true;
        languages = ["en"];
      };
      theme = {
        enable = true;
        name = "catppuccin";
        style = "dark";
      };

      languages = {
        enableTreesitter = true;
        enableDAP = true;
        enableFormat = true;
        enableLSP = true;
        
        nix.enable = true;
        csharp = {
          enable = true;
          lsp.server = "omnisharp";
        };
        go = {
          enable = true;
        };

        markdown.enable = true;
        python.enable = true;
        rust = {
          enable = true;
          crates.enable = true;
        };

        ts.enable = true;
      };

      statusLine.lualine.enable = true;
      autocomplete.nvim-cmp.enable = true;
    };
  };
}
