return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		"*",
		css = { rgb_fn = true },
		html = { names = false },
	},
}
