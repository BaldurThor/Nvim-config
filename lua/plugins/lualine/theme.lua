local lualine = require("lualine")

local ignore_fts = { "snacks_dashboard", "toggleterm", "NvimTree", "trouble" }

local exclude = function()
	return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 and not vim.tbl_contains(ignore_fts, vim.bo.filetype)
end

local get_filename = function()
	if vim.bo.filetype == ignore_fts[1] then
		return [[Dashboard]]
	elseif vim.bo.filetype == ignore_fts[2] then
		return [[Terminal]]
	elseif vim.bo.filetype == ignore_fts[3] then
		return [[NvimTree]]
	elseif vim.bo.filetype == ignore_fts[4] then
		return [[Trouble]]
	elseif vim.bo.filetype == "checkhealth" then
		return [[CheckHealth]]
	else
		return require("lualine.components.filename"):new():update_status()
	end
end

local get_location = function()
	if vim.tbl_contains(ignore_fts, vim.bo.filetype) then
		return [[]]
	else
		return require("lualine.components.location")()
	end
end

-- Config
local config = {
	options = { theme = "tomorrow_night" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "branch", cond = exclude }, { "diff", cond = exclude }, { "diagnostics", cond = exclude } },
		lualine_c = { get_filename },
		lualine_x = { { "encoding", cond = exclude }, { "fileformat", cond = exclude }, { "filetype", cond = exclude } },
		lualine_y = { { "progress", cond = exclude } },
		lualine_z = { get_location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { get_filename },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_b = {},
		lualine_a = {
			{
				"buffers",
				use_mode_colors = true,
				symbols = {
					modified = " ●",
					alternate_file = "",
					directory = "",
				},
				filetype_names = { NvimTree = "NvimTree", toggleterm = "Terminal", trouble = "Trouble" },
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
}
lualine.setup(config)
