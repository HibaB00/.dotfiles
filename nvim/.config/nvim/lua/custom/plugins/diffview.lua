return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff view" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Branch history" },
	},
	opts = {
		enhanced_diff_hl = true,
		view = {
			merge_tool = {
				layout = "diff3_mixed",
			},
		},
	},
}
