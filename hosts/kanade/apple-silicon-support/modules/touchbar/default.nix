{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.hardware.asahi.touchbar;
  configFormat = pkgs.formats.toml {};
in

{
  options.hardware.asahi.touchbar = {
    enable = mkEnableOption "touchbar support using tiny-dfr";

    extraConfig = mkOption {
      type = configFormat.type;
      default = { };
      example = literalExpression ''
        {
	  MediaLayerDefault = true;
	  MediaLayerKeys = [
	    { Icon = "brightness_low"; Action = "BrightnessDown"; }
	    { Icon = "brightness_high"; Action = "BrightnessUp"; }
	    { Icon = "mic_off"; Action = "MicMute"; }
	    { Icon = "search"; Action = "Search"; }
	    { Icon = "backlight_low"; Action = "IllumDown"; }
	    { Icon = "backlight_high"; Action = "IllumUp"; }
	    { Icon = "fast_rewind"; Action = "PreviousSong"; }
	    { Icon = "play_pause"; Action = "PlayPause"; }
	    { Icon = "fast_forward"; Action = "NextSong"; }
	    { Icon = "volume_off"; Action = "Mute"; }
	    { Icon = "volume_down"; Action = "VolumeDown"; }
	    { Icon = "volume_up"; Action = "VolumeUp"; }
	  ];
	}
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.etc."tiny-dfr/config.toml".source = configFormat.generate "tiny-dfr-config" cfg.extraConfig;

    systemd.services."systemd-backlight@backlight:228200000.display-pipe.0" = {};
    systemd.services."systemd-backlight@backlight:appletb_backlight" = {};

    systemd.services.tiny-dfr = {
      enable = true;
      description = "Tiny Apple silicon touch bar daemon";
      after = [
        "systemd-user-sessions.service"
        "getty@tty1.service"
        "plymouth-quit.service"
        "systemd-logind.service"
        "dev-tiny_dfr_display.device"
        "dev-tiny_dfr_backlight.device"
        "dev-tiny_dfr_display_backlight.device"
      ];
      bindsTo = [
        "dev-tiny_dfr_display.device"
        "dev-tiny_dfr_backlight.device"
        "dev-tiny_dfr_display_backlight.device"
      ];
      serviceConfig = {
        ExecStart = "${pkgs.tiny-dfr}/bin/tiny-dfr";
        Restart = "always";
      };
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="adp|appletbdrm", TAG-="master-of-seat", ENV{ID_SEAT}="seat-touchbar"

      SUBSYSTEM=="input", ATTR{name}=="Apple Inc. Touch Bar Display Touchpad", ENV{ID_SEAT}="seat-touchbar"
      SUBSYSTEM=="input", ATTR{name}=="MacBookPro17,1 Touch Bar", ENV{ID_SEAT}="seat-touchbar"
      SUBSYSTEM=="input", ATTR{name}=="Mac14,7 Touch Bar", ENV{ID_SEAT}="seat-touchbar"

      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="05ac", ATTR{idProduct}=="8302", ATTR{bConfigurationValue}=="1", ATTR{bConfigurationValue}="0", ATTR{bConfigurationValue}="2"

      SUBSYSTEM=="input", ATTR{name}=="Apple Inc. Touch Bar Display Touchpad", TAG+="systemd", ENV{SYSTEMD_WANTS}="tiny-dfr.service"
      SUBSYSTEM=="input", ATTR{name}=="MacBookPro17,1 Touch Bar", TAG+="systemd", ENV{SYSTEMD_WANTS}="tiny-dfr.service"
      SUBSYSTEM=="input", ATTR{name}=="Mac14,7 Touch Bar", TAG+="systemd", ENV{SYSTEMD_WANTS}="tiny-dfr.service"

      SUBSYSTEM=="drm", KERNEL=="card[0-9]*", DRIVERS=="adp|appletbdrm", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/tiny_dfr_display"

      SUBSYSTEM=="backlight", KERNEL=="appletb_backlight", DRIVERS=="hid-appletb-bl", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/tiny_dfr_backlight"
      SUBSYSTEM=="backlight", KERNEL=="228200000.display-pipe.0", DRIVERS=="panel-summit", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/tiny_dfr_backlight"

      SUBSYSTEM=="backlight", KERNEL=="apple-panel-bl", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/tiny_dfr_display_backlight"
      SUBSYSTEM=="backlight", KERNEL=="gmux_backlight", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/tiny_dfr_display_backlight"
      SUBSYSTEM=="backlight", KERNEL=="intel_backlight", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/tiny_dfr_display_backlight"
      SUBSYSTEM=="backlight", KERNEL=="acpi_video0", TAG+="systemd", ENV{SYSTEMD_ALIAS}="/dev/tiny_dfr_display_backlight"
    '';

  };
}
