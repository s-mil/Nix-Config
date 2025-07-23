{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];
}
