return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		spec = {
			{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>m", group = "[M]ount" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
		},
	},
}
