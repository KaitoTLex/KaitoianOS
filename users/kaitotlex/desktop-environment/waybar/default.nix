{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
let
  cfg = config.liminalOS.desktop.waybar;
  theme = config.lib.stylix;
  palette = theme.colors;
in{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true; # disable it,autostart it in hyprland conf
      target = lib.mkIf config.liminalOS.desktop.hyprland.enable "hyprland-session.target";
    };
    style = ''
      * {
      font-family: "Lekton Nerd Font";
      font-size: 16;
      border-radius: 0px;
      transition-property: background-color;
      transition-duration: 0.5s;
      }
      @keyframes blink_red {
      to {
      background-color: #CDB3C1;
      color: rgb(26, 24, 38);
      }
      }
      .warning, .critical, .urgent {
      animation-name: blink_red;
      animation-duration: 1s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
      }
      window#waybar {
      background-color: transparent;
      }
      window > box {
      background-color: transparent;
      border-bottom: 1px solid black;
      }
      #workspaces {
      padding-left: 0px;
      padding-right: 4px;
      }
      #workspaces button {
      padding-top: 4px;
      padding-bottom: 3px;
      padding-left: 6px;
      padding-right: 6px;
      color:#${palette.base00};
      }
      #workspaces button.active {
      background: radial-gradient( 40px circle at top left, rgba(255, 255, 255, 0.7), rgba(255,255,255, 0) ), transparent;
      border: 1px solid black;
      color: #${palette.base00};
      padding-top: 3px;
      padding-bottom: 2px;
      padding-left: 5px;
      padding-right: 5px;
      }
      #workspaces button.urgent {
      color: rgb(26, 24, 38);
      }
      #workspaces button:hover {
      background-color:#${palette.base0B};
      color: #${palette.base0A};
      }
      tooltip {
      background: white;
      border: 1px solid black;
      border-radius: 0px;
      }
      tooltip label {
      color: #${palette.base00};
      }
      #custom-rofi {
      font-size: 20px;
      padding-left: 8px;
      padding-right: 8px;
      color: #${palette.base00};
      }
      #mode, #clock, #wireplumber, #cpu, #network, #battery, #custom-powermenu {
      padding-left: 5px;
      padding-right: 8px;
      }
      #mpris {
      padding-left: 5px;
      padding-right: 0px;
      }
      #memory {
      color: #${palette.base0B};
      }
      #backlight {
      color: #${palette.base0C};
      }
      #clock {
      color: black;
      font-weight: 600;
      }
      #window {
        color: white;
        font-weight: 600;
        text-shadow:
         -1px -1px 0 black,
          1px -1px 0 black,
         -1px  1px 0 black,
          1px  1px 0 black;
      }
      #custom-wall {
      color: #B38DAC;
      }
      #temperature {
      color: #${palette.base09};
      }
      #cpu {
      color: #${palette.base08};
      }
      #mpris {
      color: black;
      }
      #wireplumber {
      color: black;
      }
      #network {
      color: black;
      }

      #network.disconnected {
      color: #CCCCCC;
      }
      #battery.charging, #battery.full, #battery.discharging {
      color: black;
      }
      #battery.critical:not(.charging) {
      color: #D6DCE7;
      }
      #custom-powermenu {
      color: white;
      font-size: 20px;
      padding-left: 8px;
      padding-right: 8px;
      text-shadow:
        1px 1px 0 black,
        -1px -1px 0 black,
        -1px  1px 0 black,
        1px  -1px 0 black;
      }
      #tray {
      padding-right: 8;
      padding-left: 0;
      }
      #tray menu {
      background: white;
      border: 1px solid black;
      border-radius: 0px;
      color: black;
      }
    '';
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "custom/powermenu"
          "hyprland/workspaces"
          "custom/wall"
        ];
        modules-center = [
          "clock"
          "hyprland/window"
        ];
        modules-right = [
          "mpris"
          "wireplumber"
          #"backlight"
          #"memory"
          #"cpu"
          #"network"
          #"temperature"
          "battery"
          "tray"
          #"custom/powermenu"
        ];
        "custom/powermenu" = {
          "format" = "𝄞";
          "on-click" = "wlogout";
          "tooltip" = false;
        };
        "hyprland/window" = {
          max-length = 25;
          separate-outputs = false;
          rewrite = {
            "" = "/ᐠ - ˕ -マ Ⳋ ⋆｡°✩♬ ♪";
          };
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "1" = "𝅘𝅥 ";
            "2" = "♫";
            "3" = "𝅘𝅥𝅯  ";
            "4" = "♬";
            "5" = "𝅘𝅥𝅱  ";
            "6" = "𝅗𝅥 ";
            "7" = "𝅝  ";
            "8" = "♯";
            "9" = "♮";
            "10" = "♭";
            "discord" = " ";
            "magic" = "♬⋆.˚";
            "scratch" = "ᝰ.ᐟ";
            sort-by-number = false;
          };
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          "window-rewrite-default" = "🖿";
          "show-special" = true;
          "special-visible-only" = true;
        };
        # "backlight" = {
        #   "device" = "intel_backlight";
        #   "on-scroll-up" = "light -A 5";
        #   "on-scroll-down" = "light -U 5";
        #   "format" = "{icon}  {percent}% /";
        #   "format-icons" = [
        #     "𝄖"
        #     "𝄗"
        #     "𝄘"
        #     "𝄙"
        #     "𝄚"
        #     "𝄛"
        #   ];
        # };
        "mpris" = {
          "format" = "♪ « {artist} - {title} »";
          "format-paused" = "⏸ [{artist} - {title}]";
          "max-length" = 50;
        };
        "wireplumber" = {
          "scroll-step" = 2;
          "format" = " / {icon} {volume}% /";
          "format-muted" = "/ (° × ° ) /";
          "format-icons" = {
            "default" = [
              "𝅗𝅥 "
              "♩~"
              "♪~"
              "♫~"
              "♬~"
            ];
          };
          "on-click" = "pavucontrol";
          "tooltip" = true;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon}  {capacity}% /";
          "format-icons" = [
            "𝄽"
            "𝄾"
            "𝄿"
            "𝅀"
            "𝅁"
            "𝅂"
          ];
          "format-full" = "𝆑 /";
          "format-charging" = "𝄮 {capacity}% /";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d} /";
          "tooltip" = true;
          "tooltip-format" = "<tt>{calendar}</tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#${palette.base08}'><b>{}</b></span>";
              "days" = "<span color='#${palette.base00}'><b>{}</b></span>";
              "weeks" = "<span color='#${palette.base08}'><b>W{}</b></span>";
              "weekdays" = "<span color='#${palette.base0A}'><b>{}</b></span>";
              "today" = "<span color='#${palette.base0B}'><b><u>{}</u></b></span>";
            };
          };
          "on-click" = "kitty calcure";
        };
        /*
        "memory" = {
          "interval" = 1;
          "format" = "✿ {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };  
        */
        "cpu" = {
          "interval" = 1;
          "format" = "❀ {usage}%";
        };
        "network" = {
          "format-disconnected" = "Disconnected :c /";
          "format-ethernet" = "𝆺𝅥𝅯 /";
          "format-linked" = "𝆹𝅥𝅯 (No IP) /";
          "format-wifi" = "𝆹𝅥𝅮 /";
          "interval" = 1;
          "tooltip" = true;
          "tooltip-format" = "{essid} ({ipaddr})";
          "on-click" = "nm-applet --indicator";
        };
        /*
        "temperature" = {
          #"critical-threshold"= 80;
          "tooltip" = false;
          "format" = "⋆.˚ {temperatureC}°C";
        };
        */
        /*
          "custom/powermenu" = {
          "format" = "/ 𓏲𝄢";
          "on-click" = "wlogout";
          "tooltip" = false;
        };
        */
        "tray" = {
          "icon-size" = 12;
          "spacing" = 6;
        };
      }
    ];
  };
}
# {
#   options.liminalOS.desktop.waybar = {
#     enable = lib.mkOption {
#       type = lib.types.bool;
#       default = config.liminalOS.desktop.enable;
#       description = ''
#         Whether to enable Waybar and the liminalOS rice.
#       '';
#     };
#   };
#   config = lib.mkIf cfg.enable {
#     home.packages = with pkgs; [ playerctl ];
#     programs.waybar =
#       let
#         isDesktop = osConfig.liminalOS.formFactor == "desktop";
#         isLaptop = osConfig.liminalOS.formFactor == "laptop";
#       in
#       {
#         enable = true;
#         systemd.enable = true;
#         systemd.target = lib.mkIf config.liminalOS.desktop.hyprland.enable "hyprland-session.target";
#         settings.mainBar = {
#           name = "bar0";
#           reload_style_on_change = true;
#           position = "top";
#           layer = "top";
#           height = 37;
#           margin-top = 0;
#           margin-bottom = 0;
#           margin-left = 0;
#           margin-right = 0;
#           modules-left =
#             [
#               "custom/launcher"
#             ]
#             ++ (lib.optionals isDesktop [

