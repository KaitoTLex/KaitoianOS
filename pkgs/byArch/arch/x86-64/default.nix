{
  pkgs,
  ...
}:
with pkgs;
[
  waydroid
  arduino-cli
  wineWowPackages.waylandFull
  tor-browser
  affine-bin
  conda
  wacomtablet
  prusa-slicer
  lunar-client
  sbctl
  kicad
  polychromatic
  openrazer-daemon
  bambu-studio
]
#formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
