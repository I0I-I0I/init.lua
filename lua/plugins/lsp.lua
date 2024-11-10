local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
	"williamboman/mason.nvim",
}

M.event = "VeryLazy"

function M.config()
	require("mason").setup()

	local lsp = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		capabilities = cmp_nvim_lsp.default_capabilities()
	end

	-- lsp.vtsls.setup({ capabilities = capabilities })
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

	lsp.ts_ls.setup({
		capabilities = capabilities,
		init_options = {
			completions = {
				completeFunctionCalls = true,
			},
			preferences = {
				includeInlayParameterNameHints = 'all',
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
				importModuleSpecifierPreference = 'non-relative',

				includeCompletionsForModuleExports = true,
				quotePreference = "double",
				displayPartsForJSDoc = true,
				generateReturnInDocTemplate = true,
			},
		},
	})

	-- Attach/Mappings
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			local opts = { buffer = event.buf }

			vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Lsp Signature" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Lsp Definitions" })
			vim.keymap.set("n", "gD", vim.lsp.buf.type_definition,
				{ table.insert(opts, { desc = "Lsp type definition" }) })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,
				{ table.insert(opts, { desc = "Show line diagnostics" }) })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ float = true, count = 1 })
			end, { desc = "Lsp diagnostic go next" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ float = true, count = -1 })
			end, { desc = "Lsp diagnostic go prev" })

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if not client then return end

			if client.supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, event.buf,
				{ autotrigger = false })
			else
				vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
			end

			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end
		end,
	})
end

return M
