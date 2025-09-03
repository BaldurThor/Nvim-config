-- lua/config/lsp.lua
-- This file contains all the logic for configuring the LSP client
-- and the custom diagnostic UI.

local M = {}

function M.setup()
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
end

return M
