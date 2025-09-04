return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false, -- Make sure lualine is loaded at startup
	config = function()
		local function Get_filename()
			return require("lualine.components.filename").get()
		end
		local function Get_file_type()
			return require("lualine.components.filetype").get()
		end
		local function Get_progress()
			return require("lualine.components.progress").get()
		end
		local function Get_location()
			return require("lualine.components.location").get()
		end
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

				show_unnamed_buf_in_tabline = true,
				always_divide_middle = true,

				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch" },
					{ "diff" },
					{ "diagnostics" },
				},
				lualine_c = {
					{ Get_filename },
				},
				lualine_x = {
					{ "encoding" },
					{ "fileformat" },
					{ Get_file_type },
				},
				lualine_y = {
					{ Get_progress },
				},
				lualine_z = {
					{ Get_location },
				},
			},
			inactive_sections = {
				lualine_c = { Get_filename },
				lualine_x = { Get_location },
			},
		})
	end,
}
