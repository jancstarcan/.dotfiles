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
                    "html",
                    "css",
                    "javascript",
                    "python",
					"java",
					"c",
					"cpp",
					"typst"
                },
                auto_install = false,
            })
        end,
    },
}
