return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			-- Setup Telescope
			telescope.setup({})

			-- Key mappings for Telescope
			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find Git Files" })
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Grep for String" })
		end,
	},
}
