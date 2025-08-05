{ pkgs, ... }:
 
 {
   nix.settings = {
     experimental-features = "nix-command flakes";
   };
   
   environment.systemPackages = [
     pkgs.vim
     pkgs.git
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

   services.nginx = {
  enable = true;

  virtualHosts."test-server-vps.work.gd" = {
    enableACME = true;
    forceSSL = true;

    locations."/" = {
      proxyPass = "http://127.0.0.1:3000";
      proxyWebsockets = true;
    };
  };
};

security.acme = {
  acceptTerms = true;
  email = "you@example.com";  # For Let's Encrypt
};

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    # Enable support for Git Large File Storage
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "test-server-vps.work.gd";
        ROOT_URL = "https://test-server-vps.work.gd/";
        HTTP_ADDR = "127.0.0.1";  # only accessible by Nginx
        HTTP_PORT = 3000;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = false; 
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
        SMTP_ADDR = "mail.example.com";
        FROM = "noreply@test-server-vps.work.gd";
        USER = "noreply@test-server-vps.work.gd";
      };
    };
  };
   
   networking.firewall.allowedTCPPorts = [ 22 80 443 ];
   
   system.stateVersion = "24.11";
 }
