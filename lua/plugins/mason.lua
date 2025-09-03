-- lua/plugins/mason.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0,
						border = "rounded",
					},
				},
			},
		},
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
		},
	},
	config = function()
		local tools_config = require("config.tools")
		local servers = tools_config.servers
		local formatters_by_ft = tools_config.formatters
		local linters_by_ft = tools_config.linters or {}

		-- Build the list of tools to install
		local ensure_installed = vim.tbl_keys(servers)
		do
			local tool_set = {}
			for _, tool in ipairs(ensure_installed) do
				tool_set[tool] = true
			end
			local function add_tools(tools_map)
				for _, tools in pairs(tools_map) do
					for _, tool in ipairs(tools) do
						if not tool_set[tool] then
							table.insert(ensure_installed, tool)
							tool_set[tool] = true
						end
					end
				end
			end
			add_tools(formatters_by_ft)
			add_tools(linters_by_ft)
		end

		-- Setup mason-lspconfig to automatically install the tools
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Get the necessary LSP capabilities from nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Get the lspconfig plugin
		local lspconfig = require("lspconfig")

		-- Loop through the servers defined in tools.lua and set them up
		for server_name, server_opts in pairs(servers) do
			-- Combine the default capabilities with any server-specific ones
			server_opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
			-- Call the setup function for each server
			lspconfig[server_name].setup(server_opts)
		end

		-- Configure conform.nvim using our single source of truth
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return { lsp_format = "never" }
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			formatters_by_ft = formatters_by_ft,
		})

		-- Setup our custom LSP UI
		require("config.lsp").setup()
	end,
}
