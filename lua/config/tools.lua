-- lua/config/tools.lua
-- This file is the single source of truth for all tools managed by Mason.
return {
	-- 1. Add LSP servers here
	servers = {
		pyright = {}, -- No custom settings needed
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		},
	},

	-- 2. Add formatters here, mapped to their filetypes
	formatters = {
		lua = { "stylua" },
		python = { "isort", "black" },
	},

	-- 3. Add linters here (optional, for future use)
	linters = {
		-- Example: bash = { "shellcheck" },
	},
}
