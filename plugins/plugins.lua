local overrides = require "custom.plugins.overrides"

local M = {}

M.plugins = {
  {
    -- NOTE: Yes, you can install new plugins here!
    "mfussenegger/nvim-dap",
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      "rcarriga/nvim-dap-ui",

      -- Installs the debug adapters for you
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",

      -- Add your own debuggers here
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

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
          "delve",
        },
      }

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
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
    end,
  },

  { "moll/vim-bbye", lazy = false }, -- Avoid messing with windwos layouts when closing buffers

  {
    "ThePrimeagen/harpoon",
    lazy = true,
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
    "lewis6991/impatient.nvim",
    lazy = false,
    enable = false,
    config = function()
      require "impatient"
    end,
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    lazy = false, --@important, might not be a agood ideia to make it so
    enabled = false,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      --require('lsp-zero.settings').preset({})
      require "custom.plugins.configs.lsp_zero"
    end,
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.plugins.configs.null-ls"
        end,
      },

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", enable = false, tag = "legacy", opts = {} },

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
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      { "hrsh7th/cmp-nvim-lsp" },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls", "rust_analyzer", "opencl_ls" },
            automatic_installation = true,
          }
        end,
      },
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },

  { "onsails/lspkind.nvim" }, -- better lsp cmp icons
  { "RRethy/vim-illuminate", enable = true },
  { "folke/trouble.nvim" }, -- LPS Diagnostic with colors and shit
  { "folke/lsp-colors.nvim" }, -- LSP colors that might be missings
  --{ 'jackguo380/vim-lsp-cxx-highlight',     }, -- LSP based cpp highlighting
  -->> Telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end,
  },

  --Optionally  mine https://github.com/evertonse/nvim-treesitter, removed bug with windows that wasnt adressed nor have I seen any issues opened
  { "JoosepAlviste/nvim-ts-context-commentstring" }, -- Nice Vim commenting --  context_commentstring { enable = true },
  -- {'David-Kunz/markid',                                                                       }, -- Every identifier has the same color
  {
    "nvim-treesitter/playground",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup {
        playground = {
          enable = true,
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
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
      }
    end,
    enable = true,
  },

  -- Argument Coloring
  -- {'octol/vim-cpp-enhanced-highlight',                }, -- still haven't d but adds cpp keywords for highlight tweak even further

  {
    "m-demare/hlargs.nvim",
    lazy = false,
    opts = overrides.hlargs,
    config = function()
      require "custom.plugins.configs.hlargs"
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

  -->> Utils
  { "dstein64/vim-startuptime" },

  {
    "tpope/vim-surround",
    lazy = false,
    dependencies = {
      { "tpope/vim-repeat" },
    },
  },

  { --https://github.com/andymass/vim-matchup
    "andymass/vim-matchup",
    lazy = false,
    config = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    -- config = function ()
    --   require "plugins.configs.treesitter"
    --   -- require "custom.plugins.configs.treesitter"
    -- end,
    opts = overrides.treesitter,
    build = ":TSUpdate",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      --vim.cmd "colorscheme vs"
      return overrides.nvimtree
    end,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "edluffy/hologram.nvim",
    config = function()
      require("hologram").setup {
        auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
      }
    end,
  },
  {
    "princejoogie/chafa.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim",
    },
    lazy = false,
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
    opts = {},
    lazy = false,
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
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.10",

    -- config = function()
    --
    -- end,
    --opts = require 'plugins.configs.others'.blankline
    --opts = {}
    opts = overrides.blankline,
  },
}

return M.plugins
