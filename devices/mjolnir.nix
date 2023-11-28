let

  Hostname = "mjolnir";

in
{
    networking =
    {
      hostName = Hostname;
      hostId = "007f0200";
      firewall.enable = false;
      interfaces= {
        enp6s18 = {
          useDHCP = false;
          ipv4.addresses = [ {
            address = "10.10.0.13";
            prefixLength = 16;
          } ];
        };
      };
      defaultGateway = "10.10.0.1";
      nameservers = [ "10.40.0.2" ];
    };

    imports =
    [
        ../bootloaders/grub.nix
        ../displayManager/sddm.nix
        ../desktopEnvironment/xfce4.nix
        ../users/root/user.nix
        ../users/sithis/user.nix
    ];
  

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };


  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  virtualisation.docker = {
    enable= true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };




}
