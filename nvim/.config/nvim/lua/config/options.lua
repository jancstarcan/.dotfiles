vim.opt.number = true
vim.opt.cursorline = false
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.guifont = "JetBrains:h20"

vim.opt.undofile = true;
vim.opt.undodir = vim.fn.expand("~/.undodir//");

vim.opt.guicursor = "n-v-c:block"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typst",
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
		vim.bo.expandtab = true
	end,
})
