{ inputs, outputs, ... }: {
  imports = [
    ./laptop.nix
    # ./keymap.nix not sure why this nolonger works

  ] ++ (builtins.attrValues outputs.nixosModules);
}
