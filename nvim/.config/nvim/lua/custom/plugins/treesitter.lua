local parsers = {
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
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- needs the tree-sitter CLI (brew "tree-sitter-cli") to build parsers
		lazy = false, -- main doesn't support lazy-loading
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true }),
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang then
						return
					end
					local function start()
						if pcall(vim.treesitter.start, args.buf, lang) then
							vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						end
					end
					-- auto_install: fetch missing parsers on first open, then highlight
					if
						not vim.list_contains(ts.get_installed(), lang)
						and vim.list_contains(ts.get_available(), lang)
					then
						ts.install(lang):await(vim.schedule_wrap(function()
							if vim.api.nvim_buf_is_valid(args.buf) then
								start()
							end
						end))
						return
					end
					start()
				end,
			})

			-- Incremental selection via nvim 0.12's built-in `an` / `in` node selection
			vim.keymap.set("n", "<C-space>", "van", { remap = true, desc = "Start node selection" })
			vim.keymap.set("x", "<C-space>", "an", { remap = true, desc = "Grow node selection" })
			vim.keymap.set("x", "<bs>", "in", { remap = true, desc = "Shrink node selection" })
		end,
	},
	{ "windwp/nvim-ts-autotag", event = { "BufReadPre", "BufNewFile" }, opts = {} },
}
