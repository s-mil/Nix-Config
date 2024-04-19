{ config, pkgs, unstable, ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 950;
      height = 700;
      always_parse_args = true;
      show_all = false;
      print_command = true;
      insensitive = true;
      prompt = "Hmm, what do you want to run?";
    };

    style = ''
              /* Mocha Mauve */
      @define-color accent #cba6f7;
      @define-color txt #cad3f5;
      @define-color bg #24273a;
      @define-color bg2 #494d64;

       * {
          font-family: 'Hack Nerd Font', monospace;
          font-size: 16px;
       }

       /* Window */
       window {
          margin: 0px;
          padding: 10px;
          border: 3px solid @accent;
          border-radius: 7px;
          background-color: @bg;
          animation: slideIn 0.5s ease-in-out both;
       }

       /* Slide In */
       @keyframes slideIn {
          0% {
             opacity: 0;
          }

          100% {
             opacity: 1;
          }
       }

       /* Inner Box */
       #inner-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: @bg;
          animation: fadeIn 0.5s ease-in-out both;
       }

       /* Fade In */
       @keyframes fadeIn {
          0% {
             opacity: 0;
          }

          100% {
             opacity: 1;
          }
       }

       /* Outer Box */
       #outer-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: @bg;
       }

       /* Scroll */
       #scroll {
          margin: 0px;
          padding: 10px;
          border: none;
       }

       /* Input */
       #input {
          margin: 5px;
          padding: 10px;
          border: none;
          color: @accent;
          background-color: @bg2;
          animation: fadeIn 0.5s ease-in-out both;
       }

       /* Text */
       #text {
          margin: 5px;
          padding: 10px;
          border: none;
          color: @txt;
          animation: fadeIn 0.5s ease-in-out both;
       }

       /* Selected Entry */
       #entry:selected {
         background-color: @accent;
       }

       #entry:selected #text {
          color: @bg2;
       }
    '';
  };
}