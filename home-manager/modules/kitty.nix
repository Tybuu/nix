{
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      shell = "fish";
      font_family = "Inconsolata Nerd Font";
      font_size = 15;
      window_padding_width = 2;
      confirm_os_window_close = 0;
      cursor_trail = 3;
    };
    themeFile = "Catppuccin-Mocha";
  };
}
