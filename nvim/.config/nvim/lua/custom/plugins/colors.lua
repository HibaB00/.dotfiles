return {
	"datsfilipe/vesper.nvim",
	name = "vesper",
	config = function()
		require("vesper").setup({
			transparent = false,
		})
		vim.cmd("colorscheme vesper")
	end,
}
