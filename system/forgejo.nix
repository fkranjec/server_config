{domain, name, port_forgejo, pkgs, utils, ...}:
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
 # systemd.tmpfiles.rules = [
 #    "d /srv/gitea-runner 0770 gitea-runner gitea-runner -"
 #  ];

  systemd.services."gitea-runner-angular".serviceConfig = {
    StateDirectory= "gitea-runner";
    CacheDirectory= "gitea-runner";
    ReadWritePaths = "/var";
  };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.angular = {
      enable = true;
      name = "angular";
      url = "https://forgejo.homelab.com.hr";
      tokenFile = "/var/secrets/angular";
      labels = [
        "angular"
        "native:host"
      ];
      settings = {
        host = {
          workdir_parent = "/var/lib/gitea-runner/angular";
        };
      };
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
}
