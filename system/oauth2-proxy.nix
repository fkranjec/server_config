{pkgs, ...}:
{
services.oauth2-proxy = {
    enable = true;
    # oauth2-proxy listens on 127.0.0.1:4180 by default
    # Use the "settings" (or "extraConfig" on older releases) to pass flags.
    keyFile ="/var/secrets/oauth2-proxy";
    settings = {
      provider = "oidc";
      oidc_issuer_url = "https://keycloak.homelab.com.hr/realms/homelab";
      client_id = "nginx";
      redirect_url = "https://jitsi.homelab.com.hr/oauth2/callback";

      email_domains = [ "*" ];
      scope = "openid email profile";
      reverse_proxy = true;
      # Make cookies secure in production
      cookie_secure = true;

      # (Optional) allow only specific groups from Keycloak, if you add group claim
      # allowed_groups = [ "myrealm:team-admins" "myrealm:team-users" ];
    };
  };
}
