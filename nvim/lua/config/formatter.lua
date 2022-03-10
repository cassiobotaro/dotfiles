-- formatter modules
local function prettier()
	return {
		exe = "prettier",
		args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

require("formatter").setup({
	logging = false,
	filetype = {
		go = {
			function()
				return { exe = "gofmt", stdin = true }
			end,
			function()
				return { exe = "goimports", stdin = true }
			end,
		},
		javascript = { prettier },
		javascriptreact = { prettier },
		json = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--parser",
						"json",
					},
					stdin = true,
				}
			end,
		},
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"-",
					},
					stdin = true,
				}
			end,
		},
		markdown = { prettier },
		python = {
			function()
				return { exe = "black", args = { "-q", "-" }, stdin = true }
			end,
		},
		rust = {
			function()
				return { exe = "rustfmt", args = { "--emit=stdout" }, stdin = true }
			end,
		},
	},
})

vim.api.nvim_exec(
	[[
augroup FormatOnSave
    autocmd!
    autocmd BufWritePost *.go,*.rs FormatWrite
augroup END
]],
	true
)

vim.api.nvim_set_keymap("n", "<leader>af", "<Cmd>Format<CR>", { noremap = true })