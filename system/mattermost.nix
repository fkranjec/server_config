{pkgs, name, domain, port_mattermost,...}:
let
in
{
  services.mattermost = {
    enable = true;
    siteName = name;
    siteUrl = "https://chat.${domain}";
    environmentFile = /etc/nixos/secrets/gitlab;

    extraConfig = {
      EmailSettings = {
        EnableSignUpWithEmail = false;
        EnableSignInWithEmail = false;
        EnableSignInWithUsername = false;
      };
      GitLabSettings= {
        Enable= true;
        Secret= "$MM_GITLAB_SECRET";
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
