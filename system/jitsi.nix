{pkgs, ...}:
{
  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.homelab.com.hr";
  };

  services.jitsi-videobridge.openFirewall = true;
}
