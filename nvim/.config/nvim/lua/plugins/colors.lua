return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = { theme = "gruvbox" },
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = false,
				palette = "warmer",
			})
			vim.cmd("colorscheme codedark")
		end,
	},
	{ "catppuccin/nvim",            name = "catppuccin", priority = 1000 },
	{ "tomasiser/vim-code-dark" },
	{ "marko-cerovac/material.nvim" },
}
