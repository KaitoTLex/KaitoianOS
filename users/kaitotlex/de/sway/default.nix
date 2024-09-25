{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      terminal = "kitty";
      modifier = "Mod4";
      menu = "rofi -show drun";
      bars = [
        {
          command = "waybar";
        }
      ];
      gaps = {
        inner = 12;
      };
      colors = {
        focused = {
          background = "#191724";
          border = "#6e6a86";
          childBorder = "#6e6a86";
          indicator = "#26233a";
          text = "#e0def4";
        };
        focusedInactive = {
          background = "#797593";
          border = "#393552";
          childBorder = "#393552";
          indicator = "#ea9d34";
          text = "#e0def4";
        };
        placeholder = {
          background = "#1f1d2e";
          border = "#000000";
          childBorder = "#9893a5";
          indicator = "#000000";
          text = "#e0def4";
        };
        unfocused = {
          background = "#1f1d2e";
          border = "#1f1d2e";
          childBorder = "#1f1d2e";
          indicator = "#797593";
          text = "#e0def4";
        };
        urgent = {
          background = "#2a273f";
          border = "#ea9a97";
          childBorder = "#ea9a97";
          indicator = "#1f1d2e";
          text = "#e0def4";
        };
      };
      window = {
        border = 3;
        titlebar = false;
        #startup = [
        #{
        # command = "swaybg -i /home/kaitotlex/Pictures/bg.png";
        # }
        #];
      };
    };
  };
}
