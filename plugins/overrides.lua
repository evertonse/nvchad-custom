-- local status_ok, nvim_tree = pcall(require, "nvim-tree")
-- if not status_ok then
--   return
-- end
-- local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- if not config_status_ok then
--   return
-- end

local M = {}

vim.treesitter.language.register("c", "cl") -- the .cl filetype will use the c parser and queries.
M.treesitter = {
  matchup = {
    enable = false, -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
    -- [options]
  },
  -- run = ':TSPUpdate',
  ensure_installed = {
    "bash",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "query",
    "regex",
    "tsx",
    "typescript",
    "vim",
    "yaml",
    "c",
    "cpp",
    "vimdoc",
    -- --"typescript", "toml","tsx", "css",
    "rust",
    "java",
    "markdown_inline",
  }, -- one of "all" or a list of languages
  sync_install = true,
  auto_install = true,
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = true,
    disable = {}, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
    custom_captures = {},
  },

  autopairs = {
    enable = true,
  },

  indent = { enable = true, disable = {} },
  markid = { enable = true },

  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },

  illuminate = {
    enable = true,
    loaded = false,
  },

  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {
      init_selection = "gis",
      scope_incremental = "gsi",
      node_incremental = "gni",
      node_decremental = "gnd",
    },
  },

  context_commentstring = {
    enable = true,
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 250, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sn"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sN"] = "@parameter.inner",
      },
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    "autoflake",
    "bash-language-server",
    "html-lsp",
    "jdtls",
    "lua-language-server",
    "opencl-language-server",
    "rust-analyzer",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "bash-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- python
    "black",
    "flake8",
    "debugpy",
    "mypy",
    "ruff",
    "pyright",
  },
}

local function nvimtree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local function edit_or_open()
    local node = api.tree.get_node_under_cursor()
    api.tree.reload()
    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file
      --api.node.open.edit()
      api.node.open.no_window_picker()
      -- Close the tree if file was opened
      api.tree.close()
    end
  end
  -- Default mappings. Feel free to modify or remove as you wish.
  --
  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set("n", "sC-]s", api.tree.change_root_to_node, opts "CD")
  vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts "Open: In Place")
  vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts "Info")
  vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts "Rename: Omit Filename")
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts "Open: New Tab")
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts "Open: Horizontal Split")
  vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts "Open Preview")
  vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts "Next Sibling")
  vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts "Previous Sibling")
  vim.keymap.set("n", ".", api.node.run.cmd, opts "Run Command")
  vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts "Up")
  vim.keymap.set("n", "a", api.fs.create, opts "Create")
  vim.keymap.set("n", "bmv", api.marks.bulk.move, opts "Move Bookmarked")
  vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts "Toggle No Buffer")
  -- vim.keymap.set("n", "c", api.fs.copy.node, opts "Copy")
  vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts "Toggle Git Clean")
  vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts "Prev Git")
  vim.keymap.set("n", "]c", api.node.navigate.git.next, opts "Next Git")
  vim.keymap.set("n", "D", api.fs.remove, opts "Delete")
  vim.keymap.set("n", "d", api.fs.cut, opts "Cut")
  -- vim.keymap.set("n", "D", api.fs.trash, opts "Trash")
  vim.keymap.set("n", "E", api.tree.expand_all, opts "Expand All")
  vim.keymap.set("n", "e", api.fs.rename_basename, opts "Rename: Basename")
  vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts "Next Diagnostic")
  vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts "Prev Diagnostic")
  vim.keymap.set("n", "F", api.live_filter.clear, opts "Clean Filter")
  vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts "Help")
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts "Copy Absolute Path")

  -- Le Toggles
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Dotfiles")
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Git Ignore")

  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts "Last Sibling")
  vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts "First Sibling")
  vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle Bookmark")
  vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "O", api.node.open.no_window_picker, opts "Open: No Window Picker")
  vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
  vim.keymap.set("n", "P", api.node.navigate.parent, opts "Parent Directory")
  vim.keymap.set("n", "q", api.tree.close, opts "Close")
  vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
  vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
  vim.keymap.set("n", "s", api.node.run.system, opts "Run System")
  vim.keymap.set("n", "S", api.tree.search_node, opts "Search")
  vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts "Toggle Hidden")
  vim.keymap.set("n", "W", api.tree.collapse_all, opts "Collapse")
  vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts "CD")
  -- END_DEFAULT_ON_ATTACH

  -- Mappings migrated from view.mappings.list
  vim.keymap.set("n", "<leader>y", api.fs.copy.filename, opts "Copy Name")
  -- vim.keymap.set("n", "gy", api.fs.copy.filename, opts "Copy Name")
  vim.keymap.set("n", "y", api.fs.copy.node, opts "Copy")
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts "Copy Relative Path")
  -- vim.keymap.set("n", "Y", api.fs.copy.absolute_path, opts "Copy Absolute Path")
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set("n", "l", edit_or_open, opts "Open: No Window Picker")

  vim.keymap.set("n", "<CR>", api.node.open.no_window_picker, opts "Open: No Window Picker")
  vim.keymap.set("n", "o", api.tree.change_root_to_node, opts "Open: No Window Picker")
  --vim.keymap.set('n', '<BS>',  api.tree.change_root_to_parent,        opts('Close Directory'))
  vim.keymap.set("n", "O", api.tree.change_root_to_parent, opts "Close Directory")

  vim.keymap.set("n", "<leader>c", api.tree.close, opts "Close")
  -- vim.keymap.set("n", "<leader>e", function(node)
  --   vim.cmd ":wincmd p"
  -- end, opts "Go back to previous Window")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.del("n", "<C-k>", opts "Info")

  --vim.cmd('colorscheme vs')
