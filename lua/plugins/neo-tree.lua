-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"kiyoon/nvim-tree-remote.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
	opts = {
		commands = {
			copy_selector = function(state)
				-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
				-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				local filename = node.name
				local modify = vim.fn.fnamemodify

				local results = {
					filepath,
					modify(filepath, ":."),
					modify(filepath, ":~"),
					filename,
					modify(filename, ":r"),
					modify(filename, ":e"),
				}

				vim.ui.select({
					"1. Absolute path: " .. results[1],
					"2. Path relative to CWD: " .. results[2],
					"3. Path relative to HOME: " .. results[3],
					"4. Filename: " .. results[4],
					"5. Filename without extension: " .. results[5],
					"6. Extension of the filename: " .. results[6],
				}, { prompt = "Choose to copy to clipboard:" }, function(choice)
					local i = tonumber(choice:sub(1, 1))
					local result = results[i]
					vim.fn.setreg('"', result)
					vim.notify("Copied: " .. result)
				end)
			end,
		},
		filesystem = {
			window = {
				mappings = {
					["\\"] = "close_window",
					["Y"] = "copy_selector",
				},
			},
		},
	},
	config = function()
      require("neo-tree").setup({
        event_handlers = {
          {
            event = "file_open_requested",
            handler = function(args)
              local nt_remote = require("nvim_tree_remote")
              -- customise the socket_path and tmux options as you like.
              nt_remote.remote_nvim_open('/tmp/nvim_tree_remote_socket', args.open_cmd, args.path, nt_remote.tmux_defaults())

              -- stop default open; we already did it remotely
              return { handled = true }
            end,
          },
        },
      })
    end,
}
