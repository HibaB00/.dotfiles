return {
	"3rd/image.nvim",
	ft = { "markdown", "norg", "org" },
	opts = {
		backend = "kitty",
		integrations = {
			markdown = {
				enabled = true,
				sizing_strategy = "auto",
			},
		},
		max_width = 100,
		max_height = 30,
		max_height_window_percentage = 50,
	},
}
