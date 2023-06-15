return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- if you use nvim-cmp
  config = function()
    require'lspconfig'.ccls.setup{}
  end,
}
