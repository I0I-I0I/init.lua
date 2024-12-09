local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
	"williamboman/mason.nvim",
	"artemave/workspace-diagnostics.nvim"
}

local function setup_servers(servers)
	local lsp = require("lspconfig")
	local diagnostics = require("workspace-diagnostics")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local exclude = { "html", "cssls", "css_variables", "emmet_ls" }
	for name, config in pairs(servers) do
		if not vim.tbl_contains(exclude, name) then
			config.on_attach = function (client, bufnr)
				diagnostics.populate_workspace_diagnostics(client, bufnr)
			end
		end
		config.capabilities = capabilities
		lsp[name].setup(config)
	end
end

function M.config()
	require("mason").setup()

	setup_servers({
		["pyright"] = {},
		["html"] = {},
		["cssls"] = {},
		["css_variables"] = {},
		["ts_ls"] = {
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
		},
		["emmet_ls"] = {
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
		},
		["clangd"] = {
			cmd = { "clangd", "--compile-commands-dir=." },
			filetypes = { "c", "cpp", "objc", "objcpp" },
			root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", ".git"),
			settings = {
				clangd = {
					compilationDatabasePath = ".",
					fallbackFlags = { "-I/usr/x86_64-w64-mingw32/include" },
				}
			}
		},
		["lua_ls"] = {
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
		}
	})

	-- Attach/Mappings
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			local opts = { buffer = event.buf }
			vim.keymap.set("n", "<C-S-]>", vim.lsp.buf.type_definition,
				{ table.insert(opts, { desc = "vim.lsp.buf.type_definition()" }) })

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
