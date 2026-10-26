return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings. K, [d, ]d, <C-w>d, grn, gra, grr, gri are nvim 0.11 defaults.
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", function() Snacks.picker.lsp_references() end, opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", function() Snacks.picker.lsp_type_definitions() end, opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", function() Snacks.picker.diagnostics({ buf = 0 }) end, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Disable LSP file watchers — libuv hits EMFILE in monorepos on macOS
		capabilities.workspace = capabilities.workspace or {}
		capabilities.workspace.didChangeWatchedFiles = {
			dynamicRegistration = false,
			relativePatternSupport = false,
		}

		-- Diagnostics config — tiny-inline-diagnostic handles virtual text
		vim.diagnostic.config({
			update_in_insert = false,
			virtual_text = false,
			float = {
				source = true,
			},
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- Apply capabilities to every server (new vim.lsp.config API, lspconfig v3)
		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.config("svelte", {
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		vim.lsp.config("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			filetypes = {
				"html", "css", "sass", "scss", "less", "svelte",
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		vim.lsp.enable({
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"pyright",
			"svelte",
			"graphql",
			"emmet_ls",
			"biome",
			"lua_ls",
			"prismals",
		})
	end,
}
