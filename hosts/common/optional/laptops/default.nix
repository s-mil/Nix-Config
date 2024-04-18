{ inputs, outputs, ... }:
{
  imports = [
    ./laptop.nix
    ./keymap.nix

  ] ++ (builtins.attrValues outputs.nixosModules);
}
