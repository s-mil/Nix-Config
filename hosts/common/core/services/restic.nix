{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ restic ];

  users.users.restic = { isNormalUser = true; };

  security.wrappers.restic = {
    source = "${pkgs.rustic.out}/bin/restic";
    owner = "restic";
    group = "users";
    permissions = "u=rwx,g=,o=";
    capabilities = "cap_dac_read_search=+ep";
  };
}
