{pkgs, name, secrets, domain, port_mattermost,...}:
{
  services.mattermost = {
    enable = true;
    siteName = name;
    siteUrl = "https://chat.${domain}";
    environmentFile = /var/secrets/gitlab.env;

    extraConfig = {
      EmailSettings = {
        EnableSignUpWithEmail = false;
        EnableSignInWithEmail = false;
        EnableSignInWithUsername = false;
      };
      GitLabSettings= {
        Enable= true;
        Secret= builtins.readFile "${secrets}/mattermost_secret";
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
