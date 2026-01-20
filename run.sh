#!/bin/sh

root="$(dirname "$(realpath "$0")")"

mode="$1"
if [ -n "$mode" ]; then
  shift
fi

sudo nixos-rebuild --flake "$root"# "${mode:-switch}" "$@"
