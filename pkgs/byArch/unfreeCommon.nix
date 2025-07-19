{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "steam"
      "steam-unwrapped"
      "obsidian"
    ];
}
