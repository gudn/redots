{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs; [
      clang
      clang-tools
      cutter
      cutterPlugins.sigdb
      gdb
      go
      gopls
      gradle_9
      jdk
      lldb
      mitmproxy
      nixfmt-rfc-style
      nodejs_24
      qemu
      rizin
      rizinPlugins.rz-ghidra
      valgrind
      (python314.withPackages (
        ps: with ps; [
          numpy
          requests
        ]
      ))
      (rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-docs"
          "rust-analyzer"
          "clippy"
          "rustfmt"
        ];
      })
    ];

    services.podman = {
      enable = true;
    };

    xdg.configFile = {
      "rustfmt/rustfmt.toml".source = (pkgs.formats.toml { }).generate "rustfmt-config" {
        tab_spaces = 2;
      };
    };
  };
}
