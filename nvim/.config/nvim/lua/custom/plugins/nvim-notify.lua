return {
	"rcarriga/nvim-notify",
	opts = function(_, opts)
		opts.stages = "static"
		opts.timeout = 1000
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
