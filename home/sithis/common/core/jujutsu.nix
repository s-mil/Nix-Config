{ config, pkgs, unstable, ... }: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Sam Miller";
        email = "23262411+s-mil@users.noreply.github.com";
      };
    };
  };

}
