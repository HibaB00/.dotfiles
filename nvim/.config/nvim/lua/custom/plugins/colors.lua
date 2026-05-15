local p = require("custom.palette")

return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			on_colors = function(colors)
				colors.bg = p.bg
				colors.bg_dark = p.bg_dark
				colors.bg_float = p.bg_float
				colors.bg_popup = p.bg_float
				colors.bg_sidebar = p.bg
				colors.bg_statusline = p.bg_float
				colors.bg_highlight = p.bg_highlight
				colors.fg = p.fg
				colors.fg_dark = p.fg_dark
				colors.fg_gutter = p.gutter
				colors.comment = p.comment
				colors.dark3 = p.gutter
				colors.dark5 = p.comment
				colors.terminal_black = p.bg_select

				-- Cool palette mapped onto tokyonight's color slots
				colors.blue = p.blue
				colors.blue1 = p.blue
				colors.blue2 = p.blue
				colors.blue5 = p.cyan
				colors.blue6 = p.variable
				colors.blue7 = p.comment
				colors.cyan = p.cyan
				colors.teal = p.teal
				colors.magenta = p.magenta
				colors.magenta2 = p.purple
				colors.purple = p.purple
				colors.green = p.string
				colors.green1 = p.string
				colors.green2 = p.blue
				colors.yellow = p.variable
				colors.orange = p.number
				colors.red = p.red
				colors.red1 = p.red
			end,
			on_highlights = function(hl)
				hl.LineNr = { fg = p.gutter, bg = p.bg }
				hl.CursorLineNr = { fg = p.fg, bg = p.bg_float }
				hl.CursorLine = { bg = p.bg_float }
				hl.SignColumn = { bg = p.bg }
				hl.NormalFloat = { bg = p.bg_float }
				hl.FloatBorder = { bg = p.bg_float, fg = p.gutter }
				hl.Pmenu = { bg = p.bg_float }
				hl.PmenuSel = { bg = p.bg_select }
				hl.TelescopeNormal = { bg = p.bg }
				hl.TelescopeBorder = { bg = p.bg, fg = p.gutter }
			end,
		})
		vim.cmd("colorscheme tokyonight-night")
	end,
}
