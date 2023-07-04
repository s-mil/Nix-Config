


# Usage

    Run `sudo nixos-rebuild switch --flake .#hostname` to apply your system configuration.
        If you're still on a live installation medium, run nixos-install --flake .#hostname instead, and reboot.
    Run `home-manager switch --flake .#username@hostname` to apply your home configuration.
        If you don't have home-manager installed, try nix shell nixpkgs#home-manager.

Based on [this starter config](https://github.com/Misterio77/nix-starter-configs/tree/main)
