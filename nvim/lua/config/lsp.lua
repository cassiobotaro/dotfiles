local installer = require("nvim-lsp-installer")
local servers = require("nvim-lsp-installer.servers")

local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { silent = true, noremap = true }
	local mappings = {
		{ "n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts },
		{ "n", "gr", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], opts },
		{ "n", "gs", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], opts },
		{ "n", "[e", [[<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], opts },
		{ "n", "]e", [[<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], opts },
		{
			"n",
			"gS",
			[[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
			{ noremap = true, silent = true },
		},
		{
			"n",
			"gR",
			[[<Cmd>lua require('telescope.builtin').lsp_references({ path_display = 'shorten' })<CR>]],
			{ noremap = true, silent = true },
		},
	}

	for _, map in pairs(mappings) do
		vim.api.nvim_buf_set_keymap(bufnr, unpack(map))
	end

	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
			false
		)
	end
end

local function make_config(server)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	}
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	local config = {
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = {
			["textDocument/publishDiagnostics"] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics,
				{ virtual_text = false }
			),
		},
	}

	if server.name == "sumneko_lua" then
		config.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
	end

	return config
end

local function setup_servers()
	local required_servers = {
		"gopls",
        "pyright",
        "dockerls",
        "rust_analyzer",
		"jsonls",
		"sumneko_lua",
		"yamlls",
        "tsserver",
	}

	local installed = servers.get_installed_servers()
	local is_installed = function(server_name)
		for _, installed_server in pairs(installed) do
			if server_name == installed_server.name then
				return true
			end
		end

		return false
	end

	for _, server in pairs(required_servers) do
		if not is_installed(server) then
			installer.install(server)
		end
	end

	for _, server in pairs(servers.get_installed_servers()) do
		local config = make_config(server)
		server:setup(config)
	end
end

setup_servers()
