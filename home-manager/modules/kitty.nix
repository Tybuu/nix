{pkgs, lib, ... }: 
{
  programs.kitty =
  {
    enable = true;
    settings = {
      shell = "fish";
      background = "#0C0C0C";
      font_family = "Inconsolata Nerd Font";
      font_size = 15;
      background_opacity = 0.8;
      window_padding_width = 2;
      confirm_os_window_close = 0;
    };
  };
}
