return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 300,
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end
			-- Navigation
			map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
			map("n", "[h", gs.prev_hunk, { desc = "Prev hunk" })
			-- Actions
			map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
			map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
			map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
			map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
		end,
	},
}
