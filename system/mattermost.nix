{pkgs, domain, port_mattermost,...}:
{
  services.mattermost = {
    enable = true;
    siteName = "Homelab";
    siteUrl = "https://chat.${domain}";

    extraConfig = {
      EmailSettings = {
        EnableSignUpWithEmail = false;
        EnableSignInWithEmail = true;
        EnableSignInWithUsername = false;
      };
      GitLabSettings= {
        Enable= true;
        Secret= "pKOPVDTif7qmjSQ9Fv8Cog1jbMEhWS2O";
        Id= "mattermost";
        Scope= "profile email";
        AuthEndpoint= "https://keycloak.homelab.com.hr/cloak/realms/homelab/protocol/openid-connect/auth";
        TokenEndpoint= "https://keycloak.homelab.com.hr/cloak/realms/homelab/protocol/openid-connect/token";
        UserAPIEndpoint= "https://keycloak.homelab.com.hr/cloak/realms/homelab/protocol/openid-connect/userinfo";
        DiscoveryEndpoint= "";
        ButtonText= "Login with Homelab";
        ButtonColor= "#ADD015";
      };
    };
  };
}
