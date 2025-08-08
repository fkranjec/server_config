{pkgs, domain, port_mattermost,...}:
{
  services.mattermost = {
    enable = true;
    siteName = "Homelab";
    siteUrl = "https://chat.${domain}";

    extraConfig = {
      GitLabSettings= {
        Enable= true;
        Secret= "pKOPVDTif7qmjSQ9Fv8Cog1jbMEhWS2O";
        Id= "mattermost";
        Scope= "";
        AuthEndpoint= "http://keycloak.homelab.com.hr/cloak/realms/homelab/protocol/openid-connect/auth";
        TokenEndpoint= "http://keycloak.homelab.com.hr/cloak/realms/homelab/protocol/openid-connect/token";
        UserAPIEndpoint= "http://keycloak.homelab.com.hr/cloak/realms/homelab/protocol/openid-connect/userinfo";
        DiscoveryEndpoint= "http://keycloak.homelab.com.hr/cloak/realms/homelab/.well-known/openid-configuration";
        ButtonText= "Login with ICRC Keycloak";
        ButtonColor= "#ADD015";
      };
    };
  };
}
