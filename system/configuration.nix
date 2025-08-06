{ pkgs, ... }:
 
 {
   nix.settings = {
     experimental-features = "nix-command flakes";
   };
   
   environment.systemPackages = [
     pkgs.vim
     pkgs.git
     pkgs.forgejo
   ];
   
   fileSystems."/" = {
     device = "/dev/disk/by-label/nixos";
     fsType = "ext4";
   };
   fileSystems."/boot" = {
     device = "/dev/disk/by-label/boot";
     fsType = "ext4";
   };
   swapDevices = [
     {
       device = "/dev/disk/by-label/swap";
     }
   ];
   
   time.timeZone = "Europe/London";
   i18n.defaultLocale = "en_US.UTF-8";
   console.keyMap = "us";
   
   boot.loader.grub.enable = true;
   boot.loader.grub.device = "/dev/sda";
   boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "ext4" ];
   
   users.users = {
     root.hashedPassword = "!"; # Disable root login
     fkranjec = {
       isNormalUser = true;
       extraGroups = [ "wheel" ];
       openssh.authorizedKeys.keys = [
         "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTUwtGKHfjkHg63FEVXus1chWzB4gP9wQavFwAtoAOL"
       ];
     };
   };
   
   security.sudo.wheelNeedsPassword = false;
   
   services.openssh = {
     enable = true;
     settings = {
       PermitRootLogin = "no";
       PasswordAuthentication = false;
       KbdInteractiveAuthentication = false;
     };
   };

#    services.nginx = {
#     enable = true;
#
#     virtualHosts."homelab.com.hr" = {
#       enableACME = true;
#       forceSSL = true;
#
#       locations."/" = {
#         proxyPass = "http://127.0.0.1:3000";
#         proxyWebsockets = true;
#       };
#     };
#
#   recommendedProxySettings = true;
#   recommendedTlsSettings = true;
#   virtualHosts = {
#     # Replace with the domain from your siteUrl
#     "default" = {
#       forceSSL = true; # Enforce SSL for the site
#       enableACME = true; # Enable SSL for the site
#       locations."/" = {
#         proxyPass = "http://127.0.0.1:8065"; # Route to Mattermost
#         proxyWebsockets = true;
#       };
#     };
#   };
# };

security.acme = {
  acceptTerms = true;
  email = "filip.kranjec@gmail.com";  # For Let's Encrypt
};

services.mattermost = {
  enable = true;
  siteUrl = "http://91.99.160.220:8065";
};

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    # Enable support for Git Large File Storage
    lfs.enable = true;
    settings = {
      ui = {
        DEFAULT_THEME = "auto";
      };
      server = {
        DOMAIN = "91.99.160.220";
        ROOT_URL = "http://91.99.160.220:3000/";
        HTTP_ADDR = "127.0.0.1";  # only accessible by Nginx
        HTTP_PORT = 3000;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = true; 
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      # Sending emails is completely optional
      # You can send a test email from the web UI at:
      # Profile Picture > Site Administration > Configuration >  Mailer Configuration 
      mailer = {
        ENABLED = true;
        SMTP_ADDR = "smtp.gmail.com";
        FROM = "filip.kranjec@gmail.com";
        USER = "filip.kranjec@gmail.com";
      };
    };
  };
   
   networking.firewall.allowedTCPPorts = [ 22 80 443 ];
   
   system.stateVersion = "24.11";
 }
