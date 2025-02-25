-- NeoGit

local neogit = { "NeogitOrg/neogit" }

neogit.opts = {
    commit_editor = { kind = "split" },
    commit_select_view = { kind = "vsplit" },
    commit_view = { kind = "vsplit" },
    log_view = { kind = "tab" },
    rebase_editor = { kind = "auto" },
    reflog_view = { kind = "floating" },
    merge_editor = { kind = "auto" },
    description_editor = { kind = "auto" },
    tag_editor = { kind = "auto" },
    preview_buffer = { kind = "floating_console" },
    popup = { kind = "split" },
    stash = { kind = "vsplit" },
    refs_view = { kind = "floating" },
}

neogit.keys = {
	{ "<localleader>g", "<cmd>Neogit<cr>", desc = "Open git", { silent = true } }
}

-- Diff view

local diffview = { "sindrets/diffview.nvim" }

diffview.opts = {
    use_icons = false
}
diffview.keys = {
    { "<localleader><C-g>d", "<cmd>DiffviewOpen<cr>", desc = "Open diffview", { silent = true } },
    { "<localleader><C-g>c", "<cmd>DiffviewClose<cr>", desc = "Close diffview", { silent = true } },
    { "<localleader><C-g>r", "<cmd>DiffviewRefresh<cr>", desc = "Refresh diffview", { silent = true } },
    { "<localleader><C-g>l", "<cmd>DiffviewFileHistory<cr>", desc = "Open history", { silent = true } }
}

return { neogit, diffview }
