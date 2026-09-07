return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000, -- needs to be loaded in first
	opts = {
		options = {
			show_source = true,
			multiline = true,
			virt_texts = {
				priority = 9999,
			},
		},
	},
	keys = {
		{
			"<leader>td",
			function()
				require("tiny-inline-diagnostic").toggle()
			end,
			desc = "Toggle inline diagnostics",
		},
	},
}
