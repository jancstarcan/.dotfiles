return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local ts_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not ts_ok then return end

			configs.setup({
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true },
				ensure_installed = {
					"python",
					"java",
					"c",
					"cpp",
					"rust",
					"typst"
				},
				auto_install = false,
			})
		end,
	},
}
