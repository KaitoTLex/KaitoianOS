{
  imports = [
    ./home.nix
    ./spicetify.nix
    ./stylix
    ./desktop-environment
    ../../modules/localization
  ];

  liminalOS.formFactor = "laptop";
  liminalOS.desktop.hyprland.screenlocker.monitor = "eDP-1";
  liminalOS.desktop.hyprland.screenlocker.useCrashFix = true;
  #liminalOS.desktop.localization.chinese.input.enable = true;
  wayland.windowManager.hyprland.settings.env = [
    "GSK_RENDERER,ngl"
  ];
}
