{pkgs, lib, ...}:
{

  options.enable = lib.mkEnableOpton "nixvim";

  Plugins = with pkgs.vimPlugins; [
    fzf-lua
    rose-pine
  ];

  keymaps = [
    {
      key = "<leader>ss";
      mode = "n";
      action = ":lua require('nvim-possession').list()<CR>";
      options = {desc = "[s]ession: [s]elect";};
    }
    {
      key = "<leader>sn";
      mode = "n";
      action = ":lua require('nvim-possession').new()<CR>";
      options = {desc = "[s]ession: [n]ew";};
    }
    {
      key = "<leader>su";
      mode = "n";
      action = ":lua require('nvim-possession').update()<CR>";
      options = {desc = "[s]ession: [u]pdate";};
    }
    {
      key = "<leader>sd";
      mode = "n";
      action = ":lua require('nvim-possession').delete()<CR>";
      options = {desc = "[s]ession: [d]elete";};
    }
  ];
}
