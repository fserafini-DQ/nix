return {
	{
		"Exafunction/codeium.vim",
		config = function()
			-- TODO: get the binary path via nix
			vim.g.codeium_bin = "/run/current-system/sw/bin/codeium_language_server"
			vim.g.codeium_enabled = true
			vim.g.codeium_manual = false
			vim.keymap.set("i", "<M-Enter>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<M-]>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<M-[>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<M-Backspace>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
}
