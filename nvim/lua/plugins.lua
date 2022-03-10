-- bootstrap Packer
local packer_path = "/site/pack/packer/start/packer.nvim"
local install_path = vim.fn.stdpath("data") .. packer_path
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	local repo = "https://github.com/wbthomason/packer.nvim"
	local clone = { "git", "clone", "--depth", "1", repo, install_path }
	PackerBboostraped = vim.fn.system(clone)
end

vim.cmd([[packadd packer.nvim]])

if PackerBboostraped then
	require("packer").sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- add plugins
local startup = function(use)
	use({ "wbthomason/packer.nvim" })

	-- colorscheme
    use({
        'navarasu/onedark.nvim',
        config = function()
          require("config.onedark")
        end,
    })

    -- barra de status e abas
    use({
        "nvim-lualine/lualine.nvim",
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require("config.lualine")
        end,
    })
    use({
		"jose-elias-alvarez/buftabline.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.buftabline")
		end,
	})

    -- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
		config = function()
			require("config.telescope")
		end,
	})
	use({
		"gelguy/wilder.nvim",
		run = ":UpdateRemotePlugins",
		config = function()
			require("config.wilder")
		end,
	})

	-- git
	use({
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("config.neogit")
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns")
		end,
	})

	-- lsp
	use({
		"nvim-treesitter/nvim-treesitter",
		run = "TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		requires = { { "williamboman/nvim-lsp-installer" } },
		config = function()
			require("config.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"f3fora/cmp-spell",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"quangnguyen30192/cmp-nvim-tags",
			"ray-x/cmp-treesitter",
			"lukas-reineke/cmp-rg",
			"petertriho/cmp-git",
		},
		config = function()
			require("config.cmp")
		end,
	})
	use({
		"mhartington/formatter.nvim",
		config = function()
			require("config.formatter")
		end,
	})
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("config.trouble")
		end,
	})

end

-- load plugins
return require("packer").startup(startup)