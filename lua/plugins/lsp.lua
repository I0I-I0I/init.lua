local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
	"williamboman/mason.nvim",
}

M.event = "VeryLazy"

function M.config()
	local lsp = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	require("mason").setup()

	lsp.clangd.setup({ capabilities = capabilities })
	lsp.pyright.setup({ capabilities = capabilities })
	lsp.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				hint = { enable = true },
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME },
				},
				complition = { callSnippet = "Replace" },
				telemetry = { enable = false },
				diagnostics = { globals = { "vim" } },
			},
		},
		single_file_support = true,
	})

	-- Attach/Mappings
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			local opts = { buffer = event.buf }

			if client and client.supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
			else
				vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
			end

			if client and client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end

			vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Lsp Signature" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Lsp Definitions" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { table.insert(opts, { desc = "Lsp declaration" }) })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { table.insert(opts, { desc = "Lsp implementation" }) })
			vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition,
				{ table.insert(opts, { desc = "Lsp type definition" }) })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,
				{ table.insert(opts, { desc = "Show line diagnostics" }) })
			vim.keymap.set("n", "<leader>ll", "<cmd>LspRestart<cr>",
				{ table.insert(opts, { desc = "Restart all lsp" }) })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ float = true, count = 1 })
			end, { desc = "Lsp diagnostic go next" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ float = true, count = -1 })
			end, { desc = "Lsp diagnostic go prev" })
		end,
	})
end

return M
