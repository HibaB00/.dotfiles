local web = { "biome", "prettier", stop_after_first = true }

return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ lsp_format = "fallback" })
			end,
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			javascript = web,
			javascriptreact = web,
			typescript = web,
			typescriptreact = web,
			json = web,
			jsonc = web,
			css = web,
			svelte = { "prettier" },
			lua = { "stylua" },
			python = { "black" },
		},
		formatters = {
			biome = { require_cwd = true },
		},
		format_on_save = { timeout_ms = 500 },
	},
}
