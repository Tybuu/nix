{
  pkgs,
  lib,
  ...
}: {
  programs.nvf = {
    settings = {
      vim.keymaps = [
        {
          key = "<Esc>";
          mode = "n";
          action = "<cmd>nohlsearch<CR>";
        }
        {
          key = "<C-Left>";
          mode = "n";
          silent = true;
          action = "<C-w>h";
          desc = "Go to Left Window";
        }
        {
          key = "<C-Down>";
          mode = "n";
          action = "<C-w>j";
          desc = "Go to Lower Window";
        }
        {
          key = "<C-Up>";
          mode = "n";
          action = "<C-w>h";
          desc = "Go to Upper Window";
        }
        {
          key = "<C-Right>";
          mode = "n";
          action = "<C-w>l";
          desc = "Go to Right Window";
        }
      ];
    };
  };
}
