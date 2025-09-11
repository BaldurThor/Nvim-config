local predefined_filetypes = {
	-- Web Development
	"html",
	"css",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"json",
	"xml",
	"yaml",
	"scss",
	"less",
	"php",

	-- Backend & General Purpose
	"python",
	"lua",
	"ruby",
	"perl",
	"go",
	"rust",
	"java",
	"kotlin",
	"scala",
	"groovy",
	"swift",
	"elixir",
	"crystal",

	-- C Family & Systems
	"c",
	"cpp",
	"cs",
	"objectivec",
	"make",
	"cmake",
	"zig",
	"d",

	-- Functional
	"haskell",
	"ocaml",
	"fsharp",
	"clojure",

	-- Shell & Config
	"bash",
	"sh",
	"zsh",
	"fish",
	"powershell",
	"dockerfile",
	"toml",
	"ini",
	"conf",
	"vim",

	-- Markup & Database
	"markdown",
	"sql",
	"graphql",
	"latex",
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatBufferToggle", function()
	vim.b.disable_autoformat = not vim.b.disable_autoformat
end, {
	desc = "Toggle buffer autoformat-on-save",
})

table.sort(predefined_filetypes)

vim.api.nvim_create_user_command("SetFileType", function(opts)
	-- If an argument is provided, set the filetype directly
	if opts.fargs[1] then
		vim.bo.filetype = opts.fargs[1]
		return
	end

	-- If no argument is provided, open a selection window
	vim.ui.select(predefined_filetypes, {
		prompt = "Select Filetype:",
	}, function(choice)
		if not choice then
			return -- User cancelled
		end
		vim.bo.filetype = choice
	end)
end, {
	nargs = "?", -- Allow zero or one argument
	complete = "filetype",
	desc = "Set filetype (e.g., :SetFileType toml) or open selection",
})
