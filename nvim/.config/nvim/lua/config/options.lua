vim.o.number = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.signcolumn = "yes"
vim.o.wrap = false

vim.lsp.inlay_hint.enable(false)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typst",
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
		vim.bo.expandtab = true
	end,
})
