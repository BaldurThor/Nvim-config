-- Mason is a package manager for LSP, DAP, Linters, and Formatters
return {
	"neovim/nvim-lspconfig",
	opts = {},
	dependencies = {
		{
			"mason-org/mason.nvim",
			config = true,
			opts = {
				ui = {
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
		{ "j-hui/fidget.nvim", opts = {} },
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
			-- The opts are now configured in the main config function below
			opts = {},
		},
	},
	config = function()
		------------------------------------------------------------------
		-- THE ONLY PLACES YOU NEED TO EDIT ARE RIGHT HERE
		------------------------------------------------------------------
		-- 1. Add LSP servers here
		local servers = {
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
		}

		-- 2. Add formatters here, mapped to their filetypes
		local formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
		}
		------------------------------------------------------------------
		-- The rest is automatic. No need to edit below this line.
		------------------------------------------------------------------

		-- Logic to automatically build the list of tools to install
		local ensure_installed = vim.tbl_keys(servers)
		local tool_set = {}
		for _, tool in ipairs(ensure_installed) do
			tool_set[tool] = true
		end
		for _, ft_formatters in pairs(formatters_by_ft) do
			for _, formatter in ipairs(ft_formatters) do
				if not tool_set[formatter] then
					table.insert(ensure_installed, formatter)
					tool_set[formatter] = true
				end
			end
		end

		-- Mason and lspconfig setup
		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server_opts = servers[server_name] or {}
					server_opts.capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
					require("lspconfig")[server_name].setup(server_opts)
				end,
			},
		})

		-- Configure conform.nvim using our single source of truth
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = formatters_by_ft, -- Use our central list
		})

		--- Diagnostic configuration (unchanged)
		local signs = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰋽",
		}
		vim.diagnostic.config({
			virtual_text = false,
			signs = { text = signs },
			underline = true,
			update_in_insert = true,
			severity_sort = true,
		})

		local highlight_groups = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		}
		local namespace = vim.api.nvim_create_namespace("custom_diag_virtual_text")
		local is_in_insert_mode = false
		local function custom_virtual_text_handler(bufnr)
			bufnr = bufnr or 0
			vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
			local diagnostics = vim.diagnostic.get(bufnr)
			local lines_with_diagnostics = {}
			for _, diag in ipairs(diagnostics) do
				if not lines_with_diagnostics[diag.lnum] then
					lines_with_diagnostics[diag.lnum] = diag
				end
			end
			local line_count = vim.api.nvim_buf_line_count(bufnr)
			for lnum, diag in pairs(lines_with_diagnostics) do
				if lnum < line_count then
					local icon = signs[diag.severity] or ""
					local hl_group = highlight_groups[diag.severity] or "DiagnosticVirtualText"
					vim.api.nvim_buf_set_extmark(bufnr, namespace, lnum, 0, {
						virt_text = { { icon .. " " .. diag.message, hl_group } },
						virt_text_pos = "eol",
					})
				end
			end
		end
		local augroup = vim.api.nvim_create_augroup("custom_diag_virtual_text_group", { clear = true })
		vim.api.nvim_create_autocmd("DiagnosticChanged", {
			group = augroup,
			callback = function(args)
				if not is_in_insert_mode then
					custom_virtual_text_handler(args.buf)
				end
			end,
		})
		vim.api.nvim_create_autocmd("InsertEnter", {
			group = augroup,
			callback = function(args)
				is_in_insert_mode = true
				vim.api.nvim_buf_clear_namespace(args.buf, namespace, 0, -1)
				vim.diagnostic.config({ signs = false })
			end,
		})
		vim.api.nvim_create_autocmd("InsertLeave", {
			group = augroup,
			callback = function(args)
				is_in_insert_mode = false
				vim.diagnostic.config({ signs = { text = signs } })
				custom_virtual_text_handler(args.buf)
			end,
		})
	end,
}
