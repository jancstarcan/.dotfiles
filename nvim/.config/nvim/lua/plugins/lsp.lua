return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
			if not lspconfig_ok then
				vim.notify("nvim-lspconfig not found!", vim.log.levels.ERROR)
				return
			end

			local mason_ok, mason = pcall(require, "mason")
			if mason_ok then mason.setup({}) end

			local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
			if mason_lsp_ok then
				mason_lsp.setup({ ensure_installed = { "clangd", "jdtls" } })
			end

			local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			if cmp_lsp_ok then
				capabilities = cmp_lsp.default_capabilities()
			end

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }

				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
				vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
				vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

				local function format_buffer()
					vim.lsp.buf.format({ async = true })
				end
				vim.keymap.set({ "n", "x" }, "<F3>", format_buffer, opts)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("FormatOnSaveMixed", { clear = false }),
						buffer = bufnr,
						callback = format_buffer,
					})
				end
			end

			local servers = {
				clangd = {
					cmd = { "clangd", "--header-insertion=never", "--inlay-hints=false", "--fallback-style=file" },
					capabilities = capabilities,
					on_attach = on_attach,
					settings = { clangd = { InlayHints = { ParameterNames = false, DeductedType = false } } },
				},
				jdtls = {
					root_dir = lspconfig.util.root_pattern("gradlew", ".git", "build.gradle"),
					capabilities = capabilities,
					on_attach = on_attach,
				},
				tinymist = {
					capabilities = capabilities,
					on_attach = on_attach,
					cmd = { "tinymist" },
					filetypes = { "typst" },
					settings = {
						preview = {
							background = {
								enabled = false,
							},
						},
					},
				},
			}

			for name, config in pairs(servers) do
				lspconfig[name].setup(config)
			end

			local luasnip_ok, luasnip = pcall(require, "luasnip")
			if luasnip_ok then
				require('luasnip.loaders.from_vscode').lazy_load()
			end

			local cmp_ok, cmp = pcall(require, "cmp")
			if cmp_ok then
				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					preselect = "item",
					completion = {
						autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
						completeopt = "menu,menuone,noinsert",
					},
					window = {
						documentation = nil
					},
					sources = {
						{ name = "path" },
						{ name = "nvim_lsp" },
						{ name = "luasnip", keyword_length = 2 },
						{ name = "buffer", keyword_length = 3 },
					},
					mapping = cmp.mapping.preset.insert({
						["<C-k>"] = cmp.mapping.select_prev_item(),
						["<C-j>"] = cmp.mapping.select_next_item(),
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then cmp.select_next_item() else fallback() end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then cmp.select_prev_item() else fallback() end
						end, { "i", "s" }),
					}),
				})
			end

			vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
		end,
	},
}
