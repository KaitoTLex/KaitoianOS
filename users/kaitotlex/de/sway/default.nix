{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      terminal = "kitty";
      modifier = "Mod4";
      menu = "rofi -show combi";
      bars = [
        {
          command = "waybar";
        }
      ];
      gaps = {
        inner = 12;
      };
      # colors = {
      #   focused = {
      #     background = "#191724";
      #     border = "#6e6a86";
      #     childBorder = "#6e6a86";
      #     indicator = "#26233a";
      #     text = "#e0def4";
      #   };
      #   focusedInactive = {
      #     background = "#797593";
      #     border = "#393552";
      #     childBorder = "#393552";
      #     indicator = "#ea9d34";
      #     text = "#e0def4";
      #   };
      #   placeholder = {
      #     background = "#1f1d2e";
      #     border = "#000000";
      #     childBorder = "#9893a5";
      #     indicator = "#000000";
      #     text = "#e0def4";
      #   };
      #   unfocused = {
      #     background = "#1f1d2e";
      #     border = "#1f1d2e";
      #     childBorder = "#1f1d2e";
      #     indicator = "#797593";
      #     text = "#e0def4";
      #   };
      #   urgent = {
      #     background = "#2a273f";
      #     border = "#ea9a97";
      #     childBorder = "#ea9a97";
      #     indicator = "#1f1d2e";
      #     text = "#e0def4";
      #   };
      # };
      window = {
        border = 3;
        titlebar = false;
      };
      # startup = [
      #   {
      #     always = true;
      #     command = "swaybg -i /home/kaitotlex/Pictures/eff.png";
      #   }
      # ];
    };
    xwayland = true;
    extraConfig = ''
      bindsym XF86AudioRaiseVolume exec pamixer -i 5 
      bindsym XF86AudioLowerVolume exec pamixer -d 5
      bindsym XF86AudioMute exec pamixer -t 
      bindsym XF86MonBrightnessUp exec brightnessctl s 5%+
      bindsym XF86MonBrightnessDown exec brightnessctl s 5%-
      bindsym XF86AudioMicMute exec spotify
      input "type:touchpad" {
          natural_scroll enabled
          tap enabled         # enables click-on-tap
          tap_button_map lrm  # tap with 1 finger = left click, 2 fingers = right click, 3 fingers = middle click
          #dwt enabled         # disable (touchpad) while typing
      }
      bindsym XF86KbdBrightnessDown exec brightnessctl -d asus::kbd_backlight s 1- 
      bindsym XF86KbdBrightnessUp exec brightnessctl -d asus::kbd_backlight s +1
      bindsym XF86Tools exec brightnessctl s 0
      bindsym XF86WebCam exec systemctl sleep
      bindsym Prior exec playerctl previous
      bindsym Next exec playerctl next
      bindsym XF86RotateWindows exec playerctl play-pause
    '';
  };

}
