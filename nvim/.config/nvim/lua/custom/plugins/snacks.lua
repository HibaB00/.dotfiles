-- Read a web page as markdown in a scratch buffer (render-markdown styles it)
-- ponytail: uses the r.jina.ai reader service (it sees the URL), swap for a local converter if that matters
local function read_url(url)
	vim.cmd("enew")
	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].buftype, vim.bo[buf].bufhidden = "nofile", "wipe"
	-- reading view: soft-wrap at word boundaries, no gutter
	vim.opt_local.number, vim.opt_local.relativenumber = false, false
	vim.opt_local.linebreak, vim.opt_local.signcolumn = true, "no"
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Loading " .. url .. " …" })
	vim.system({ "curl", "-sL", "--max-time", "30", "https://r.jina.ai/" .. url }, { text = true }, function(res)
		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			local text = res.code == 0 and res.stdout ~= "" and res.stdout or ("Couldn't load " .. url)
			-- swap the reader's "Title: … Markdown Content:" header for a plain heading
			local title, body = text:match("^Title: ([^\n]*).-\nMarkdown Content:\n(.*)$")
			if title then
				text = ("# %s\n\n<%s>\n\n%s"):format(title, url, body)
			end			vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n"))
			-- set filetype after the content lands so render-markdown renders it
			vim.bo[buf].filetype = "markdown"
		end)
	end)
end

-- Hacker News front page in a picker; <CR> reads it in nvim, <C-b> opens the browser
local function hacker_news()
	vim.system({ "curl", "-s", "https://hn.algolia.com/api/v1/search?tags=front_page&hitsPerPage=30" }, { text = true }, function(res)
		vim.schedule(function()
			local ok, data = pcall(vim.json.decode, res.stdout or "")
			if not ok then
				return vim.notify("Couldn't load Hacker News", vim.log.levels.ERROR)
			end
			for _, s in ipairs(data.hits) do
				s.text = s.title
			end
			Snacks.picker({
				title = "Hacker News",
				items = data.hits,
				layout = { preset = "sidebar", preview = false, layout = { width = 0.4, min_width = 70 } },
				auto_close = false, -- stay open while reading in the main window
				format = function(s)
					return {
						{ ("%4d▲ %4d💬  "):format(s.points or 0, s.num_comments or 0), "Comment" },
						{ s.title },
					}
				end,
				confirm = function(picker, s)
					-- open in the main window so the panel stays put
					vim.api.nvim_win_call(picker.main, function()
						read_url(s.url or ("https://news.ycombinator.com/item?id=" .. s.objectID))
					end)
				end,
				actions = {
					browser = function(picker, s)
						picker:close()
						vim.ui.open(s.url or ("https://news.ycombinator.com/item?id=" .. s.objectID))
					end,
				},
				win = { input = { keys = { ["<C-b>"] = { "browser", mode = { "n", "i" } } } } },
			})
		end)
	end)
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Picker (replaces Telescope)
		picker = {
			sources = {
				files = {
					hidden = true,
					ignored = false,
					exclude = { ".git", "node_modules", "dist", "build", "target" },
				},
			},
		},
		-- Dashboard (replaces alpha-nvim)
		dashboard = {
			preset = {
				header = table.concat({
					"                                              ___       ",
					"                                           ,o88888      ",
					"                                        ,o8888888'      ",
					"                  ,:o:o:oooo.        ,8O88Pd8888\"       ",
					"              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'\"        ",
					"            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O\"          ",
					"           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8\"            ",
					"          , ..:.::o:ooOoOO8O888O8O,COCOO\"              ",
					"         , . ..:.::o:ooOoOOOO8OOOOCOCO\"                ",
					"          . ..:.::o:ooOoOoOO8O8OCCCC\"o                 ",
					"             . ..:.::o:ooooOoCoCCC\"o:o                  ",
					"             . ..:.::o:o:,cooooCo\"oo:o:                 ",
					"          `   . . ..:.:cocoooo\"'o:o:::'                 ",
					"          .`   . ..::ccccoc\"'o:o:o:::'                  ",
					"         :.:.    ,c:cccc\"':.:.:.:.:.'                   ",
					"       ..:.:'`::::c:\"'..:.:.:.:.:.'                     ",
					"     ...:.'.:.:::\"'    . . . . .'                       ",
					"    .. . ....:\"' `   .  . . ''                          ",
					"  . . . ....\"'                                          ",
					"  .. . .\"'                                              ",
					"  .                                                     ",
				}, "\n"),
				keys = {
					{ icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "f", desc = "Find File", action = function() Snacks.picker.files() end },
					{ icon = " ", key = "g", desc = "Find Text", action = function() Snacks.picker.grep() end },
					{ icon = "󰁯 ", key = "r", desc = "Recent Files", action = function() Snacks.picker.recent() end },
					{ icon = "󰎕 ", key = "n", desc = "Hacker News", action = hacker_news },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup", padding = 1 },
				{ text = { "We are made of star-stuff. — Carl Sagan", hl = "Comment" }, align = "center" },
			},
		},
		-- Notifier (replaces nvim-notify)
		notifier = {
			enabled = true,
			timeout = 5000,
		},
		-- Indent guides
		indent = {
			enabled = false,
		},
		-- Smooth scrolling
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 15, total = 150 },
			},
		},
		-- Terminal (replaces floaterminal.lua)
		terminal = {},
		-- Input (better vim.ui.input)
		input = {},
		-- Explorer (left sidebar file tree)
		explorer = { enabled = true },
	},
	keys = {
		-- Picker keymaps (replacing Telescope)
		{ "<leader>pf", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<C-p>", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>ps", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>fh", function() Snacks.picker.help() end, desc = "Help Tags" },
		{ "<leader>lm", function() Snacks.picker.grep() end, desc = "Live Grep" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>hn", hacker_news, desc = "Hacker News" },
		-- Explorer
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
		-- Terminal
		{ "<leader>tt", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" } },
	},
}
