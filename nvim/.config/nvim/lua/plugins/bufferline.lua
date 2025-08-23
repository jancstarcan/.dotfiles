return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local bufferline = require("bufferline")
		local conf = require("telescope.config").values
		local themes = require("telescope.themes")

		-- Gruvbox palette
		local colors = {
			bg0    = "#282828",
			bg1    = "#3c3836",
			fg0    = "#fbf1c7",
			fg1    = "#ebdbb2",
			fg2    = "#d5c4a1",
			red    = "#fb4934",
			green  = "#b8bb26",
			yellow = "#fabd2f",
			blue   = "#83a598",
			purple = "#d3869b",
			aqua   = "#8ec07c",
			gray   = "#928374",
		}

		bufferline.setup({
			options = {
				mode = "buffers",
				diagnostics = "nvim_lsp",
				separator_style = "none",
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = true,
				tab_size = 18,
				max_name_length = 18,
				offsets = {},
			},
			highlights = {
				fill = {
					bg = colors.bg0,
					fg = colors.gray,
				},
				background = {
					bg = colors.bg0,
					fg = colors.gray,
				},
				buffer_selected = {
					bg = colors.bg1,
					fg = colors.fg1,
					bold = true,
				},
				buffer_visible = {
					bg = colors.bg0,
					fg = colors.fg2,
				},
				tab_selected = {
					bg = colors.bg1,
					fg = colors.fg0,
				},
				separator = {
					fg = colors.bg0,
					bg = colors.bg0,
				},
				separator_selected = {
					fg = colors.bg1,
					bg = colors.bg1,
				},
				modified = {
					fg = colors.yellow,
					bg = colors.bg0,
				},
				modified_selected = {
					fg = colors.yellow,
					bg = colors.bg1,
				},
				error = {
					fg = colors.red,
					bg = colors.bg0,
				},
				error_selected = {
					fg = colors.red,
					bg = colors.bg1,
				},
				warning = {
					fg = colors.yellow,
					bg = colors.bg0,
				},
				warning_selected = {
					fg = colors.yellow,
					bg = colors.bg1,
				},
				info = {
					fg = colors.blue,
					bg = colors.bg0,
				},
				info_selected = {
					fg = colors.blue,
					bg = colors.bg1,
				},
			},
		})

		--- Telescope buffer picker (ivy style)
		local function toggle_telescope_buffers()
			local buffers = {}
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
					table.insert(buffers, vim.api.nvim_buf_get_name(buf))
				end
			end

			local opts = themes.get_ivy({
				prompt_title = "Buffers",
			})

			require("telescope.pickers").new(opts, {
				finder = require("telescope.finders").new_table({
					results = buffers,
				}),
				previewer = conf.file_previewer(opts),
				sorter = conf.generic_sorter(opts),
			}):find()
		end

		-- Keymaps
		vim.keymap.set("n", "<C-e>", toggle_telescope_buffers, { desc = "Telescope buffer picker" })
		vim.keymap.set("n", "<C-p>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
		vim.keymap.set("n", "<C-n>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete buffer" })
	end,
}
