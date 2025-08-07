{domain, port_forgejo, ...}:
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
        AUTHOR = "Homelab";
        DESCRIPTION = "Homelab";
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
}
