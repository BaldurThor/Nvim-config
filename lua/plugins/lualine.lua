return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false, -- Make sure lualine is loaded at startup
	config = function()
		local ignore_fts = { "snacks_dashboard", "toggleterm", "NvimTree" }
		local function Get_filename()
			if vim.bo.filetype == ignore_fts[1] then
				return [[Dashboard]]
			elseif vim.bo.filetype == ignore_fts[2] then
				return [[Terminal]]
			elseif vim.bo.filetype == ignore_fts[3] then
				return [[Tree]]
			else
				return require("lualine.components.filename"):new():update_status()
			end
		end
		local function Get_file_type()
			if vim.tbl_contains(ignore_fts, vim.bo.filetype) then
				return [[]]
			else
				return require("lualine.components.filetype"):new():update_status()
			end
		end
		local function Get_progress()
			if vim.tbl_contains(ignore_fts, vim.bo.filetype) then
				return [[]]
			else
				return require("lualine.components.progress")()
			end
		end
		local function Get_location()
			if vim.tbl_contains(ignore_fts, vim.bo.filetype) then
				return [[]]
			else
				return require("lualine.components.location")()
			end
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
