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
			local mason_ok, mason = pcall(require, "mason")
			if mason_ok then mason.setup({}) end

			local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
			if mason_lsp_ok then
				mason_lsp.setup({ ensure_installed = {} })
			end

			local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			if cmp_lsp_ok then
				capabilities = cmp_lsp.default_capabilities()
			end

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }

				vim.lsp.inlay_hint.enable(false);

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
					local ft = vim.bo[bufnr].filetype
					local filepath = vim.fn.expand("%:p")

					if ft == "c" or ft == "cpp" or ft == "h" or ft == "hpp" then
						vim.fn.jobstart({ "clang-format", "-i", filepath }, {
							on_exit = function()
								vim.schedule(function()
									if vim.api.nvim_buf_is_valid(bufnr) then
										vim.cmd("checktime")
									end
								end)
							end,
						})
					else
						vim.lsp.buf.format({ async = false })
					end
				end

				vim.keymap.set({ "n", "x" }, "<leader>c", format_buffer, opts)
				vim.keymap.set({ "n", "x" }, "<F3>", format_buffer, opts)

				--[[ if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("FormatOnSaveMixed", { clear = false }),
						buffer = bufnr,
						callback = format_buffer,
					})
				end ]]
			end

			local servers = {
				jsonls = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
				lua_ls = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
				clangd = {
					on_attach = on_attach,
					capabilities = capabilities,
					cmd = { "clangd" },
				},
				gopls = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						gofumpt = true
					}
				},
				tinymist = {
					on_attach = on_attach,
					capabilities = capabilities,
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
				zls = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						zig = {
							formatting = true,
							inlayHints = false,
						},
					},
				},
				rust_analyzer = {
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							procMacro = {
								enable = true,
							},
							diagnostics = {
								enable = true,
								disabled = { "unresolved-proc-macro" },
							},
							formatting = {
								enable = true,
							},
							inlayHints = {
								enabled = true,
							},
						},
					},
				}
			}

			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
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
						{ name = "buffer",  keyword_length = 3 },
					},
					mapping = cmp.mapping.preset.insert({
						["<C-k>"] = cmp.mapping.select_prev_item(),
						["<C-j>"] = cmp.mapping.select_next_item(),
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
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
	}
}
