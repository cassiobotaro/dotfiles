local actions = require("telescope.actions")
require("telescope").setup({ defaults = { mappings = { i = { ["<Esc>"] = actions.close } } } })

local opts = { noremap = true }
local mappings = {
	{ "n", "<Leader>f", [[<Cmd>Telescope git_files<CR>]], opts },
	{ "n", "<Leader>G", [[<Cmd>Telescope git_status<CR>]], opts },
	{ "n", "<Leader>e", [[<Cmd>Telescope find_files<CR>]], opts },
	{ "n", "<Leader>b", [[<Cmd>Telescope buffers<CR>]], opts },
	{ "n", "<Leader>o", [[<Cmd>Telescope oldfiles<CR>]], opts },
	{ "n", "<Leader>/", [[<Cmd>Telescope live_grep<CR>]], opts },
	{ "n", "<Leader>m", [[<Cmd>Telescope keymaps<CR>]], opts },
}
for _, val in pairs(mappings) do
	vim.api.nvim_set_keymap(unpack(val))
end