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
			opts = {
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
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
				},
			},
		},
	},
	config = function()
		--- NEW: A single list for all servers, formatters, and linters.
		-- Servers with custom settings are defined as tables.
		-- Tools with default settings are just strings.
		local tools = {
			"stylua",
			"isort",
			"black",
			"pyright",
			{
				"lua_ls",
				opts = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			},
		}

		--- Logic to prepare the tool lists for Mason and lspconfig
		local ensure_installed = {}
		local servers_with_opts = {}
		for _, tool in ipairs(tools) do
			if type(tool) == "string" then
				table.insert(ensure_installed, tool)
			elseif type(tool) == "table" then
				local tool_name = tool[1]
				local tool_opts = tool.opts or {}
				table.insert(ensure_installed, tool_name)
				servers_with_opts[tool_name] = tool_opts
			end
		end

		--- Mason and lspconfig setup (mostly unchanged)
		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server_opts = servers_with_opts[server_name] or {}
					server_opts.capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
					require("lspconfig")[server_name].setup(server_opts)
				end,
			},
		})

		-- Google Gemini 2.5 Pro is king

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
				--- UPDATED: Instead of hiding everything, just disable signs.
				vim.diagnostic.config({ signs = false })
			end,
		})

		vim.api.nvim_create_autocmd("InsertLeave", {
			group = augroup,
			callback = function(args)
				is_in_insert_mode = false
				--- UPDATED: Instead of showing everything, just re-enable signs.
				vim.diagnostic.config({ signs = { text = signs } })
				custom_virtual_text_handler(args.buf)
			end,
		})
	end,
}
