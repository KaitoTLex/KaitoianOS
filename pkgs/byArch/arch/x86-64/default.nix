{
  nixpkgs,
  pkgs,
  ...
}:
with pkgs;[
  affine-bin
  conda
  wacomtablet
  prusa-slicer  
  lunar-client
]
  #formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    
