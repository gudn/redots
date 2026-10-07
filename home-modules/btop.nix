{
  lib,
  config,
  ...
}:
{
  options = {
    redots.btop.enable = lib.mkEnableOption "btop";
  };

  config = lib.mkIf config.redots.btop.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark_v2";
        presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default";
        proc_sorting = "cpu lazy";
        show_disks = false;
        cpu_single_graph = true;
        cpu_graph_upper = "total";
      };
    };
  };
}
