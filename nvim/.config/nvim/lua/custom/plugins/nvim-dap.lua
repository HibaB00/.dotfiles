return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mason.nvim",
		{ "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
		"mfussenegger/nvim-dap-python",
	},
	keys = {
		{ "<F5>", function() require("dap").continue() end, desc = "DAP continue" },
		{ "<F9>", function() require("dap").toggle_breakpoint() end, desc = "DAP toggle breakpoint" },
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end

		-- JS/TS: mason's js-debug-adapter serves both node and chrome targets
		for _, type in ipairs({ "pwa-node", "pwa-chrome" }) do
			dap.adapters[type] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = { command = "js-debug-adapter", args = { "${port}" } },
			}
		end
		for _, lang in ipairs({ "typescript", "javascript", "typescriptreact" }) do
			dap.configurations[lang] = {
				{ type = "pwa-node", request = "launch", name = "Launch file", program = "${file}", cwd = "${workspaceFolder}" },
				{ type = "pwa-node", request = "attach", name = "Attach", processId = require("dap.utils").pick_process, cwd = "${workspaceFolder}" },
				{ type = "pwa-chrome", request = "launch", name = "Launch Chrome (localhost:3000)", url = "http://localhost:3000", webRoot = "${workspaceFolder}" },
			}
		end

		-- Python: mason's debugpy
		require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
	end,
}
