{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
  ];

  imports = [ ./hardware-configuration.nix ./nginx.nix ./turn.nix ./mattermost.nix ./forgejo.nix ./keycloak.nix ./jitsi.nix];

  nix.settings = {
    experimental-features = "nix-command flakes";
  };
  
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.forgejo
    pkgs.keycloak
    pkgs.mattermost
  ];
  
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
  
  users.users = {
    root.hashedPassword = "!";
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

  security.acme = {
    acceptTerms = true;
    email = "filip.kranjec@gmail.com";
  };

  services.postgresql.enable = true;
   
  networking.firewall.allowedTCPPorts = [ 22 80 443 3478 5349 ];
  networking.firewall.allowedUDPPorts = [ 3478 5349];
  system.stateVersion = "25.05";
 }
