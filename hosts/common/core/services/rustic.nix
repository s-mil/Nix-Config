{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [ rustic ];

  users.users.rustic = {
    isNormalUser = true;
  };

  security.wrappers.rustic = {
    source = "${pkgs.rustic.out}/bin/rustic";
    owner = "rustic";
    group = "users";
    permissions = "u=rwx,g=,o=";
    capabilities = "cap_dac_read_search=+ep";
  };
}
