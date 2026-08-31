{ pkgs, ... }:
{
  config = {
    home.packages =
      let
        rust = (
          pkgs.rust-bin.stable.latest.default.override {
            extensions = [
              "rust-src"
              "rust-docs"
              "rust-analyzer"
              "clippy"
              "rustfmt"
            ];
          }
        );
      in
      with pkgs;
      [
        clang
        clang-tools
        gdb
        go
        gopls
        gradle_9
        jdk25
        lldb
        mitmproxy
        nixfmt
        nodejs_24
        rizin
        rizinPlugins.rz-ghidra
        rust
      ];

    services.podman = {
      enable = true;
    };

    programs.uv.enable = true;

    xdg.configFile = {
      "rustfmt/rustfmt.toml".source = (pkgs.formats.toml { }).generate "rustfmt-config" {
        tab_spaces = 2;
      };
    };
  };
}
