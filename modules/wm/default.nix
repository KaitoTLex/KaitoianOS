{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
