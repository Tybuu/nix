{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [
          "river/tags"
        ];
        modules-center = [
          "custom/music"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "battery"
          "clock"
          "tray"
          "custom/power"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          format = "{icon}";
          all-outputs = true;
          all = false;
          format-icons = {
            "1" = "󰖟";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "󰺷";
            "7" = "";
            "8" = "󰊪";
            default = "";
          };
        };
        "river/tags" = {
          num-tags = 9;
          hide-vacant = true;
          tag-labels = [
            "󰼏"
            "󰼐"
            "󰼑"
            "󰼒"
            "󰼓"
            "󰼔"
            "󰼕"
            "󰼖"
            "󰼗"
          ];
        };
        tray = {
          icon-size = 21;
          spacing = 10;
        };
        "custom/music" = {
          format = " {}";
          escape = true;
          interval = 5;
          tooltip = false;
          exec = "playerctl metadata --format='{{ title }}'";
          on-click = "playerctl play-pause";
          max-length = 50;
        };
        clock = {
          timezone = "America/Los_Angeles";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "   {:%d/%m/%Y}";
          format = "   {:%H:%M}";
        };
        backlight = {
          device = "nvidia_0";
          format = "{icon}";
          on-scroll-up = "brightnessctl s '+10%'";
          on-scroll-down = "brightnessctl s '10%-'";
          on-click = "((( $(brightnessctl g) == 100 )) && brightnessctl s '0') || (brightnessctl s '+10%')";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "󰂄";
          format-plugged = "";
          format-alt = "{icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        pulseaudio = {
          scroll-step = 1;
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
              " "
            ];
          };
          on-click = "pavucontrol";
        };
        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "⏻";
        };
      };
    };
    style = ''
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #313244;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;
      * {
        font-family: "Maple Mono NF";
        font-size: 17px;
        min-height: 0;
      }

      #waybar {
        background: transparent;
        color: @text;
        margin: 5px 5px;
      }

      #workspaces {
        border-radius: 1rem;
        margin: 5px;
        background-color: @surface0;
        margin-left: 1rem;
      }

      #workspaces button {
          color: @lavender;
          border-radius: 1rem;
          padding: 0.4rem;
      }

      #workspaces button.active {
          color: @sky;
          border-radius: 1rem;
      }

      #workspaces button:hover {
          color: @sapphire;
          border-radius: 1rem;
      }

      #tags {
        border-radius: 1rem;
        margin: 5px;
        background-color: @surface0;
        margin-left: 1rem;
      }

      #tags button {
          color: @lavender;
          border-radius: 1rem;
          padding: 0.4rem;
      }

      #tags button.focused {
          color: @sky;
          border-radius: 1rem;
      }

      #custom-music,
      #tray,
      #backlight,
      #clock,
      #battery,
      #pulseaudio,
      #custom-lock,
      #language,
      #custom-power {
          background-color: @surface0;
          padding: 0.5rem 1rem;
          margin: 5px 0;
      }

      #clock {
          color: @blue;
          border-radius: 0px 1rem 1rem 0px;
          margin-right: 1rem;
      }

      #battery {
          color: @green;
      }

      #battery.charging {
          color: @green;
      }

      #battery.warning:not(.charging) {
          color: @red;
      }

      #backlight {
          color: @yellow;
      }

      #backlight,
      #battery {
          border-radius: 0;
      }

      #pulseaudio {
          color: @maroon;
          border-radius: 1rem 0px 0px 1rem;
          margin-left: 1rem;
      }

        #custom-music {
          color: @mauve;
          border-radius: 1rem;
      }

      #language {
          border-radius: 1rem 0px 0px 1rem;
          color: @lavender;
      }

      #custom-power {
        margin-right: 1rem;
        border-radius: 0px 1rem 1rem 0px;
        color: @red;
      }

      #tray {
        margin-right: 1rem;
        border-radius: 1rem;
      }

      #workspaces button.urgent {
        color: @red;
      }
    '';
  };
}
