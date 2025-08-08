{pkgs, domain, port_mattermost,...}:
{
  services.mattermost = {
    enable = true;
    siteName = "Homelab";
    siteUrl = "https://chat.${domain}";
    configurationFile = "/etc/nixos/secrets/mattermost_config.json";
  };
}
