{domain,port_keycloak, secrets, ...}:
{
  services.keycloak = {
    enable = true;

    database = {
      type = "postgresql";
      createLocally = true;
      username = "admin";
      passwordFile = "${secrets}/keycloak";
    };

    initialAdminPassword = "${secrets}/keycloak";

    settings = {
      hostname = "keycloak.${domain}";
      http-relative-path = "/cloak";
      http-port = port_keycloak;
      proxy-headers = "xforwarded";
      http-enabled = true;
    };
  };
}
