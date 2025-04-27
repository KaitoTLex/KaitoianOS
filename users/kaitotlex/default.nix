{
  imports = [
    ./home.nix
    ./spicetify.nix
    ./stylix
    ./desktop-environment
  ];

  liminalOS.formFactor = "desktop";
  liminalOS.powersave = false;
}