#               "custom/playerctl#backward"
#               "custom/playerctl#play"
#               "custom/playerctl#foward"
#             ])
#             ++ [
#               "custom/playerlabel"
#             ]
#             ++ (lib.optionals isLaptop [
#               "hyprland/workspaces"
#             ]);
#           modules-center = lib.mkIf isDesktop [
#             "cava#left"
#             "hyprland/workspaces"
#             "cava#right"
#           ];
#           modules-right = [
#             "tray"
#             "battery"
#             "pulseaudio"
#             "network"
#             "clock"
#           ];
#           clock = {
#             format = " {:%a, %D, %T}";
#             tooltip = "true";
#             tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
#             format-alt = " {:%d/%m}";
#           };
#           "hyprland/workspaces" = {
#             disable-scroll = false;
#             on-scroll-down = "${pkgs.hyprnome}/bin/hyprnome";
#             on-scroll-up = "${pkgs.hyprnome}/bin/hyprnome --previous";
#             format = "{icon}";
#             on-click = "activate";
#             format-icons = {
#               active = "";
#               default = "";
#               urgent = "";
#               special = "󰠱";
#             };
#             sort-by-number = true;
#           };
#           "cava#left" = {
#             framerate = 60;
#             autosens = 1;
#             bars = 18;
#             lower_cutoff_freq = 50;
#             higher_cutoff_freq = 10000;
#             method = "pipewire";
#             source = "auto";
#             stereo = true;
#             reverse = false;
#             bar_delimiter = 0;
#             monstercat = false;
#             waves = false;
#             input_delay = 2;
#             format-icons = [
#               "<span foreground='#${palette.base08}'>▁</span>"
#               "<span foreground='#${palette.base08}'>▂</span>"
#               "<span foreground='#${palette.base08}'>▃</span>"
#               "<span foreground='#${palette.base08}'>▄</span>"
#               "<span foreground='#${palette.base0A}'>▅</span>"
#               "<span foreground='#${palette.base0A}'>▆</span>"
#               "<span foreground='#${palette.base0A}'>▇</span>"
#               "<span foreground='#${palette.base0A}'>█</span>"
#             ];
#           };
#           "cava#right" = {
#             framerate = 60;
#             autosens = 1;
#             bars = 18;
#             lower_cutoff_freq = 50;
#             higher_cutoff_freq = 10000;
#             method = "pipewire";
#             source = "auto";
#             stereo = true;
#             reverse = false;
#             bar_delimiter = 0;
#             monstercat = false;
#             waves = false;
#             input_delay = 2;
#             format-icons = [
#               "<span foreground='#${palette.base08}'>▁</span>"
#               "<span foreground='#${palette.base08}'>▂</span>"
#               "<span foreground='#${palette.base08}'>▃</span>"
#               "<span foreground='#${palette.base08}'>▄</span>"
#               "<span foreground='#${palette.base0A}'>▅</span>"
#               "<span foreground='#${palette.base0A}'>▆</span>"
#               "<span foreground='#${palette.base0A}'>▇</span>"
#               "<span foreground='#${palette.base0A}'>█</span>"
#             ];
#           };
#           "custom/playerctl#backward" = {
#             format = "󰙣 ";
#             on-click = "playerctl previous";
#             on-scroll-up = "playerctl volume .05+";
#             on-scroll-down = "playerctl volume .05-";
#           };
#           "custom/playerctl#play" = {
#             format = "{icon}";
#             return-type = "json";
#             exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
#             on-click = "playerctl play-pause";
#             on-scroll-up = "playerctl volume .05+";
#             on-scroll-down = "playerctl volume .05-";
#             format-icons = {
#               Playing = "<span>󰏥 </span>";
#               Paused = "<span> </span>";
#               Stopped = "<span> </span>";
#             };
#           };
#           "custom/playerctl#foward" = {
#             format = "󰙡 ";
#             on-click = "playerctl next";
#             on-scroll-up = "playerctl volume .05+";
#             on-scroll-down = "playerctl volume .05-";
#           };
#           "custom/playerlabel" = {
#             format = "<span>󰎈 {} 󰎈</span>";
#             return-type = "json";
#             max-length = 40;
#             exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
#             on-click = "";
#           };
#           battery = {
#             states = {
#               good = 95;
#               warning = 30;
#               critical = 15;
#             };
#             format = "{icon}  {capacity}%";
#             format-charging = "  {capacity}%";
#             format-plugged = " {capacity}% ";
#             format-alt = "{icon} {time}";
#             format-icons = [
#               ""
#               ""
#               ""
#               ""
#               ""
#             ];
#           };

