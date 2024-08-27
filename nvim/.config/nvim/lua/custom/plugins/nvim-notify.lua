return {
	"rcarriga/nvim-notify",
	opts = function(_, opts)
		opts.stages = "fade"
		opts.timeout = 3000
		opts.max_height = 10
		opts.max_width = 10
		opts.on_open = nil
		opts.on_close = nil
		opts.render = "default"
		opts.background_colour = "#000000"
		opts.category = "info"
		opts.icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "✎",
			OFF = "",
		}
	end,
}
