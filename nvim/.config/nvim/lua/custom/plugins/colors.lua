return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({})
		vim.opt.background = "dark"
		vim.cmd("colorscheme kanagawa")
	end,
}
