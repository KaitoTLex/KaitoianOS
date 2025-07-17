{
  pkgs,
  system ? builtins.currentSystem
}:
let
  commonPackages = import ./common.nix { inherit pkgs; };

  archPackages =
    if system == "x86_64-linux" then
      import ./x86 { inherit pkgs; }
    else if system == "aarch64-linux" then
      import ./arm { inherit pkgs; }
    else
      [];
in

commonPackages ++ archPackages