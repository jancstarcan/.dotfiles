return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = { theme = "codedark" },
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = true,
				palette = "warmer",
			})
			vim.cmd("colorscheme vscode")
		end,
	},
	{ "catppuccin/nvim",            name = "catppuccin", priority = 1000 },
	{ "tomasiser/vim-code-dark" },
	{ "marko-cerovac/material.nvim" },
	{ "Mofiqul/vscode.nvim", },
	{ "y9san9/y9nika.nvim", },
	{
		"blazkowolf/gruber-darker.nvim",
		opts = {
			bold = true,
		},
	}
}
