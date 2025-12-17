local wezterm = require 'wezterm'

return {
	-- Shell
	default_prog = { '/bin/zsh', '--login' },

	-- Font
	font = wezterm.font {
		family = 'JetBrains Mono Nerd Font',
		weight = 'Medium',
	},
	font_size = 14.0,

	custom_block_glyphs = false,

	-- Window
	window_decorations = 'NONE',
	window_padding = {
		left = 12,
		right = 12,
		top = 12,
		bottom = 12,
	},
	adjust_window_size_when_changing_font_size = false,

	-- Colors
	colors = {
		foreground = '#abb2bf',
		background = '#1e1e1e',

		cursor_bg = '#fabd2f',
		cursor_fg = '#282828',
		cursor_border = '#fabd2f',

		selection_bg = '#665c54',
		selection_fg = '#ebdbb2',

		ansi = {
			'#282828', -- black
			'#e06c75', -- red
			'#98c379', -- green
			'#e5c07b', -- yellow
			'#61afef', -- blue
			'#c678dd', -- magenta
			'#56b6c2', -- cyan
			'#abb2bf', -- white
		},

		brights = {
			'#5c6370', -- bright black
			'#e06c75',
			'#98c379',
			'#e5c07b',
			'#61afef',
			'#c678dd',
			'#56b6c2',
			'#ffffff',
		},
	},

	-- Rendering tweaks (this is where WezTerm wins)
	freetype_load_target = 'Normal',
	freetype_render_target = 'HorizontalLcd',
	freetype_load_flags = 'NO_HINTING',

	-- Performance sanity
	enable_tab_bar = false,
	use_fancy_tab_bar = false,
}
