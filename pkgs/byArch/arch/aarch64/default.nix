{
  nixpkgs,
  pkgs,
  ...
}:
with pkgs;[
  idevicerestore
]
  #formatter."aarch64-linux" = nixpkgs.legacyPackages.aarch64-linux.nixfmt-rfc-style;