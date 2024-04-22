{ lib, pkgs, ... }: {
  fonts.packages = with pkgs;
    [
      (nerdfonts.override {
        fonts = [ "Hack" "Iosevka" "FiraCode" "DroidSansMono" ];
      })
    ];
}
