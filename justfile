############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

thor:
	nixos-rebuild switch --flake .#thor --use-remote-sudo

debugThor:
	nixos-rebuild switch --flake .#thor --use-remote-sudo --show-trace --verbose

mjolnr:
	nixos-rebuild switch --flake .#mjolnr --use-remote-sudo

debugMjolnr:
	nixos-rebuild switch --flake .#mjolnr --use-remote-sudo --show-trace --verbose

update:
	nix flake update

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

	# garbage collect all unused nix store entries
	sudo nix store gc --debug

