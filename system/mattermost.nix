{pkgs, domain, port_mattermost,...}:
{
  services.mattermost = {
    enable = true;
    siteName = "Homelab";
    siteUrl = "https://chat.${domain}";
  };
}
