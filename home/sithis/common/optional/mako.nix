{ config, pkgs, ... }: {
  services.mako = {
    enable = true;

    ## Colors
    backgroundColor = "#1e1e2e";
    textColor="#cdd6f4";
    borderColor="#cba6f7";
    progressColor="over #313244";
    

    extraConfig=''
    [urgency=high]
    border-color=#fab387
    '';

  };
}