#           memory = {
#             format = "󰍛 {}%";
#             format-alt = "󰍛 {used}/{total} GiB";
#             interval = 5;
#           };
#           cpu = {
#             format = "󰻠 {usage}%";
#             format-alt = "󰻠 {avg_frequency} GHz";
#             interval = 5;
#           };
#           network = {
#             format-wifi = "  {signalStrength}%";
#             format-ethernet = "󰈀 100% ";
#             tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
#             format-linked = "{ifname} (No IP)";
#             format-disconnected = "󰖪 0% ";
#           };
#           tray = {
#             icon-size = 20;
#             spacing = 8;
#           };
#           pulseaudio = {
#             format = "{icon} {volume}%";
#             format-muted = "󰝟";
#             format-icons = {
#               default = [
#                 "󰕿"
#                 "󰖀"
#                 "󰕾"
#               ];
#             };
#             scroll-step = 5;
#             on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
#           };
#           "custom/launcher" =
#             let
#               toggle-colorscheme = pkgs.writeShellScriptBin "toggle-colorscheme.sh" ''
#                 POLARITY_FILE="/etc/polarity"

#                 if [[ ! -f "$POLARITY_FILE" ]]; then
#                   exit 0
#                 elif [[ ! -r "$POLARITY_FILE" ]]; then
#                   echo "Error: Cannot read $POLARITY_FILE. Check permissions." >&2
#                   exit 1
#                 fi

