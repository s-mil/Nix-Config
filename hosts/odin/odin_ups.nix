{ inputs, pkgs, ... }: let 
  vid = "0764";
  pid = "0601";

in {

power.ups = {
  enable = true;
  mode = "standalone";
    ups.cyberpower = {
      # find your driver here:
      # https://networkupstools.org/docs/man/usbhid-ups.html
      driver = "usbhid-ups";
      description = "CP1500 AVR UPS";
      port = "auto";
      directives = [
        "vendorid = ${vid}"
        "productid = ${pid}"
        "offdelay = 60"
        "ondelay = 120"
      ];
      # this option is not valid for usbhid-ups
      maxStartDelay = null;
    };
    maxStartDelay = 10;
  };


    users = {
    users.nut = {
      isSystemUser = true;
      group = "nut";
      # it does not seem to do anything with this directory
      # but something errored without it, so whatever
      home = "/var/lib/nut";
      createHome = true;
    };
    groups.nut = { };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="${vid}", ATTRS{idProduct}=="${pid}", MODE="664", GROUP="nut", OWNER="nut"
  '';


}
