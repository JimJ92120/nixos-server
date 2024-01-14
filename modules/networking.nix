{ lib, ... }:

let
  HOST_NAME = "host";

  DEFAULT_GATEWAY_INTERFACE = "DefaultEth0";
  DEFAULT_GATEWAY_ADDRESS = "10.100.1.1";
  LOOPBACK_INTERFACE = "lo";

  ADDRESS_LIST = [
    # static IP to assign
    {
      address = "10.100.10.1";
      prefixLength = 8;
    }
  ];
in
{
  networking = {
    hostName = HOST_NAME;
    nameservers = [
      "1.1.1.1" # cloudfare
      "8.8.8.8" # google, also 4.4.4.4
    ];

    useDHCP = lib.mkForce false;

    defaultGateway = {
      address = DEFAULT_GATEWAY_ADDRESS;
      interface = DEFAULT_GATEWAY_INTERFACE;
    };

    interfaces."${DEFAULT_GATEWAY_INTERFACE}" = {
      useDHCP = lib.mkForce false;
      ipv4.addresses = ADDRESS_LIST;
    };

    firewall = {
      enable = true;

      # set empty and force to declare per interface
      allowedTCPPorts = [];
      allowedUDPPortRanges = [];

      interfaces = {
        "${DEFAULT_GATEWAY_INTERFACE}" = {
          allowedTCPPorts = [
            80
            # 443 # SSL
            1234 # SSH_PORT
          ];
          allowedUDPPortRanges = [];
        };

        "${LOOPBACK_INTERFACE}" = {
          allowedTCPPorts = [
            80
            # 443 # SSL
            3000 # app-2
          ];
          allowedUDPPortRanges = [];
        };
      };
    };
  };
}