{
  pkgs,
  ...
}:
with pkgs;
[
  spotify-player
  spotifyd
  asahi-audio
  #idevicerestore
]
#formatter."aarch64-linux" = nixpkgs.legacyPackages.aarch64-linux.nixfmt-rfckk -kkstyle;
