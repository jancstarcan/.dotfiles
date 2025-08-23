return {
	{
		"ellisonleao/gruvbox.nvim",

		config = function()
			contrast = "hard",
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = true,
				palette = "warmer",
			})

			vim.cmd("colorscheme gruvbox")
		end
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			"gruvbox"
		}
	},
}
