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
    '';
    shellAliases = {
      n = "nvim";
      nv = "neovide";
      ls = "eza --icons";
    };
  };
}
