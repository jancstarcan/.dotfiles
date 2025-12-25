local state_file = vim.fn.stdpath('state') .. '/transparent_bg'

local function apply_transparent()
	vim.cmd [[
    highlight Normal       guibg=NONE ctermbg=NONE
    highlight NormalFloat  guibg=NONE ctermbg=NONE
    highlight LineNr       guibg=NONE ctermbg=NONE
    highlight SignColumn   guibg=NONE ctermbg=NONE
    highlight FoldColumn   guibg=NONE ctermbg=NONE
    highlight EndOfBuffer  guibg=NONE ctermbg=NONE
  ]]
end

local function clear_transparent()
	vim.cmd('colorscheme ' .. vim.g.colors_name)
end

vim.api.nvim_create_user_command('ToggleTransparency', function()
	if vim.g.transparent_bg then
		vim.g.transparent_bg = false
		vim.fn.writefile({ '0' }, state_file)
		clear_transparent()
	else
		vim.g.transparent_bg = true
		vim.fn.writefile({ '1' }, state_file)
		apply_transparent()
	end
end, {})

if vim.fn.filereadable(state_file) == 1 then
	local val = vim.fn.readfile(state_file)[1]
	if val == '1' then
		vim.g.transparent_bg = true
	end
end

vim.api.nvim_create_autocmd('ColorScheme', {
	callback = function()
		if vim.g.transparent_bg then
			apply_transparent()
		end
	end,
})

if vim.g.transparent_bg and vim.g.colors_name then
	apply_transparent()
end
