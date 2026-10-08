{ pkgs, ... }:
{
  config = {
    redots.code.nix.enable = true;

    home.packages = with pkgs; [
      mitmproxy
      nixfmt
      unstable.julia
    ];

    services.podman = {
      enable = true;
    };

    programs.uv.enable = true;
  };
}
