return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			-- Setup Telescope
			telescope.setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						".git/",
						"dist/",
						"build/",
						"target/",
						"*.lock",
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
					},
					layout_config = {
						horizontal = {
							preview_width = 0.55,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
					},
				},
			})

			-- Load fzf extension for better performance
			telescope.load_extension("fzf")

			-- Key mappings for Telescope
			vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find Git Files" })
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Grep for String" })

			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local make_entry = require("telescope.make_entry")
			local conf = require("telescope.config").values

			local M = {}

			local live_multigrep = function(opts)
				opts = opts or {}
				opts.cwd = opts.cwd or vim.uv.cwd()

				local finder = finders.new_async_job({
					command_generator = function(prompt)
						if not prompt or prompt == "" then
							return nil
						end

						local pieces = vim.split(prompt, "  ")
						local args = { "rg" }
						if pieces[1] then
							table.insert(args, "-e")
							table.insert(args, pieces[1])
						end

						if pieces[2] then
							table.insert(args, "-g")
							table.insert(args, pieces[2])
						end

						---@diagnostic disable-next-line: deprecated
						return vim.tbl_flatten({
							args,
							{
								"--color=never",
								"--no-heading",
								"--with-filename",
								"--line-number",
								"--column",
								"--smart-case",
							},
						})
					end,
					entry_maker = make_entry.gen_from_vimgrep(opts),
					cwd = opts.cwd,
				})

				pickers
					.new(opts, {
						debounce = 100,
						prompt_title = "Multi Grep",
						finder = finder,
						previewer = conf.grep_previewer(opts),
						sorter = require("telescope.sorters").empty(),
					})
					:find()
			end

			M.setup = function()
				vim.keymap.set("n", "<leader>lm", live_multigrep)
			end

			return M
		end,
	},
}
