local M = { "hrsh7th/nvim-cmp", cond = false }

M.dependencies = {
	{ "hrsh7th/cmp-nvim-lsp" },
}

M.event = { "BufRead" }

M.config = function()
	local cmp = require("cmp")

	cmp.setup({
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.abort(),
			["<C-space>"] = cmp.mapping.complete(),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
		}),
		snippet = {
			expand = function(args)
				vim.snippet.expand(args.body)
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
		}),
	})
end

return M
