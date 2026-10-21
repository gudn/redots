{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    redots.pcap = {
      enable = lib.mkEnableOption "pcap group";
      tcpdump.enable = lib.mkEnableOption "tcpdump integration";
      dumpcap.enable = lib.mkEnableOption "dumpcap (wireshark) integration";
    };
  };

  config = lib.mkIf config.redots.pcap.enable {
    users.groups.pcap = { };

    security.wrappers.dumpcap = lib.mkIf config.redots.pcap.dumpcap.enable {
      source = "${pkgs.wireshark}/bin/dumpcap";
      capabilities = "cap_net_raw,cap_net_admin+eip";
      owner = "root";
      group = "pcap";
      permissions = "u+rx,g+x";
    };

    security.wrappers.tcpdump = lib.mkIf config.redots.pcap.tcpdump.enable {
      source = lib.getExe pkgs.tcpdump;
      capabilities = "cap_net_raw+p";
      owner = "root";
      group = "pcap";
      permissions = "u+rx,g+x";
    };
  };
}
