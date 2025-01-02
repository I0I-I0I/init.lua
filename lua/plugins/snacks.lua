local M = { "folke/snacks.nvim" }

M.priority = 1000
M.lazy = false

M.opts = {
	dashboard = {
		enabled = true,
		sections = {
			{
				section = "terminal",
				cmd = "chafa ~/walls/wall-1.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
				height = 17,
				width = 60,
				padding = 2,
			},
			{
				pane = 1,
				section = "startup"
			},
			{
				pane = 2,
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			},
			{
				pane = 2,
				action = ":quit",
				key = "q"
			},
			{
				pane = 2,
				icon = " ",
				desc = "Browse Repo",
				padding = 1,
				key = "b",
				action = function()
					Snacks.gitbrowse()
				end,
			},
			function()
				local in_git = Snacks.git.get_root() ~= nil
				local cmds = {
					{
						title = "Notifications",
						cmd = "gh notify -s -a -n5",
						action = function()
							vim.ui.open("https://github.com/notifications")
						end,
						key = "n",
						icon = " ",
						height = 5,
						enabled = true,
					},
					{
						icon = " ",
						title = "Git Status",
						cmd = "git --no-pager diff --stat -B -M -C",
						height = 10,
					},
				}
				return vim.tbl_map(function(cmd)
					return vim.tbl_extend("force", {
						pane = 2,
						section = "terminal",
						enabled = in_git,
						padding = 1,
						-- ttl = 5 * 60,
						-- indent = 3,
					}, cmd)
				end, cmds)
			end,
		},
	},
	bigfile = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	notify = { enabled = true },
	quickfile = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = {
		left = { "sign", "mark" },
		right = { "fold", "git" },
		folds = {
			open = true,
			git_hl = true,
		},
		git = {
			patterns = { "GitSign" },
		},
		refresh = 50,
	},
	words = { enabled = true },
	git = {
		width = 0.6,
		height = 0.6,
		border = "rounded",
		title = " Git Blame ",
		title_pos = "center",
		ft = "git",
	},
	zen = {
		win = { width = 0.8 },
		on_open = function(_)
			vim.opt.cmdheight = 0
			vim.opt.foldlevel = 0
		end,
		on_close = function(_)
			vim.opt.cmdheight = 1
			vim.opt.foldlevel = 99
		end,
	},
}

M.keys = {
	{ "<leader>zo",  function()
		Snacks.zen({
			toggles = {
				dim = false,
				git_signs = false,
				mini_diff_signs = false,
				inlay_hints = true,
			}
		})
	end, desc = "Toggle Zen Mode" },
	{ "<leader>zf",  function()
		Snacks.zen({
			toggles = {
				dim = true,
				git_signs = false,
				mini_diff_signs = false,
				inlay_hints = false,
			}
		})
	end, desc = "Toggle Zen Mode" },

	{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
	{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
	{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
	{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
	{ "<leader>q",  function() Snacks.bufdelete() end, desc = "Delete Buffer" },
	{ "grN",        function() Snacks.rename.rename_file() end, desc = "Rename File" },
	{ "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
	{ "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
	{
		"<leader>N",
		desc = "Neovim News",
		function()
			Snacks.win({
				file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
				width = 0.6,
				height = 0.6,
				wo = {
					spell = false,
					wrap = false,
					signcolumn = "yes",
					statuscolumn = " ",
					conceallevel = 3,
				},
			})
		end,
	},

	{ "<leader><C-g>", function() Snacks.lazygit() end, desc = "Lazygit" },
	{ "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
	{ "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
	{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
	{ "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Browse", mode = { "n", "v" } },
}

M.init = function()
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			-- Setup some globals for debugging (lazy-loaded)
			_G.dd = function(...)
				Snacks.debug.inspect(...)
			end
			_G.bt = function()
				Snacks.debug.backtrace()
			end
			vim.print = _G.dd -- Override print to use snacks for `:=` command

			-- Create some toggle mappings
			Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
			Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
			Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
			Snacks.toggle.diagnostics():map("<leader>ud")
			Snacks.toggle.line_number():map("<leader>ul")
			Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
			Snacks.toggle.treesitter():map("<leader>uT")
			Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
			Snacks.toggle.inlay_hints():map("<leader>uh")
			Snacks.toggle.indent():map("<leader>ug")
			Snacks.toggle.dim():map("<leader>uD")
		end,
	})

	---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
	local progress = vim.defaulttable()
	vim.api.nvim_create_autocmd("LspProgress", {
		---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
			if not client or type(value) ~= "table" then
				return
			end
			local p = progress[client.id]

			for i = 1, #p + 1 do
				if i == #p + 1 or p[i].token == ev.data.params.token then
					p[i] = {
						token = ev.data.params.token,
						msg = ("[%3d%%] %s%s"):format(
							value.kind == "end" and 100 or value.percentage or 100,
							value.title or "",
							value.message and (" **%s**"):format(value.message) or ""
						),
						done = value.kind == "end",
					}
					break
				end
			end

			local msg = {} ---@type string[]
			progress[client.id] = vim.tbl_filter(function(v)
				return table.insert(msg, v.msg) or not v.done
			end, p)

			local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
			vim.notify(table.concat(msg, "\n"), "info", {
				id = "lsp_progress",
				title = client.name,
				opts = function(notif)
					notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
				end,
			})
		end,
	})
end

return M
