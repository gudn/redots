# redots

![readme.png](./screenshots/readme.png)

My personal NixOS configuration, shared across all my Linux devices.

This flake exposes a single module, `redots.nixosModules.default`,
which includes all configurations behind feature gates. For example,
in my private configuration, I simply import this flake and apply its
main module to all target systems.

## Desktop Features

For the desktop environment:
- [Niri](https://github.com/niri-wm/niri), a scrolling compositor
- [Noctalia](https://github.com/noctalia-dev/noctalia), a desktop shell
- [Kitty](https://github.com/kovidgoyal/kitty), a terminal emulator

## Terminal Utilities

For the terminal environment:
- [Fish](https://github.com/fish-shell/fish-shell), a command-line shell
- [nnn](https://github.com/jarun/nnn), a terminal file manager
- [direnv](https://github.com/direnv/direnv) with [nix-direnv](https://github.com/nix-community/nix-direnv) for environment management
- [btop](https://github.com/aristocratos/btop), a resource monitor
- [Helix](https://github.com/helix-editor/helix), a modern text editor
- [Lazygit](https://github.com/jesseduffield/lazygit), a terminal UI for Git
- Various other everyday utilities

## To Do

- Secrets management
- Public VPS configuration with one-command deployment
