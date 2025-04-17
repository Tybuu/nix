{
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    withRuby = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = let
      lsp = with pkgs; [
        lua-language-server
        clang-tools
        rust-analyzer
        nil
        pyright
        tinymist
      ];

      formatters = with pkgs; [
        stylua
        alejandra
        rustfmt
        typstyle
      ];

      dep = with pkgs; [
        clang
        git
        gcc
        gnumake
        unzip
        wget
        curl
        tree-sitter
        ripgrep
        fd
        fzf
        cargo
      ];
    in
      lsp ++ formatters ++ dep;
  };
}
