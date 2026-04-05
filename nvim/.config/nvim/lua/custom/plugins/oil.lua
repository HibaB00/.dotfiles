return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 2,
				max_width = 120,
				max_height = 40,
			},
			keymaps = {
				["q"] = "actions.close",
			},
		},
		keys = {
			{ "<leader>-", "<cmd>Oil<CR>", desc = "Open parent directory" },
			{ "<leader>o", function() require("oil").toggle_float() end, desc = "Oil float" },
		},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	},
}
