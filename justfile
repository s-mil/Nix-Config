############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

thor:
	nixos-rebuild switch --flake .#thor --use-remote-sudo

debugThor:
	nixos-rebuild switch --flake .#thor --use-remote-sudo --show-trace --verbose
freya:
	nixos-rebuild switch --flake .#freya --use-remote-sudo

debugFreya:
	nixos-rebuild switch --flake .#freya --use-remote-sudo --show-trace --verbose

mjolnir:
	nixos-rebuild switch --flake .#mjolnir --use-remote-sudo

debugmjolnir:
	nixos-rebuild switch --flake .#mjolnir --use-remote-sudo --show-trace --verbose

odin:
	nixos-rebuild switch --flake .#odin --use-remote-sudo

debugOdin:
	nixos-rebuild switch --flake .#odin --use-remote-sudo --show-trace --verbose

update:
	nix flake update

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

	# garbage collect all unused nix store entries
	sudo nix store gc --debug
