{domain, name, port_forgejo, pkgs, lib, utils, config, ...}:
let
  runnerRole = "gitea-actions-runner";
  runners = config.machines.roles.${runnerRole};
in
{
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
        AUTHOR = name;
        DESCRIPTION = name;
      };

      server = {
        DOMAIN = "forgejo.${domain}";
        ROOT_URL = "https://forgejo.${domain}";
        HTTP_PORT = port_forgejo;
      };

      service.ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
      service.ALLOW_ONLY_EXTERNAL_LOGIN = true;
      
    };
  };
  



  users.groups.gitea-runner = {};

  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.angular = {
      enable = true;
      name = "angular";
      url = "https://forgejo.homelab.com.hr";
      tokenFile = "/var/secrets/angular";
      labels = [
        "angular"
        "nixos:host"
      ];
      hostPackages = with pkgs; [
        bash
        coreutils
        curl
        gawk
        gitMinimal
        gnused
        nodejs
        wget
        nixVersions.stable
      ];
    };
    instances.erlang = {
      enable = true;
      name = "erlang";
      url = "https://forgejo.homelab.com.hr";
      tokenFile = "/var/secrets/erlang";
      labels = [
        "erlang"
        "native:host"
      ];
      hostPackages = with pkgs; [
        bash
        coreutils
        curl
        gawk
        gitMinimal
        gnused
        wget
        erlang_27
      ];
    };
  };

  systemd.services.gitea-runner-angular.serviceConfig.DynamicUser = lib.mkForce false;

  users.users.gitea-runner = {
    home = "/var/lib/gitea-runner";
    group = "gitea-runner";
    isSystemUser = true;
    createHome = true;
    extraGroups = ["gitea-runner"];
  };

  users.groups.gitea-runner={};

  systemd.tmpfiles.rules = [
     "d /var/www 0770 root gitea-runner -"
   ];
  
}
