return {
	"mfussenegger/nvim-dap-python",
	dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
	ft = "python",
	lazy = true,
	config = function(_, opts)
		local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(path)
	end,
}
