require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"dockerfile",
		"go",
		"gomod",
		"javascript",
		"json",
		"lua",
		"python",
		"rust",
		"toml",
		"yaml",
        "typescript",
	},
	highlight = { enable = true, disable = {} },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<leader>is",
			node_incremental = "+",
			scope_incremental = "w",
			node_decremental = "-",
		},
	},
	indent = { enable = true },
	endwise = { enable = true },
})