{...}:{
  services.github-runners = {
  runner1 = {
    enable = true;
    name = "Generic-smil";
    tokenFile = "/secrets/token1";
    url = "https://github.com/s-mil";
  };

};
}
