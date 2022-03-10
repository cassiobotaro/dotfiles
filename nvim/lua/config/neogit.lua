vim.api.nvim_set_keymap(
	"n",
	"<leader>g",
	[[<cmd>lua require("neogit").open({ kind = "split" })<CR>]],
	{ noremap = true }
)