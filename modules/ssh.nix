let 
  # ssh
  SSH_PORT = 1234;
  ALLOWED_SSH_KEY_TYPES = [
    # ssh-ed25519
    "curve25519-sha256"
    "curve25519-sha256@libssh.org"
  ];
in
{
  ### ssh
  services.openssh = {
    # ssh is enabled by default
    # enable = false;
    ports = [ SSH_PORT ];

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      KexAlgorithms = ALLOWED_SSH_KEY_TYPES;
    };
  };
}
