{ lib, config, ... }:
{
  options = {
    my.laptop.enable = lib.mkEnableOption "Enable laptop services";
  };

  config = lib.mkIf config.my.laptop.enable {
    powerManagement.enable = true;
    services.upower = {
      enable = true;
      usePercentageForPolicy = true;
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        Policy.AutoEnable = true;
      };
    };

    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      SleepOperation = "suspend";
      HandlePowerKey = "suspend";
      HandlePowerKeyLongPress = "poweroff";
    };

    hardware = {
      steam-hardware.enable = true;
    };
  };
}
