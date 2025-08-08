{pkgs, name, domain, port_mattermost,...}:
let
in
{
  services.mattermost = {
    enable = true;
    siteName = name;
    siteUrl = "https://chat.${domain}";
    environmentFile = /etc/nixos/secrets/gitlab.env;

    extraConfig = {
      EmailSettings = {
        EnableSignUpWithEmail = false;
        EnableSignInWithEmail = false;
        EnableSignInWithUsername = false;
      };
      GitLabSettings= {
        Enable= true;
        Secret= "pKOPVDTif7qmjSQ9Fv8Cog1jbMEhWS2O";
        Id= "mattermost";
        Scope= "profile email";
        AuthEndpoint= "https://keycloak.${domain}/cloak/realms/homelab/protocol/openid-connect/auth";
        TokenEndpoint= "https://keycloak.${domain}/cloak/realms/homelab/protocol/openid-connect/token";
        UserAPIEndpoint= "https://keycloak.${domain}/cloak/realms/homelab/protocol/openid-connect/userinfo";
        DiscoveryEndpoint= "";
        ButtonText= "Login with ${name}";
        ButtonColor= "#ADD015";
      };
    };
  };
}
