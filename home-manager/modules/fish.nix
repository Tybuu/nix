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
        hyprctl dispatch movetoworkspacesilent 69 > /dev/null 2>&1
        neovide $argv > /dev/null 2>&1
        set cur (hyprctl activeworkspace | head -n 1| sed -E 's/.*\(([0-9]+)\).*/\1/')
        hyprctl dispatch workspace 69 > /dev/null 2>&1
        hyprctl dispatch movetoworkspace $cur > /dev/null 2>&1
      end
    '';
    functions = {
      nvt = "neovide $argv > /dev/null 2>&1 & disown";
    };
    shellAliases = {
      ls = "eza --icons";
    };
  };
}
