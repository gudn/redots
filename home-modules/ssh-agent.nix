{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.ssh-agent.enable = lib.mkEnableOption "Enable ssh-agent";
  };

  config = lib.mkIf config.redots.ssh-agent.enable {
    systemd.user.sessionVariables = {
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    };

    systemd.user.services.ssh-agent = {
      Unit = {
        Description = "SSH authentication agent";
        Documentation = "man:ssh-agent(1)";
      };

      Service = {
        ExecStart = "${pkgs.openssh}/bin/ssh-agent -D -a %t/ssh-agent";
      };

      Install.WantedBy = [ "default.target" ];
    };
  };
}
