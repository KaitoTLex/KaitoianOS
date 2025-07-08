{
  programs,
  nixpkgs,
  pkgs,
  lib,
  ...
}:
{
  formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
  environment.systemPackages = with pkgs; {

  };
}
