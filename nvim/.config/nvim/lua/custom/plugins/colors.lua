return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			on_colors = function(colors)
				-- Void Space backgrounds
				colors.bg = "#08090E"
				colors.bg_dark = "#060810"
				colors.bg_float = "#0E1018"
				colors.bg_popup = "#0E1018"
				colors.bg_sidebar = "#08090E"
				colors.bg_statusline = "#0E1018"
				colors.bg_highlight = "#141620"
				colors.fg = "#C8CCD8"
				colors.fg_dark = "#B8BCC8"
				colors.fg_gutter = "#50546A"
				colors.comment = "#50546A"
				colors.dark3 = "#50546A"
				colors.dark5 = "#50546A"
				colors.terminal_black = "#282C3C"

				-- Kill warm colors — remap to blue/purple/white
				colors.green = "#7A9AD0"
				colors.green1 = "#7A9AD0"
				colors.green2 = "#7A9AD0"
				colors.yellow = "#C8CCD8"
				colors.orange = "#C8CCD8"
				colors.red = "#A08CC0"
				colors.red1 = "#A08CC0"
				colors.teal = "#7A9AD0"
				colors.cyan = "#7A9AD0"
			end,
			on_highlights = function(hl, colors)
				hl.LineNr = { fg = "#50546A", bg = "#08090E" }
				hl.CursorLineNr = { fg = "#C8CCD8", bg = "#0E1018" }
				hl.CursorLine = { bg = "#0E1018" }
				hl.SignColumn = { bg = "#08090E" }
				hl.NormalFloat = { bg = "#0E1018" }
				hl.FloatBorder = { bg = "#0E1018", fg = "#50546A" }
				hl.Pmenu = { bg = "#0E1018" }
				hl.PmenuSel = { bg = "#1A1E2E" }
				hl.TelescopeNormal = { bg = "#08090E" }
				hl.TelescopeBorder = { bg = "#08090E", fg = "#50546A" }
			end,
		})
		vim.cmd("colorscheme tokyonight-night")
	end,
}
