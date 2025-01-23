{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.hardware.nvidia;
in
{
  options.hardware.nvidia.usePatchedAquamarine = lib.mkEnableOption "q9i's patched aquamarine with working sleep on Nvidia";

  config = lib.mkIf cfg.usePatchedAquamarine {
    nixpkgs.overlays = [
      (final: prev: {
        aquamarine = prev.aquamarine.overrideAttrs {
          src = inputs.aq;
          version = inputs.aq.rev;
        };
      })
    ];
  };
}
