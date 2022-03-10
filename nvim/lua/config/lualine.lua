require("lualine").setup({
	options = {
		section_separators = { "", "" },
		component_separators = { "", "" },
        theme = "onedark",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			function()
				return "%f"
			end,
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = {
			function()
				return "%p%%"
			end,
		},
		lualine_z = { "location" },
	},
})
