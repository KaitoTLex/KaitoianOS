{
  imports = [
    ./home.nix
    ./spicetify.nix
    ./stylix
    ./desktop-environment
  ];

  liminalOS.formFactor = "laptop";
  liminalOS.powersave = false;
  liminalOS.desktop.hyprland.screenlocker.monitor = "eDP-1";
}
