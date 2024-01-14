{ pkgs, ... }:

let
  APP_1 = ./app-1;
  APP_2 = ./app-2;

  APP_1_DIRECTORY = "/var/www/app-1";
  APP_2_DIRECTORY = "/var/www/app-2";
in
{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
  ];

  # create sites directory
  # in /var/www/${site}
  system.activationScripts = {
    init-sites = {
      text = ''
        mkdir -p ${APP_1_DIRECTORY} ${APP_2_DIRECTORY}

        # copy sites directories
        cp -r ${APP_1}/* ${APP_1_DIRECTORY}
        cp -r ${APP_2}/* ${APP_2_DIRECTORY}

        # build in store
        ${pkgs.yarn}/bin/yarn --cwd ${APP_2} install
      '';
    };
  };

  # service to
  # build and start node app
  systemd.services.run-sites = {
    wantedBy = [ "multi-user.target" ];
    requires = [
      "nginx.service"
    ];
    after = [
      "nginx.service"
    ];

    script = ''
      ${pkgs.yarn}/bin/yarn --cwd ${APP_2_DIRECTORY} install
      ${pkgs.yarn}/bin/yarn --cwd ${APP_2_DIRECTORY} start
    '';

    serviceConfig = {
      Type = "oneshot";
    };
  };

  # nginx hosts
  services.nginx = {
    virtualHosts = {
      # app-1
      "app-1.nix-host" = {
        addSSL = false;
        enableACME = false;
        root = "/var/www/app-1";
      };

      # app-2
      "app-2.nix-host" = {
        addSSL = false;
        enableACME = false;

        locations = {
          "/" = {
            proxyPass = "http://localhost:3000";
          };
        };
      };
    };
  };
}