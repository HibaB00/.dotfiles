return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	config = function()
		vim.diagnostic.config({ virtual_text = false })
		require("tiny-inline-diagnostic").setup({
			options = {
				show_source = true,
				multiline = true,
				virt_texts = {
					priority = 9999,
				},
			},
		})
	end,
	keys = {
		{
			"<leader>dd",
			function()
				require("tiny-inline-diagnostic").toggle()
			end,
		},
		desc = "Toggle Tiny Inline Diagnostic",
	},
}
