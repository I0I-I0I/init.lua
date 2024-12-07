local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
	"williamboman/mason.nvim",
	"artemave/workspace-diagnostics.nvim"
}

function M.config()
	require("mason").setup()

	local lsp = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	-- Frontend
	lsp.ts_ls.setup({
		on_attach = function(client, bufnr)
			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		end,
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
		}
	})
	lsp.html.setup({ capabilities = capabilities })
	lsp.cssls.setup({ capabilities = capabilities })
	lsp.css_variables.setup({ capabilities = capabilities })
	lsp.emmet_ls.setup({
		capabilities = capabilities,
		filetypes = {
			"css",
			"eruby",
			"html",
			"javascript",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"svelte",
			"pug",
			"typescriptreact",
			"vue"
		},
		init_options = {
			html = {
				options = { ["bem.enabled"] = true, },
			}
		}
	})

	-- Other
	lsp.clangd.setup({
		on_attach = function(client, bufnr)
			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		end,
		capabilities = capabilities,
		cmd = { "clangd", "--compile-commands-dir=." },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", ".git"),
		settings = {
			clangd = {
				compilationDatabasePath = ".",
				fallbackFlags = { "-std=c++17", "-I/usr/x86_64-w64-mingw32/include" },
			}
		}
	})
	lsp.pyright.setup({
		on_attach = function(client, bufnr)
			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		end,
		capabilities = capabilities
	})

	-- Lua
	lsp.lua_ls.setup({
		on_attach = function(client, bufnr)
			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		end,
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
		single_file_support = true
	})

	-- Attach/Mappings
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			local opts = { buffer = event.buf }
			vim.keymap.set("n", "<C-S-]>", vim.lsp.buf.type_definition,
				{ table.insert(opts, { desc = "Lsp type definition" }) })
			vim.keymap.set("n", "gre", vim.diagnostic.open_float,
				{ table.insert(opts, { desc = "Show line diagnostics" }) })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ float = true, count = 1 })
			end, { desc = "Lsp diagnostic go next" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ float = true, count = -1 })
			end, { desc = "Lsp diagnostic go prev" })

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if not client then return end

			if client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, event.buf,
				{ autotrigger = false })
			end

			local keys = { ".", "->", ":" }
			for _, key in ipairs(keys) do
				vim.keymap.set("i", key, key .. "<C-x><C-o>", { buffer = event.buf })
			end

			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end
		end
	})
end

return M
