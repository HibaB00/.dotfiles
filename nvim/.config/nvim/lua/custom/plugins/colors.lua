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
				colors.fg = "#D8DCE8"
				colors.fg_dark = "#B8BCC8"
				colors.fg_gutter = "#50546A"
				colors.comment = "#5A5F78"
				colors.dark3 = "#50546A"
				colors.dark5 = "#6A6F88"
				colors.terminal_black = "#282C3C"

				-- Cool but vivid: each role gets a distinct, saturated hue
				colors.blue = "#7AA2F7"        -- keywords (return, export, function, const)
				colors.blue1 = "#82AAFF"
				colors.blue2 = "#5A8BC0"
				colors.blue5 = "#89DDFF"       -- punctuation / operators
				colors.blue6 = "#B4CCEC"
				colors.blue7 = "#5A6E96"
				colors.cyan = "#7DCFFF"         -- types, JSX components
				colors.teal = "#73DACA"         -- methods, properties
				colors.magenta = "#C7A1FF"      -- tags, decorators
				colors.magenta2 = "#BB9AF7"
				colors.purple = "#BB9AF7"       -- numbers, booleans, constants
				colors.green = "#9DC8FF"        -- strings (cool blue tint instead of warm green)
				colors.green1 = "#8AB8F0"
				colors.green2 = "#6A8AC0"
				colors.yellow = "#E0CCFF"       -- variables, parameters
				colors.orange = "#A9C5FF"       -- literals / special identifiers
				colors.red = "#F38BA8"          -- errors, deletions
				colors.red1 = "#E5779A"
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
