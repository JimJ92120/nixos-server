{ pkgs ? import <nixpkgs> {}, ... }:

let
  NIXOS_VERSION = "23.11";
in
{
  imports = [
    ./modules/users.nix
    ./modules/networking.nix
    ./modules/ssh.nix
    ./modules/nginx.nix

    ./sites/sites.nix
  ];

  system.stateVersion = NIXOS_VERSION;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.isContainer = true;

  environment.systemPackages = with pkgs; [
    # utils
    htop
    nano
    git
    nmap
    nettools
    iputils
    unzip
  ];
}
