{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      function fish_user_key_bindings
        fish_vi_key_bindings
        bind -M insert \cf accept-autosuggestion
      end
      function n
        set t_pid (hyprctl activewindow | grep "pid" | sed -E "s/.*pid: (.*)/\1/")
        hyprctl dispatch movetoworkspacesilent special:temp > /dev/null 2>&1
        neovide --grid 400x100 --vsync $argv > /dev/null 2>&1
        set cur (hyprctl activeworkspace | head -n 1| sed -E 's/.*\(([0-9]+)\).*/\1/')
        hyprctl dispatch focuswindow pid:$t_pid > /dev/null 2>&1
        hyprctl dispatch movetoworkspace $cur > /dev/null 2>&1
      end
    '';
    functions = {
      nvt = "neovide --grid 400x100 --vsync $argv > /dev/null 2>&1 & disown";
    };
    shellAliases = {
      ls = "eza --icons";
      hms = "home-manager switch --flake";
    };
  };
}
