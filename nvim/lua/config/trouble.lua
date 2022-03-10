require("trouble").setup({})
vim.api.nvim_set_keymap("n", "<Leader>t", "<Cmd>TroubleToggle<CR>", { noremap = true })