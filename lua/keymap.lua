vim.g.mapleader = " "

-- n: Normal
-- v: Visual, Select
-- x: Visual
-- s: Select
-- o: Operator-pending
-- i: Insert
-- l: Insert, Command-line, Lang-Arg
-- c: Command-line
-- t: Terminal

local set = vim.keymap.set

set("i", "<C-a>", "<Home>")
set("i", "<C-e>", "<End>")
set("i", "<C-v>", "<C-o>p")
set("i", "<C-s>", "<Cmd>w<CR>")

set("n", "<C-q>", pcall(require, "bufdelete") and "<Cmd>Bdelete<CR>" or "<Cmd>bdelete<CR>")
set("n", "[j", "<C-o>", { desc = "jump older" })
set("n", "]j", "<C-i>", { desc = "jump newer" })
set("n", "ga", "ggVG", { desc = "select all" })

set("n", "cw", "caw")

set("x", "<Tab>", ">gv")
set("x", "<S-Tab>", "<gv")

set("o", "u", "t_", { desc = "till underscore right" })
set("o", "U", "T_", { desc = "till underscore left" })

set("t", "<esc>", [[<C-\><C-n>]])
