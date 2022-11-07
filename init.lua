-- Globals
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.python3_host_prog = "python"

-- Options
vim.o.clipboard = "unnamedplus" -- use system clipboard
vim.o.swapfile = false -- don't use swapfile for a buffer
vim.o.signcolumn = "yes" -- show sign columns (even blank)
vim.o.number = true -- show line numbers
vim.o.shortmess = vim.o.shortmess.."I" -- don't show nvim intro message
vim.o.termguicolors = true -- enables 24-bit RGB color in the TUI
vim.o.showmode = false -- show mode in last line
vim.o.showbreak = "↪" -- string to put at the start of lines that have been wrapped
vim.bo.undofile = true -- automatically saves undo history
vim.o.ignorecase = true -- ignore case in search patterns
vim.bo.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent
vim.bo.tabstop = 4 -- number of spaces that a <Tab> in the file counts for
vim.bo.expandtab = true -- in Insert mode: Use the appropriate number of spaces to insert a <Tab>
vim.bo.softtabstop = 4 -- number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
vim.o.shiftround = true -- round indent to multiple of 'shiftwidth'.  Applies to > and < commands.
vim.o.updatetime = 300 -- if this many milliseconds nothing is typed the swap file will be written to disk. Also used for the CursorHold autocommand event.



-- Mappings
vim.keymap.set('n', "<leader>h", [[<Cmd>split<CR>]]) -- split horizontally
vim.keymap.set('n', "<leader>v", [[<Cmd>vsplit<CR>]]) -- split vertically
vim.keymap.set('n', "<leader><space>", [[<Cmd>noh<CR>]]) -- clear search highlight
vim.keymap.set('n', "n", [[nzzzv]]) -- search will center on the line it's found in
vim.keymap.set('n', "N", [[Nzzzv]]) -- search will center on the line it's found in
vim.keymap.set('n', "<leader>q", [[<Cmd>bp<CR>]]) -- move to previous buffer
vim.keymap.set('n', "<leader>w", [[<Cmd>bn<CR>]]) -- move to next buffer
vim.keymap.set('n', "<leader>c", [[<Cmd>bd<CR>]]) -- close current buffer
vim.keymap.set('n', "<leader>.", [[<Cmd>lcd %:p:h<CR>]]) -- set current file directory as working directory
vim.keymap.set('v', "<", [[<gv]]) -- move code forward in visual mode
vim.keymap.set('v', ">", [[>gv]]) -- move code backward in visual mode


-- Auto Commands

-- remember last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.cmd(":%s/\\s\\+$//e")
    end,
})
