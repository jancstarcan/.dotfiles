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
