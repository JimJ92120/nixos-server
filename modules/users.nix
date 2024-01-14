let
  DEFAULT_USER_NAME = "host";
  DEFAULT_USER_PASSWORD = "123";
  DEFAULT_SSH_AUTHORIZED_KEY = "ssh-ed25519 SOME SSH PUBLIC KEY...";
in
{
  ### users
  users = {
    users = {
      "${DEFAULT_USER_NAME}" = {
        password = DEFAULT_USER_PASSWORD;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          DEFAULT_SSH_AUTHORIZED_KEY
        ];
      };
    };
    extraUsers = {
      # disable password login for root
      root = {
        password = "";
      };
    };

    groups = {
      "${DEFAULT_USER_NAME}" = {
        members = [
          DEFAULT_USER_NAME
        ];
      };
    };
    extraGroups = {
      "wheel" = {
        members = [
          DEFAULT_USER_NAME
        ];
      };
    };
  };
}
