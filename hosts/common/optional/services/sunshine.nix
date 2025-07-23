{  unstable, ... }:
{
  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    package = unstable.sunshine.override { cudaSupport = true; };

  };

}
