-- lua/plugins/gitsigns.lua
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			-- The keymaps are configured here
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Hunk Actions
				map("n", "<leader>hs", gs.stage_hunk, { desc = "[S]tage Hunk" })
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[S]tage Hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "[R]eset Hunk" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[R]eset Hunk" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[U]ndo Stage Hunk" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "[P]review Hunk" })

				-- Navigation
				map("n", "]h", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next Hunk" })

				map("n", "[h", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Previous Hunk" })
			end,
		})
	end,
}