#                 current_scheme=$(cat "$POLARITY_FILE")
#                 if [[ $? -ne 0 ]]; then
#                     echo "Error: Failed to read content from $POLARITY_FILE." >&2
#                     exit 1
#                 fi

#                 current_scheme=$(echo "$current_scheme" | xargs)

#                 target_service=""
#                 case "$current_scheme" in
#                   dawn)
#                     target_service="colorscheme-dusk.service"
#                     ;;
#                   dusk)
#                     target_service="colorscheme-dawn.service"
#                     ;;
#                   *)
#                     echo "Error: Invalid content '$current_scheme' found in $POLARITY_FILE. Expected 'dawn' or 'dusk'." >&2
#                     exit 1
#                     ;;
#                 esac

#                 echo "Current scheme: '$current_scheme'. Attempting to start '$target_service'..."
#                 systemctl start "$target_service"

#                 if [[ $? -ne 0 ]]; then
#                   echo "Error: Failed to execute 'systemctl start $target_service'. Check systemctl logs or permissions." >&2
#                   exit 1
#                 else
#                   echo "Command 'systemctl start $target_service' executed successfully."
#                 fi

#                 exit 0
#               '';
#             in
#             {
#               format = "";
#               on-click = "pkill -9 rofi || rofi -show drun";
#               on-click-right = "${toggle-colorscheme}/bin/toggle-colorscheme.sh";
#               tooltip = "false";
#             };
#         };
#         style =
#           ''
#             * {
#               border: none;
#               border-radius: 0px;
#               font-family: GeistMono Nerd Font;
#               font-size: 13px;
#               min-height: 0;
#             }
#             window#waybar {
#               background: #${palette.base01};
#             }

