{domain, port_forgejo, port_keycloak, port_turn, port_mattermost, ...}:
let
  localhost = "http://127.0.0.1";
in
{

  users.users.nginx = {
    extraGroups = ["gitea-runner"];
  };
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."tft.${domain}" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/tft_stats/browser";
      locations."/" = {
        index = "index.html";
      };
      
    };

    virtualHosts."tft-gzip.${domain}" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/tft_stats/browser";
      locations."/" = {
        index = "index.html";
      };
      extraConfig = ''
        gzip on;
        gzip_static on;
        gzip_comp_level 5;
        gzip_min_length 256;
        gzip_vary on;
        gzip_types
          text/plain
          text/css
          text/javascript
          application/json
          application/javascript
          application/x-javascript
          text/xml
          application/xml
          application/xml+rss
          application/xhtml+xml
          application/font-woff2
          image/svg+xml;

        # Angular SPA fallback
        try_files $uri $uri/ /index.html;
      '';
    };

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
        extraConfig = ''
        rewrite ^/user/login$ /user/oauth2/homelab;
        '';
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
