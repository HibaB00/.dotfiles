vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", ":lua<CR>")
vim.keymap.set("n", "<leader><leader>x", ":.lua<CR>")

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/init.lua<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

-- Fire-and-forget Claude tasks: local background (`--bg`) or cloud (`--cloud`)
local function claude_task(flag)
	local file = vim.fn.expand("%:.")
	vim.ui.input({ prompt = "Claude " .. flag .. ": ", default = file ~= "" and "@" .. file .. " " or "" }, function(task)
		if not task or task == "" then
			return
		end
		vim.system({ "claude", flag, task }, { text = true }, function(res)
			local out = vim.trim(res.code == 0 and res.stdout or res.stderr)
			vim.schedule(function()
				vim.notify(out, res.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR, { title = "claude " .. flag })
			end)
		end)
	end)
end
vim.keymap.set("n", "<leader>ab", function() claude_task("--bg") end, { desc = "Claude: background task" })
vim.keymap.set("n", "<leader>ac", function() claude_task("--cloud") end, { desc = "Claude: cloud task" })
vim.keymap.set("n", "<leader>aA", function()
	Snacks.terminal.toggle("claude agents", {
		win = { position = "float", width = 0.9, height = 0.9, border = "rounded", title = " Claude agents ", title_pos = "center" },
	})
end, { desc = "Claude: agent view" })
