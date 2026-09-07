return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master", -- frozen upstream; `main` needs the tree-sitter CLI and a rewrite of this file
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					-- Core
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					-- Web
					"javascript",
					"typescript",
					"tsx",
					"json",
					"jsonc",
					"html",
					"css",
					"scss",
					-- Backend
					"go",
					"python",
					"bash",
					-- Config/Markup
					"yaml",
					"toml",
					"markdown",
					"markdown_inline",
					-- Misc
					"regex", -- silences noice's regex parser warning, used for cmdline highlighting
					"svelte",
					"vue",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{ "windwp/nvim-ts-autotag", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