end

M.nvimtree = {

  on_attach = nvimtree_on_attach,
  git = {
    enable = true,
    ignore = false,
    timeout = 200,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  disable_netrw = true,
  hijack_netrw = true,

  open_on_tab = false,
  hijack_cursor = false,

  update_cwd = true,

  update_focused_file = {
    enable = false,
    -- update_cwd = true, -- uncomment this line to make update cwd when focusing a tab
    update_cwd = false,
  },

  filters = {
    dotfiles = false,
    custom = {},
  },

  renderer = {
    root_folder_label = false,
    root_folder_modifier = ":t",
    highlight_git = false,
    icons = {
      git_placement = "before",
      modified_placement = "after",
      webdev_colors = true,
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        default = "󰈚", --"",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "", --"",
          open = "", --"",
          symlink = "", --"",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          -- 󰀨󰗖󰕗󰰜󱖔󰁢󰪥󰮍󱍸󰊰󰮎󰗖
          unstaged = "✗", -- "",
          staged = "✓", --"S",
          unmerged = "", --"",
          renamed = "➜",
          untracked = "★", --"U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    highlight_opened_files = "none",

    indent_markers = {
      enable = true,
    },
  },

  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 38,
    side = "left",
    number = false,
    relativenumber = false,
  },
}

M.hlargs = {
  color = "#909090",
  highlight = {},
  excluded_filetypes = {},
  paint_arg_declarations = true,
  paint_arg_usages = true,
  paint_catch_blocks = {
    declarations = true,
    usages = true,
  },
  extras = {
    named_parameters = true,
  },
  hl_priority = 1000,
  excluded_argnames = {
    declarations = {
      python = { "self", "cls" },
      lua = { "self" },
      cpp = { "this" },
    },
    usages = {
      python = { "self", "cls" },
      lua = { "self" },
      cpp = { "this" },
    },
  },
  performance = {
    parse_delay = 1,
    slow_parse_delay = 10,
    max_iterations = 20,
    max_concurrent_partial_parses = 30,
    debounce = {
      partial_parse = 3,
      partial_insert_mode = 100,
      total_parse = 700,
      slow_parse = 5000,
    },
  },
}

local actions = require "telescope.actions"
M.telescope = {
  defaults = {
    --פֿ
    --prompt_prefix = " ",
    prompt_prefix = " ",
    selection_caret = " ",
    -- path_display = { "smart" },
    -- initial_mode = "normal",
    preview = {
      treesitter = true,
    },
    -- fzf native
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "ignore_case", -- or "ignore_case" or "respect_case" -- the default case_mode is "smart_case"
    },
    mappings = {
      i = {
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-n>"] = actions.cycle_history_next,

        -- ["<C-p>"] = actions.move_selection_previous,
        -- ["<C-n>"] = actions.move_selection_next,

        -- ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        -- ["<CR>"] = actions.select_default,
        ["<CR>"] = function(data)
          local mode = vim.api.nvim_get_mode().mode
          vim.cmd [[Neotree close]]
          actions.select_default(data)
          if mode == "i" then
            vim.cmd [[stopinsert]]
            return
          end
        end,
        ["<C-l>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        --["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        ["<esc>"] = function(data)
          local mode = vim.api.nvim_get_mode().mode
          actions.close(data)
          if mode == "i" then
            vim.cmd [[stopinsert]]
            return
          end
        end,
      },

      n = {
        ["<esc>"] = function(data)
          local mode = vim.api.nvim_get_mode().mode
          actions.close(data)
          if mode == "i" then
            vim.cmd [[stopinsert]]
            return
          end
        end,
        ["<CR>"] = function(data)
          local mode = vim.api.nvim_get_mode().mode
          actions.select_default(data)
          vim.cmd [[Neotree close]]
          if mode == "i" then
            vim.cmd [[stopinsert]]
            return
          end
        end,

        ["l"] = actions.select_default,

        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["n"] = actions.move_selection_next,
        ["p"] = actions.move_selection_previous,

        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
}

M.blankline = {
  indentLine_enabled = 1,
  use_treesitter = true,
  filetype_exclude = {
    "help",
    "terminal",
    "lazy",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "mason",
    "nvdash",
    "nvcheatsheet",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "help",
    "terminal",
    "lazy",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "nvdash",
    "nvcheatsheet",
    "cmp_menu",
    "",
  },

  buftype_exclude = { "terminal", "nofile", "quickfix" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
  context_char = "│",
  max_indent_increase = 1,
  context_patterns = {
    "class",
    "return",
    "function",
    "fn",
    "func",
    "def",
    "method",
    "if",
    "while",
    "jsx_element",
    "for",
    "^object",
    "^table",
    "block",
    -- "arguments",
    -- "if_statement",
    -- "else_clause",
    -- "jsx_element",
    -- "jsx_self_closing_element",
    -- "try_statement",
    -- "catch_clause",
    -- "import_statement",
    -- "operation_type",
  },

  disable_warning_message = true,
}

return M
