return {
	{
		'tpope/vim-fugitive',
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
		config = true,
	},
	{
		'folke/noice.nvim',
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = function()
			require("noice").setup({
				messages = {
					opts = { timeout = 0 },
				},
			})
		end,
	},
	{
		'ggandor/leap.nvim',
		config = function()
			require('leap').add_default_mappings()
			vim.keymap.set({'n', 'x', 'o'}, '<leader>s', '<Plug>(leap)')
			vim.keymap.set('n', '<leader>S', '<Plug>(leap-from-window)')
		end,
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
			})
		end,
	},
}
