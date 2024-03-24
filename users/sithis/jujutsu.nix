{ config, pkgs, unstable, ... }: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Sam Miller";
        email = "smiller2033@outlook.com";
      };
    };
  };

}
