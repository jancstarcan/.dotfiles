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
	{ "Mofiqul/vscode.nvim" },
	{ "tomasiser/vim-code-dark" },
	{ "bruth/vim-newsprint-theme" },
	{ "marko-cerovac/material.nvim" },
}
