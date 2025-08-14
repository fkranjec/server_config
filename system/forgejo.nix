{domain, name, port_forgejo, pkgs, ...}:
{
  services.forgejo = {
    enable = true;
    database = {
      type = "postgres";
    };
    lfs.enable = true;
    stateDir = "/var/lib/forgejo";
    settings = {
      
      ui = {
        DEFAULT_THEME = "auto";
        AUTHOR = name;
        DESCRIPTION = name;
      };

      server = {
        DOMAIN = "forgejo.${domain}";
        ROOT_URL = "https://forgejo.${domain}";
        HTTP_PORT = port_forgejo;
      };

      service.ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
      service.ALLOW_ONLY_EXTERNAL_LOGIN = true;
      
    };
  };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.default = {
      enable = true;
      name = "angular";
      url = "https://forgejo.homelab.com.hr";
      tokenFile = "/var/secrets/angular";
      labels = [
        "angular"
        "native:host"
      ];
      hostPackages = with pkgs; [
        nodejs_22
      ];
    };
    # instances.erlang = {
    #   enable = true;
    #   name = "erlang";
    #   url = "https://forgejo.homelab.com.hr";
    #   tokenFile = "/var/secrets/erlang";
    #   labels = [
    #     "erlang"
    #     "native:host"
    #   ];
    #   hostPackages = with pkgs; [
    #     nodejs_20
    #   ];
    # };
  };
}
