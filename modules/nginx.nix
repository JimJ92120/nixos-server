# https://nixos.wiki/wiki/Nginx
{
  services.nginx = {
    enable = true;

    virtualHosts = {
      # prevent access host IP
      # use domain access instead
      "0.0.0.0" = {
        addSSL = false;
        enableACME = false;

        extraConfig = ''
          deny all;
        '';
      };

      # # main domain (entrypoint)
      # "nix-host" = {
      #   addSSL = false;
      #   enableACME = false;

      #   extraConfig = ''
      #     proxy_pass_header Authorization;
      #   '';

      #   basicAuth = {
      #     admin = "admin";
      #   };
      # };
    };
  };
}