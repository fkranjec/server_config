{ pkgs, ... }:
 
 {
   nix.settings = {
     experimental-features = "nix-command flakes";
   };
   
   environment.systemPackages = [
     pkgs.vim
     pkgs.git
     pkgs.forgejo
     pkgs.mattermost
     pkgs.keycloak
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
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."mattermost.homelab.com.hr" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
      proxyPass = "http://127.0.0.1:8065";
      proxyWebsockets = true;
      };
    };
    virtualHosts."forgejo.homelab.com.hr" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
      };
    };
    virtualHosts."keycloak.homelab.com.hr" = {
      enableACME = true;
      forceSSL = true;
      locations."/cloak/" = {
        proxyPass = "http://127.0.0.1:38080/cloak/";
      };
    };
  };

services.postgresql.enable = true;
security.acme = {
  acceptTerms = true;
  email = "filip.kranjec@gmail.com";  # For Let's Encrypt
};

services.mattermost = {
  enable = true;
  siteUrl = "https://mattermost.homelab.com.hr";
};

  services.forgejo = {
    enable = true;
    database = {
      type = "postgres";
    };
    lfs.enable = true;
    stateDir = "/var/lib/forgejo";
    settings = {
      
      ui = {
        DEFAULT_THEME = "auto";
      };

      server = {
        DOMAIN = "homelab.com.hr";
        ROOT_URL = "https://forgejo.homelab.com.hr";
        HTTP_PORT = 3000;
      };

      # service.DISABLE_REGISTRATION = true; 

      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
    };
  };


  services.keycloak = {
    enable = true;

    database = {
      type = "postgresql";
      createLocally = true;
      username = "admin";
      passwordFile = "/etc/nixos/secrets/keycloak";
    };

    initialAdminPassword = "/etc/nixos/secrets/keycloak";

    settings = {
      hostname = "keycloak.homelab.com.hr";
      http-relative-path = "/cloak";
      http-port = 38080;
      proxy-headers = "xforwarded";
      http-enabled = true;
    };
    
  };
   
   networking.firewall.allowedTCPPorts = [ 22 80 443 ];
   
   system.stateVersion = "24.11";
 }
