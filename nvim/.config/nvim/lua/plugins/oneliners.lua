return {
	{
		'numToStr/Comment.nvim',
		config = function()
			require 'Comment'.setup()
		end,
	},
	{
		'ray-x/go.nvim',
		config = function()
			require 'go'.setup()
		end,
	},
	{
		'brenoprata10/nvim-highlight-colors',
		config = function()
			require('nvim-highlight-colors').setup({})
		end
	},
	{
		'echasnovski/mini.surround',
		config = function()
			require('mini.surround').setup()
		end
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			local npairs = require('nvim-autopairs')

			npairs.setup({
				check_ts = true,
			})
		end,
	},
	{
		'folke/noice.nvim',
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("noice").setup({
				notify = {
					enabled = false,
				},
				messages = {
					opts = { timeout = 0 },
				},
			})
		end,
	},
	{
		'ggandor/leap.nvim',
		config = function()
			vim.keymap.set({ 'n', 'x', 'o' }, '<leader>s', '<Plug>(leap)')
		end,
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				debounce = 100,
				indent = { char = "▏" },
				scope = { enabled = false },
				whitespace = { highlight = { "Whitespace", "NonText" } },
			})
		end,
	},
	{
		'chomosuke/typst-preview.nvim',
		lazy = false,
		version = '1.*',
		opts = {},
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set('n', '<leader>u', ":UndotreeToggle<CR>:UndotreeFocus<CR>")
		end
	},
	{
		"tpope/vim-rsi",
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			vim.g.VM_default_mappings = 0
			vim.g.VM_leader = "\\"

			vim.g.VM_maps = {
				["Add Cursor Down"]    = "<C-.>",
				["Add Cursor Up"]      = "<C-,>",
				["Find Under"]         = "<C-m>",
				["Find Subword Under"] = "<C-m>",
			}
		end,
	},
}
