{
  imports = [
    ./home.nix
    ./spicetify.nix
    ./stylix
    ./desktop-environment
  ];

  liminalOS.formFactor = "laptop";
  liminalOS.desktop.hyprland.screenlocker.monitor = "eDP-1";
  liminalOS.desktop.hyprland.screenlocker.useCrashFix = true;
  wayland.windowManager.hyprland.settings.env = [
    "GSK_RENDERER,ngl"
  ];
}
