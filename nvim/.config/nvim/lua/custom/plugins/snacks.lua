return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Picker (replaces Telescope)
		picker = {
			sources = {
				files = {
					hidden = true,
					ignored = false,
					exclude = { ".git", "node_modules", "dist", "build", "target" },
				},
			},
		},
		-- Dashboard (replaces alpha-nvim)
		dashboard = {
			preset = {
				header = table.concat({
					"                                              ___       ",
					"                                           ,o88888      ",
					"                                        ,o8888888'      ",
					"                  ,:o:o:oooo.        ,8O88Pd8888\"       ",
					"              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'\"        ",
					"            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O\"          ",
					"           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8\"            ",
					"          , ..:.::o:ooOoOO8O888O8O,COCOO\"              ",
					"         , . ..:.::o:ooOoOOOO8OOOOCOCO\"                ",
					"          . ..:.::o:ooOoOoOO8O8OCCCC\"o                 ",
					"             . ..:.::o:ooooOoCoCCC\"o:o                  ",
					"             . ..:.::o:o:,cooooCo\"oo:o:                 ",
					"          `   . . ..:.:cocoooo\"'o:o:::'                 ",
					"          .`   . ..::ccccoc\"'o:o:o:::'                  ",
					"         :.:.    ,c:cccc\"':.:.:.:.:.'                   ",
					"       ..:.:'`::::c:\"'..:.:.:.:.:.'                     ",
					"     ...:.'.:.:::\"'    . . . . .'                       ",
					"    .. . ....:\"' `   .  . . ''                          ",
					"  . . . ....\"'                                          ",
					"  .. . .\"'                                              ",
					"  .                                                     ",
				}, "\n"),
				keys = {
					{ icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "f", desc = "Find File", action = function() Snacks.picker.files() end },
					{ icon = " ", key = "g", desc = "Find Text", action = function() Snacks.picker.grep() end },
					{ icon = "󰁯 ", key = "r", desc = "Recent Files", action = function() Snacks.picker.recent() end },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
				{
					section = "terminal",
					cmd = "echo 'We are made of star-stuff. — Carl Sagan'",
					padding = 1,
					indent = 4,
				},
			},
		},
		-- Notifier (replaces nvim-notify)
		notifier = {
			enabled = true,
			timeout = 5000,
		},
		-- Indent guides
		indent = {
			enabled = true,
			animate = {
				enabled = true,
			},
		},
		-- Smooth scrolling
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 15, total = 150 },
			},
		},
		-- Terminal (replaces floaterminal.lua)
		terminal = {},
		-- Input (better vim.ui.input)
		input = {},
	},
	keys = {
		-- Picker keymaps (replacing Telescope)
		{ "<leader>pf", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<C-p>", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>ps", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>fh", function() Snacks.picker.help() end, desc = "Help Tags" },
		{ "<leader>lm", function() Snacks.picker.grep() end, desc = "Live Grep" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
		-- Terminal
		{ "<leader>tt", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" } },
	},
}
