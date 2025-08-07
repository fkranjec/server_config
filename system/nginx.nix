{domain, port_forgejo, port_keycloak, port_turn, port_matrix, ...}:
let
  localhost = "http://127.0.0.1";
in
{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."matrix.${domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "${localhost}:${toString port_matrix}";
        proxyWebsockets = true;
      };
    };
    virtualHosts."chat.${domain}" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/element";
      locations."/" = {
        index = "index.html";
      };
    };
    virtualHosts."forgejo.${domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "${localhost}:${toString port_forgejo}";
        proxyWebsockets = true;
      };
    };
    virtualHosts."keycloak.${domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/cloak/" = {
        proxyPass = "${localhost}:${toString port_keycloak}/cloak/";
      };
    };
    virtualHosts."turn.${domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "${localhost}:${toString port_turn}";
      };
    };
  };
}
