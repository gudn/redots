{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "udn-laptop";

  my = {
    desktop.enable = true;
    laptop.enable = true;
  };

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    modesetting.enable = true;
    powerManagement.enable = false;

    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:3:0:0";
    };
  };

  users.users.udn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
    ];
  };
  home-manager.users.udn = ./home;

  system.stateVersion = "25.05";
}
