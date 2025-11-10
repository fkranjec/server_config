{pkgs, ...}:
{
  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.homelab.com.hr";
    excalidraw.enable = true;
  };
   

  services.jitsi-videobridge.openFirewall = true;
}
