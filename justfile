############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

# Default recipe to display help information
default:
  @just --list

# List all recipes
list:
  @just --list


# Run ci for all files using pre-commit
ci-all:
  pre-commit run --all-files

update:
	nix flake update

update-nix-vim:
 (cd ~/git/nix-vim && git fetch && git rebase) || true
 nix flake lock --update-input nixvim
 just nh
update-nix-secrets:
 (cd ~/git/nix-secrets && git fetch && git rebase) || true
 nix flake lock --update-input nix-secrets
 just nh

nh:
	nh os switch

nh-update:
	nh os switch -u

nh-remote-update:
  nh os switch -u -- -j0
nh-remote:
  nh os switch -- -j0


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


history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

	# garbage collect all unused nix store entries
	sudo nix store gc --debug
