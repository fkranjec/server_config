{pkgs, name, domain, port_mattermost,...}:
{
  services.mattermost = {
    enable = true;
    siteName = name;
    siteUrl = "https://chat.${domain}";

    extraConfig = {
      EmailSettings = {
        EnableSignUpWithEmail = false;
        EnableSignInWithEmail = false;
        EnableSignInWithUsername = false;
      };
      GitLabSettings= {
        Enable= true;
        Secret= builtins.readFile /etc/nixos/secrets/gitlab;
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
