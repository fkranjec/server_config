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

    virtualHosts."jitsi.${domain}" = {
      enableACME = true;
      forceSSL = true;
      locations = {
        "/oauth2/" = {
          proxyPass = "http://127.0.0.1:4180";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Scheme $scheme;
            proxy_set_header X-Auth-Request-Redirect $request_uri;
          '';
        };
        "/" = {
          extraConfig = ''
            auth_request /oauth2/auth;

            error_page 401 = /oauth2/sign_in;

            auth_request_set $user  $upstream_http_x_auth_request_user;
            auth_request_set $email $upstream_http_x_auth_request_email;
            auth_request_set $groups $upstream_http_x_auth_request_groups;

            proxy_set_header X-User   $user;
            proxy_set_header X-Email  $email;
            proxy_set_header X-Groups $groups;

            add_header Set-Cookie $upstream_http_set_cookie;
            '';
        };
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