#             #cava.left, #cava.right {
#                 background: #${palette.base00};
#                 margin: 4px;
#                 padding: 6px 16px;
#                 color: #${palette.base00};
#             }
#             #cava.left {
#                 border-radius: 24px 10px 24px 10px;
#             }
#             #cava.right {
#                 border-radius: 10px 24px 10px 24px;
#             }
#             #workspaces {
#                 background: #${palette.base00};
#                 color: #${palette.base00}
#             }
#             #workspaces button {
#                 padding: 0px 5px;
#                 margin: 0px 3px;
#                 border-radius: 16px;
#                 color: transparent;
#                 background: #${palette.base01};
#                 transition: all 0.3s ease-in-out;
#             }

#             #workspaces button.active {
#                 background-color: #${palette.base0A};
#                 color: #${palette.base01};
#                 border-radius: 16px;
#                 min-width: 50px;
#                 background-size: 400% 400%;
#                 transition: all 0.3s ease-in-out;
#             }

#             #workspaces button:hover {
#                 background-color: #${palette.base05};
#                 color: #${palette.base01};
#                 border-radius: 16px;
#                 min-width: 50px;
#                 background-size: 400% 400%;
#             }

#             #tray, #pulseaudio, #network, #battery,
#             #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward{
#                 background: #${palette.base00};
#                 font-weight: bold;
#                 margin: 4px 0px;
#             }
#             #tray, #pulseaudio, #network, #battery{
#                 color: #${palette.base05};
#                 border-radius: 10px 24px 10px 24px;
#                 padding: 0 20px;
#                 margin-left: 7px;
#             }
#             #clock {
#                 color: #${palette.base05};
#                 background: #${palette.base00};
#                 border-radius: 0px 0px 0px 40px;
#                 padding: 8px 10px 8px 25px;
#                 margin-left: 7px;
#                 font-weight: bold;
#                 font-size: 14px;
#             }
#             #custom-launcher {
#                 color: #${palette.base0A};
#                 background: #${palette.base00};
#                 border-radius: 0px 0px 40px 0px;
#                 margin: 0px;
#                 padding: 0px 35px 0px 15px;
#                 font-size: 24px;
#             }

#             #custom-playerctl.backward, #custom-playerctl.play, #custom-playerctl.foward {
#                 background: #${palette.base00};
#                 font-size: 20px;
#             }
#             #custom-playerctl.backward:hover, #custom-playerctl.play:hover, #custom-playerctl.foward:hover{
#                 color: #${palette.base05};
#             }
#             #custom-playerctl.backward {
#                 color: #${palette.base08};
#                 border-radius: 24px 0px 0px 10px;
#                 padding-left: 16px;
#                 margin-left: 7px;
#             }
#             #custom-playerctl.play {
#                 color: #${palette.base0A};
#                 padding: 0 5px;
#             }
#             #custom-playerctl.foward {
#                 color: #${palette.base08};
#                 border-radius: 0px 10px 24px 0px;
#                 padding-right: 12px;
#                 margin-right: 7px
#             }
#             #custom-playerlabel {
#                 background: #${palette.base00};
#                 color: #${palette.base05};
#                 padding: 0 20px;
#                 border-radius: 24px 10px 24px 10px;
#                 margin: 4px 0;
#                 font-weight: bold;
#             }
#             #window{
#                 background: #${palette.base00};
#                 padding-left: 15px;
#                 padding-right: 15px;
#                 border-radius: 16px;
#                 margin-top: 4px;
#                 margin-bottom: 4px;
#                 font-weight: normal;
#                 font-style: normal;
#             }
#           ''
#           + (lib.optionalString isLaptop ''
#             #workspaces {
#               margin: 4px;
#               padding: 6px 16px;
#               border-radius: 24px 10px 24px 10px;
#             }
#           '')
#           + (lib.optionalString isDesktop ''
#             #workspaces {
#               margin: 4px 5px;
#               padding: 6px 5px;
#               border-radius: 16px;
#             }
#           '');
#       };
#   };
# }
