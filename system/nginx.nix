{domain, port_forgejo, port_keycloak, port_turn, port_mattermost, ...}:
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

    virtualHosts."chat.${domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "${localhost}:${toString port_mattermost}";
        proxyWebsockets = true;
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
