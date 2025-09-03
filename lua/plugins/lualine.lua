-- lua/plugins/lualine.lua
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = {
					-- Normal Mode (cool blue)
					normal = {
						a = { bg = "#264F78", fg = "#FFFFFF", gui = "bold" },
						b = { bg = "#3C3C3C", fg = "#FFFFFF" },
						c = { bg = "#3C3C3C", fg = "#FFFFFF" },
					},
					-- Insert Mode (green)
					insert = {
						a = { bg = "#336633", fg = "#FFFFFF", gui = "bold" },
						b = { bg = "#3C3C3C", fg = "#FFFFFF" },
						c = { bg = "#3C3C3C", fg = "#FFFFFF" },
					},
					-- Visual Mode (high-contrast orange)
					visual = {
						a = { bg = "#C77526", fg = "#FFFFFF", gui = "bold" },
						b = { bg = "#3C3C3C", fg = "#FFFFFF" },
						c = { bg = "#3C3C3C", fg = "#FFFFFF" },
					},
					-- Replace Mode (red)
					replace = {
						a = { bg = "#993333", fg = "#FFFFFF", gui = "bold" },
						b = { bg = "#3C3C3C", fg = "#FFFFFF" },
						c = { bg = "#3C3C3C", fg = "#FFFFFF" },
					},
					-- Command Mode (light brown/yellow)
					command = {
						a = { bg = "#D28F5A", fg = "#000000", gui = "bold" },
						b = { bg = "#3C3C3C", fg = "#FFFFFF" },
						c = { bg = "#3C3C3C", fg = "#FFFFFF" },
					},
					-- NEW: Terminal Mode (dark gray)
					terminal = {
						a = { bg = "#555555", fg = "#FFFFFF", gui = "bold" },
						b = { bg = "#3C3C3C", fg = "#FFFFFF" },
						c = { bg = "#3C3C3C", fg = "#FFFFFF" },
					},
					-- Inactive statusline
					inactive = {
						a = { bg = "#3C3C3C", fg = "#B3B3B3" },
						b = { bg = "#3C3C3C", fg = "#B3B3B3" },
						c = { bg = "#3C3C3C", fg = "#B3B3B3" },
					},
				},

				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_c = { "filename" },
				lualine_x = { "location" },
			},
		})
	end,
}
