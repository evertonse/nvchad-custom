local overrides = require "custom.plugins.overrides"

local M = {}

M.plugins = {
  {
    -- NOTE: Yes, you can install new plugins here!
    "mfussenegger/nvim-dap",
    lazy = true,
    enabled = true,
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      "rcarriga/nvim-dap-ui",

      -- Installs the debug adapters for you
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",

      -- Add your own debuggers here
      "leoluz/nvim-dap-go",
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function(_, opts)
          local fallback_path = "/home/excyber/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
          --require("dap-python").setup(fallback_path) -- uncomment this to allways look for mason fall_back path
          require("dap-python").resolve_python = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            else
              return fallback_path
            end
          end
          require("core.utils").load_mappings "dap_python"
        end,
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      require("core.utils").load_mappings "dap"

      require("mason-nvim-dap").setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "vscode-java-decompiler",
          "cpptools",
          "codelldb",
          "debugpy",
          "delve",
        },
      }

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F11>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end, { desc = "Debug: Set Breakpoint" })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      }

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      -- Install golang specific config
      require("dap-go").setup()
      require("dap-python").setup()
    end,
  },

  {
    "nvim-neorg/neorg",
    lazy = true,
    enabled = false,
    build = ":Neorg sync-parsers",
    -- lazy-load on filetype
    ft = "norg",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },

  {
    "moll/vim-bbye",
    enabled = true,
    lazy = false,
  }, -- Avoid messing with windwos layouts when closing buffers

  {
    "ThePrimeagen/harpoon",
    lazy = true,
    enabled = true,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("telescope").load_extension "harpoon"
      require("harpoon").setup {
        global_settings = {
          -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
          save_on_toggle = true,

          -- saves the harpoon file upon every change. disabling is unrecommended.
          save_on_change = true,

          -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
          enter_on_sendcmd = false,

          -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
          tmux_autoclose_windows = false,

          -- filetypes that you want to prevent from adding to the harpoon list menu.
          excluded_filetypes = { "harpoon" },

          -- set marks specific to each git branch inside git repository
          mark_branch = false,

          -- enable tabline with harpoon marks
          tabline = true,
          tabline_prefix = "   ",
          tabline_suffix = "   ",
        },
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        },
      }
    end,
  },

  {
    "ekickx/clipboard-image.nvim",
    lazy = true,
    enalbed = false,
    config = function()
      require("clipboard-image").setup {
        -- Default configuration for all filetype
        default = {
          img_dir = "images",
          img_name = function()
            return os.date "%Y-%m-%d-%H-%M-%S"
          end, -- Example result: "2021-04-13-10-04-18"
          affix = "<\n  %s\n>", -- Multi lines affix
        },
        -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
        -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
        -- Missing options from `markdown` field will be replaced by options from `default` field
        markdown = {
          img_dir = { "src", "assets", "img" }, -- Use table for nested dir (New feature form PR #20)
          img_dir_txt = "/assets/img",
          -- use this -> require 'clipboard-image.paste'.paste_img()
          img_handler = function(img) -- New feature from PR #22
            local script = string.format('./image_compressor.sh "%s"', img.patc)
            os.execute(script)
          end,
        },
      }
    end,
  }, -- Avoid messing with windwos layouts when closing buffers

  {
    "VonHeikemen/lsp-zero.nvim",
    lazy = false, --@important, might not be a agood ideia to make it so
    enabled = false,
    branch = "v2.x",
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect
      local default = true
      if default then
        local lsp = require("lsp-zero").preset {}

        lsp.on_attach(function(client, bufnr)
          -- see :help lsp-zero-keybindings
          -- to learn the available actions
          lsp.default_keymaps { buffer = bufnr }
        end)

        -- (Optional) Configure lua language server for neovim
        require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

        lsp.setup()
      else
        require "custom.plugins.configs.lsp_zero"
      end
    end,
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-emoji" },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
          local cmp = require "cmp"
          opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
        end,
      },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip", lazy = false },
      { "rafamadriz/friendly-snippets" },
    },
  },
  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    enabled = true,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    enabled = true,
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = false,
        enabled = true,
        config = function()
          require "custom.plugins.configs.null-ls"
        end,
      },

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", event = "LspAttach", enabled = true, tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      { "folke/neodev.nvim" },
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        lazy = true,
        enabled = true,
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            lazy = false,
            config = function()
              local snip = require "luasnip"
              -- check filetype with vim.bo.filetype
              -- snip.filetype_extend("html", {"django-html"})
              snip.filetype_extend("htmldjango", { "djangohtml" })
              snip.filetype_extend("htmldjango", { "html" })
              snip.filetype_extend("html", { "django-html" })
            end,
          },
        },
      },

      {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        enabled = true,
        config = overrides.mason.config,
      },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
    enabled = true,
    opts = overrides.mason,
    build = function()
      pcall(vim.cmd, "MasonUpdate")
    end,
  },

  {
    "onsails/lspkind.nvim",
    lazy = true,
    enabled = false,
  }, -- better lsp cmp icons

  {
    "RRethy/vim-illuminate",
    lazy = true,
    enabled = false,
  },

  {
    "folke/trouble.nvim",
    lazy = true,
    enabled = false,
  }, -- LPS Diagnostic with colors and shit

  {
    "folke/lsp-colors.nvim",
    lazy = true,
    enabled = false,
  }, -- LSP colors that might be missings
  --{ 'jackguo380/vim-lsp-cxx-highlight',     }, -- LSP based cpp highlighting
  -->> Telescope
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    enabled = true,
    opts = overrides.telescope,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension "fzf"
      end,
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    lazy = false,
    enabled = false,
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  --Optionally  mine https://github.com/evertonse/nvim-treesitter, removed bug with windows that wasnt adressed nor have I seen any issues opened
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    enabled = false,
  }, -- Nice Vim commenting --  context_commentstring { enabled = true },
  -- {'David-Kunz/markid',}, -- Every identifier has the same color
  {
    "nvim-treesitter/playground",
    lazy = false,
    enabled = false,
    config = function()
      require("nvim-treesitter.configs").setup {
        playground = {
          enabled = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
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
        query_linter = {
          enabled = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
      }
    end,
  },

  -- Argument Coloring
  -- {'octol/vim-cpp-enhanced-highlight',                }, -- still haven't d but adds cpp keywords for highlight tweak even further

  {
    "m-demare/hlargs.nvim",
    lazy = false,
    enabled = true,
    opts = overrides.hlargs,
    config = function()
      require "custom.plugins.configs.hlargs"
      require("hlargs").enable()
    end,
  },

  -->> Colorschemes
  --{'marko-cerovac/material.nvim'},
  --{ "folke/tokyonight.nvim",  },
  --[[ 
        Using my fork of Mofiqul vscode nvim theme, 
        but my theme is Focusing on Visual Studio Theme, rather tha vs code
    --]]
  -- {
  --   "evertonse/vs.nvim",
  --   branch = "dev",
  --   lazy = true,
  --   config = function()
  --     local status_ok, _ = pcall(vim.cmd, "colorscheme vs")
  --     if not status_ok then
  --       return
  --     end
  --     --vim.api.nvim_set_hl(0,'Normal',{bg = "none"})
  --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  --   end,
  -- },

  {
    "NvChad/nvterm",
    lazy = false,
    enabled = true,
    config = function()
      -- require("nvterm").setup()
        local ok = require "custom.plugins.configs.nvterm"
        assert(ok, "nvterm did not config correctly")
    end,
  },
  -->> Utils
  {
    "dstein64/vim-startuptime",
    lazy = false,
    enabled = false,
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "kylechui/nvim-surround",
    lazy = true,
    enabled = false,
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  -- {
  --   "tpope/vim-surround",
  --   lazy = false,
  --   enabled = true,
  --   dependencies = {
  --     { "tpope/vim-repeat" },
  --   },
  -- },

  { --https://github.com/andymass/vim-matchup
    "andymass/vim-matchup",
    lazy = false,
    enabled = false,
    config = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    enabled = true,
    -- commit = "59f06b3b33fb3013cfbdf378297c756e44a6919e",
    -- branch = "0.5-compat",
    branch = "master",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = overrides.treesitter,
    build = ":TSUpdate",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    enabled = true,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require "custom.plugins.configs.neotree"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    enabled = false,
    opts = function()
      --vim.cmd "colorscheme vs"
      return overrides.nvimtree
    end,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    lazy = false,
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = {
          "jk", --[[ "jj", ]]
          "kj",
        }, -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = true, -- clear line after escaping if there is only whitespace
        keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
      }
    end,
  },
  {
    "Vonr/align.nvim",
    branch = "v2",
    lazy = false,
    init = overrides.align.init,
  },

  {
    -- https://github.com/folke/todo-comments.nvim
    "folke/todo-comments.nvim",
    lazy = false,
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    -- opts = overrides.todo.opts,
  },
  {
    "edluffy/hologram.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("hologram").setup {
        auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
      }
    end,
  },
  {
    "princejoogie/chafa.nvim", -- A neovim plugin for viewing images.
    lazy = false,
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim",
    },
    config = function()
      require("chafa").setup {
        render = {
          min_padding = 5,
          show_label = true,
        },
        events = {
          update_on_nvim_resize = true,
        },
      }
    end,
  },

  -- lazy.nvim
  {
    "chrisgrieser/nvim-recorder",
    lazy = false,
    enabled = false,
    opts = {},
    config = function()
      -- default values
      require("recorder").setup {
        -- Named registers where macros are saved. The first register is the default
        -- register/macro-slot used after startup.
        slots = { "a", "b" },

        -- default keymaps, see README for description what the commands do
        mapping = {
          startStopRecording = "Q",
          playMacro = "q",
          switchSlot = "<C-q>",
          editMacro = "cq",
          yankMacro = "yq", -- also decodes it for turning macros to mappings
          addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
        },

        -- clears all macros-slots on startup
        clear = false,

        -- log level used for any notification, mostly relevant for nvim-notify
        -- (note that by default, nvim-notify does not show the levels trace and debug.)
        logLevel = vim.log.levels.INFO,

        -- if enabled, only essential or critical notifications are sent.
        -- If you do not use a plugin like nvim-notify, set this to `true`
        -- to remove otherwise annoying notifications.
        lessNotifications = true,

        -- experimental, see README
        dapSharedKeymaps = false,
      }
      -- indicates whether you are currently recording. Useful if you are using
      -- `cmdheight=0`, where recording-status is not visible.
      require("recorder").recordingStatus()

      -- displays non-empty macro-slots (registers) and indicates the selected ones.
      -- Only displayed when *not* recording. Slots with breakpoints get an extra `#`.
      -- 💡 use with the config `clear = true` to see recordings you made this session.
      require("recorder").displaySlots()
    end,
  },
  {
    "VonHeikemen/fine-cmdline.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    lazy = true,
    enabled = false,
    config = function()
      vim.api.nvim_set_keymap("n", "<CR>", "<cmd>FineCmdline<CR>", { noremap = true })
      -- vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = true,
    enabled = false,
    opts = {},
    config = function()
      require "custom.plugins.configs.oil"
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    enabled = false,
    opts = {},
    config = function() end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    -- version = "2.20.7",
    lazy = true,
    enabled = true,
    init = function()
      require("core.utils").lazy_load "indent-blankline.nvim"
    end,
    opts = function()
      return overrides.blankline
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "blankline"
      dofile(vim.g.base46_cache .. "blankline")
      require("indent_blankline").setup(opts)
      vim.cmd [[
        function! s:IndentBlanklineLinecount()
            if nvim_buf_line_count(0) < 2000
                IndentBlanklineRefresh
            endif
        endfunction

        augroup IndentBlanklineAutogroup
            autocmd!
            autocmd OptionSet shiftwidth,tabstop IndentBlanklineRefresh
            autocmd FileChangedShellPost,Syntax * IndentBlanklineRefresh
            autocmd TextChanged,TextChangedI * call s:IndentBlanklineLinecount()
        augroup END
      ]]
    end,
  },
}
--
return M.plugins
