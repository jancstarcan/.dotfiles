-- Set leader to space
vim.g.mapleader = " "

-- Vim file explorer
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- Alt Up/Down in vscode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copy and paste to system clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+p')
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')

-- Add newline
vim.keymap.set("i", "<S-CR>", "o")
vim.keymap.set("n", "<S-CR>", "o")

-- Indent whole file
vim.keymap.set("n", "<leader>=", "gg=G<C-o>")

-- Center view
vim.keymap.set("n", "<C-z>", "zz")
vim.keymap.set("i", "<C-z>", "<C-o>zz")

-- Better C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- Open pdf with current file name
local function open_pdf()
	local pdffile = vim.fn.expand("%:r") .. ".pdf"

	vim.fn.system("pkill -f zathura")

	vim.fn.system("zathura " .. pdffile .. " & disown")
	print("Opened PDF: " .. pdffile)
end
vim.keymap.set("n", "<leader>v", open_pdf, { noremap = true, silent = true })

-- Start typst live preview
vim.keymap.set("n", "<leader>p", ":TypstPreview<CR>")
