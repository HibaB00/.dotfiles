return {
	"echasnovski/mini.icons",
	lazy = false,
	config = function()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons() -- lualine still asks for nvim-web-devicons
	end,
}
