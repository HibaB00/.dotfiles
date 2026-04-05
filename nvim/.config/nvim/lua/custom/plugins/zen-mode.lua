return {
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
		},
		opts = {
			window = {
				width = 120,
				options = {
					number = false,
					relativenumber = false,
					signcolumn = "no",
				},
			},
			plugins = {
				twilight = { enabled = true },
				kitty = {
					enabled = true,
					font = "+4",
				},
			},
		},
	},
	{
		"folke/twilight.nvim",
		cmd = "Twilight",
		opts = {},
	},
}
