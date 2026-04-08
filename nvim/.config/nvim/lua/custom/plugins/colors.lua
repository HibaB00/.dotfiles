return {
	"bluz71/vim-nightfly-colors",
	name = "nightfly",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.nightflyCursorColor = true
		vim.g.nightflyTerminalColors = true
		vim.g.nightflyNormalFloat = true
		vim.opt.background = "dark"
		vim.cmd("colorscheme nightfly")
	end,
}
