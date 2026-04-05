return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>ee", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
		{ "<leader>ef", "<cmd>Neotree reveal<CR>", desc = "Reveal current file in explorer" },
		{ "<leader>ec", "<cmd>Neotree action=close<CR>", desc = "Close file explorer" },
		{ "<leader>er", "<cmd>Neotree action=show source=git_status<CR>", desc = "Git changed files" },
		{ "<leader>eb", "<cmd>Neotree action=show source=buffers<CR>", desc = "Open buffers" },
	},
	opts = {
		close_if_last_window = true,
		filesystem = {
			follow_current_file = {
				enabled = true,
			},
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = {
					".DS_Store",
					"thumbs.db",
				},
				never_show = {
					".git",
				},
			},
		},
		window = {
			width = 35,
			mappings = {
				["<space>"] = "none",
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true,
			},
			git_status = {
				symbols = {
					added = "✚",
					modified = "",
					deleted = "✖",
					renamed = "󰁕",
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
		},
	},
}
