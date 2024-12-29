{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway --remember --greeting 'Access is restricted to authorized personnel only.'";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  # programs.swaylock = {
  #   enable = true;
  # };

  #security.pam.services.swaylock = { };
  #home.pointerCursor = {
  #name = "apple_cursor";
  #package = pkgs.apple-cursor;
  #size = 24;
  #x11 = {
  #enable = true;
  #defaultCursor = "apple_cursor";
  #};
  #};
}
