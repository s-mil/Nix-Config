{ pkgs, lib, ... }:
{
  programs.nvf = {
    defaultEditor = true;
    enableManpages = true;
    enable = true;
    settings.vim = {
      statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };
      nvim-autopairs.enable = true;
      visuals = {
        nvim-web-devicons.enable = true;
        nvim-scrollbar.enable = true;
        cellular-automaton.enable = false;
        highlight-undo.enable = true;

        indent-blankline = {
          enable = true;
        };

        nvim-cursorline = {
          enable = true;
          setupOpts = {
            line_timeout = 0;
          };
        };

        fidget-nvim = {
          enable = true;
          setupOpts = {
            notification.window = {
              winblend = 0;
              border = "none";
            };
          };
        };
      };

      autocomplete.nvim-cmp = {
        enable = true;
        mappings = {
          close = "<C-e>";
          confirm = "<C-y>";
          next = "<C-n>";
          previous = "<C-p>";
          scrollDocsDown = "<C-j>";
          scrollDocsUp = "<C-k>";
        };
      };

      package = pkgs.neovim-unwrapped;
      viAlias = true;
      vimAlias = true;
      useSystemClipboard = true;
      spellcheck = {
        enable = true;
        languages = [ "en" ];
      };
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
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

    };
  };
}
