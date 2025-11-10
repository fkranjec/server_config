{pkgs, ...}:
{
  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.homelab.com.hr";
    excalidraw.enable = true;
    config = {
      # If you define toolbarButtons anywhere, ensure 'whiteboard' is in there.
      # If you DON'T set toolbarButtons at all, leave this out.
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
