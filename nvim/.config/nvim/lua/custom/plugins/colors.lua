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

				-- Kill warm colors — remap to a cool palette with enough variety
				colors.blue = "#7A9AD0"
				colors.blue1 = "#8AAEE0"
				colors.blue2 = "#6A8AC0"
				colors.blue5 = "#9DB8E0"
				colors.blue6 = "#9DB8E0"
				colors.blue7 = "#5A6E96"
				colors.magenta = "#B8A8D8"
				colors.magenta2 = "#A08CC0"
				colors.purple = "#A08CC0"
				colors.green = "#7A9AD0"
				colors.green1 = "#8AAEE0"
				colors.green2 = "#6A8AC0"
				colors.yellow = "#B8A8D8"
				colors.orange = "#9DB8E0"
				colors.red = "#C89AB8"
				colors.red1 = "#B88AA8"
				colors.teal = "#8AB8C8"
				colors.cyan = "#8AB8C8"
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
