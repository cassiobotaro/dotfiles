-- main editor configs
local api = vim.api
local opt = vim.opt
local g = vim.g

local function set_globals()
  g.mapleader = ","
  g.loaded_python_provider = false
  g.python3_host_prog =  vim.fn.expand("~/.asdf/shims/python")
end

local function set_mappings()
	local opts = { noremap = true }
	local mappings = {
      -- split horizontally
      { "", "<leader>h", ":<C-u>split<CR>", opts },
      -- split vertically
      { "", "<leader>v", ":<C-u>vsplit<CR>", opts },
      --  search will center on the line it's found in.
      { "n", "n", "nzzzv", opts },
      { "n", "N", "nzzzV", opts },
      -- move to previous buffer
      { "n", "<leader>q", ":bp<CR>", opts },
      -- move to next buffer
      { "n", "<leader>w", ":bn<CR>", opts },
      -- close buffer
      { "n", "<leader>c", ":bd<CR>", opts },
      -- set working directory
      { "n", "<leader>.", ":lcd %:p:h<CR>", opts },
      -- indent and keep selection
	  { "", ">", ">gv", {} },
	  { "", "<", "<gv", {} },
      -- clean highlightings
      {"n", "<leader><space>", ":noh<CR>", opts},
	}

	for _, val in pairs(mappings) do
		api.nvim_set_keymap(unpack(val))
	end
end

local function set_options()
	local options = {
        clipboard = "unnamedplus",
        termguicolors = true,
        shortmess = "I",
        swapfile = false,
        backup = false,
        writebackup = false,
        undofile = true,
        undolevels = 1000,
        undoreload = 1000,
        showbreak = "↪",
        hidden = true,
        autowrite = true,
        ignorecase = true,
        wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*/tmp/*,*.so,*.swp,*.zip,*.db,*.sqlite",
        shiftwidth = 4,
        tabstop = 4,
        expandtab = true,
        softtabstop = 4,
        shiftround = true,
        autoindent = true,
        updatetime = 300,
        showmode = false,
        signcolumn = "yes",
        relativenumber = true,
        number = true
    }

	for key, val in pairs(options) do
		opt[key] = val
	end

    -- remove trailing whitespace on save
	vim.cmd([[
        autocmd! BufWritePre * :%s/\s\+$//e
    ]])

    -- spell check on markdown
	-- vim.cmd([[
    --     au FileType markdown setl spelllang=pt_br,en spell
    -- ]])

    -- remeber last cursor position
	vim.cmd([[
        augroup vimrc-remember-cursor-position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
    ]])
end

set_globals()
set_mappings()
set_options()
