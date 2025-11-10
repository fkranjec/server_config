{pkgs, ...}:
{
  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.homelab.com.hr";
    excalidraw.enable = true;
    config = {
      whiteboard = {
        enabled = true;
        # Jitsi expects the collab server base URL here
        collabServerBaseUrl = "https://jitsi.homelab.com.hr";
      };
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
