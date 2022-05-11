local gitsigns = require("gitsigns")

gitsigns.setup {
  attach_to_untracked = false,
  update_debounce = vim.o.updatetime,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- stylua: ignore start
    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>gu", gs.undo_stage_hunk)
    map("n", "<leader>gp", gs.preview_hunk)
    map("n", "<leader>gS", gs.stage_buffer)
    map("n", "<leader>gR", gs.reset_buffer)
    map("n", "<leader>gb", function() gs.blame_line { full = true } end)
    map("n", "<leader>gd", gs.diffthis)
    map("n", "<leader>gD", function() gs.diffthis("~") end)
    map("n", "<leader>gt", gs.toggle_current_line_blame)
    map("n", "<leader>gT", gs.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    -- stylua: ignore end
  end,
  preview_config = {
    --border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
    border = "solid",
  },
  preview_winhighlight = "Normal:Normal,FloatBorder:WinSeparator",
}
