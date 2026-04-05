return {
	"folke/sidekick.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		nes = {
			enabled = true,
		},
		cli = {
			win = {
				layout = "right",
				split = {
					width = 80,
				},
			},
		},
	},
	keys = {
		-- NES
		{
			"<Tab>",
			function()
				require("sidekick").nes_jump_or_apply()
			end,
			desc = "NES: Jump/Apply",
		},
		-- CLI
		{
			"<C-.>",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Sidekick: Toggle CLI",
			mode = { "n", "t" },
		},
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Sidekick: Toggle CLI",
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").select()
			end,
			desc = "Sidekick: Select Tool",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			desc = "Sidekick: Select Prompt",
			mode = { "n", "x" },
		},
		-- Context
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			desc = "Sidekick: Send This",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "Sidekick: Send File",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			desc = "Sidekick: Send Selection",
			mode = { "n", "x" },
		},
	},
}
