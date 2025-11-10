{pkgs, ...}:
{
  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.homelab.com.hr";
    excalidraw.enable = true;
    config = {
      whiteboard = {
        enabled = true;
        collabServerBaseUrl = "https://jitsi.homelab.com.hr";
      };
      toolbarButtons = [
        "microphone"
        "camera"
        "desktop"
        "chat"
        "whiteboard"
        "raisehand"
        "tileview"
        "hangup"
      ];
    };
  };
   

  services.jitsi-videobridge.openFirewall = true;
}
