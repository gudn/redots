{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.flipperzero.enable = lib.mkEnableOption "flipperzero udev rules";
  };

  config = lib.mkIf config.redots.flipperzero.enable {
    warnings = lib.mkIf (!config.redots.desktop.enable) [
      "FlipperZero udev rules enabled without desktop"
    ];

    services.udev.extraRules = ''
      #Flipper Zero serial port
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", ATTRS{manufacturer}=="Flipper Devices Inc.", TAG+="uaccess", GROUP="dialout"
      #Flipper Zero DFU
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", ATTRS{manufacturer}=="STMicroelectronics", TAG+="uaccess", GROUP="dialout"
      #Flipper ESP32s2 BlackMagic
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="40??", ATTRS{manufacturer}=="Flipper Devices Inc.", TAG+="uaccess", GROUP="dialout"
      #Flipper U2F
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5741", ATTRS{manufacturer}=="Flipper Devices Inc.", ENV{ID_SECURITY_TOKEN}="1"
    '';
  };
}
