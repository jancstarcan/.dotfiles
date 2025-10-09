return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},

	config = function()
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
		end

		vim.diagnostic.config({
			virtual_text = true,
			severity_sort = true,
			float = {
				style = 'minimal',
				border = 'rounded',
				header = '',
				prefix = '',
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = '✘',
					[vim.diagnostic.severity.WARN] = '▲',
					[vim.diagnostic.severity.HINT] = '⚑',
					[vim.diagnostic.severity.INFO] = '»',
				},
			},
		})

		-- Add borders to floating windows
		vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
			vim.lsp.handlers.hover,
			{ border = 'rounded' }
		)
		vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{ border = 'rounded' }
		)

		vim.lsp.config("lua_ls", {
			settings = { Lua = { diagnostics = { globals = { "vim" } } } }
		})

		-- Add cmp_nvim_lsp capabilities before setting up servers
		local lspconfig_defaults = require('lspconfig').util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			'force',
			lspconfig_defaults.capabilities,
			require('cmp_nvim_lsp').default_capabilities()
		)

		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
			end,
		})

		local on_attach = function(client, bufnr)
			if vim.lsp.inlay_hint then
				vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
			end

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
					callback = function()
						local ft = vim.bo.filetype
						if ft == "c" or ft == "cpp" then
							-- Use clang-format for C/C++
							vim.cmd("silent! !clang-format -i %")
							vim.cmd("edit") -- reload buffer to reflect changes
						elseif vim.lsp.buf.server_ready() then
							-- For all other languages, use LSP formatting
							vim.lsp.buf.format({ async = false })
						end
					end,
				})
			end
		end

		require('mason').setup({})

		require('mason-lspconfig').setup({
			ensure_installed = {},
			handlers = {
				-- Default handler, applies to all servers except the ones we skip
				function(server_name)
					if server_name == "clangd" or server_name == "lua_ls" or server_name == "jdtls" then
						return
					end
					require('lspconfig')[server_name].setup({ on_attach = on_attach })
				end,
			},
		})

		local lspconfig = require("lspconfig")

		lspconfig.jdtls.setup({
			root_dir = lspconfig.util.root_pattern("gradlew", ".git", "build.gradle"),
		})

		lspconfig.lua_ls.setup {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		}

		-- clangd setup (fixed duplication and config)
		lspconfig.clangd.setup {
			cmd = {
				"clangd",
				"--header-insertion=never",
				"--inlay-hints=false",
				"--fallback-style=file",
			},
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
			settings = {
				clangd = {
					InlayHints = {
						ParameterNames = false,
						DeductedType = false,
					},
				},
			},
		}

		require('luasnip.loaders.from_vscode').lazy_load()
		vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

		-- Autocompletion config (cmp)
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			preselect = "item",
			completion = {
				autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				documentation = cmp.config.window.bordered(),
			},
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "buffer",  keyword_length = 3 },
				{ name = "luasnip", keyword_length = 2 },
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
					local luasnip = require("luasnip")
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					local luasnip = require("luasnip")
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
