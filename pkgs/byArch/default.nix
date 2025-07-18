{
  pkgs,
  system ? builtins.currentSystem
}:
let
  commonPackages = import ./common.nix { inherit pkgs; };

  archPackages =
    if system == "x86_64-linux" then
      import ./arch/x86-64 { inherit pkgs; }
    else if system == "aarch64-linux" then
      import ./arch/aarch64 { inherit pkgs; }
    else
      [];
in

commonPackages ++ archPackages
