-- lua/config/tools.lua
-- This file is the single source of truth for all tools managed by Mason.
return {
	-- 1. Add LSP servers here
	servers = {
		pyright = {}, -- No custom settings needed
		lua_ls = {
			-- These are the settings passed to the lua-ls server
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					-- This tells lua-ls about the Neovim runtime environment
					runtime = {
						version = "LuaJIT",
					},
					-- This silences the "Undefined global 'vim'" error
					diagnostics = {
						globals = { "vim" },
					},
					-- This helps lua-ls find definitions for your plugins, fixing errors like "Undefined type snacks.Config"
					workspace = {
						checkThirdParty = false, -- Avoids diagnostics in plugin code
						library = {
							-- Add all your lazy plugin directories to the library
							vim.fn.stdpath("data") .. "/lazy",
							-- Add the Neovim runtime library
							vim.fn.expand("$VIMRUNTIME/lua"),
						},
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
