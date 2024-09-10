return {
	"rcarriga/nvim-notify",
	opts = function(_, opts)
		opts.stages = nil
		opts.timeout = 5000
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
