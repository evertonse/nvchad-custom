local overrides = require "custom.plugins.overrides"

local M = {}

M.plugins = {
  { "moll/vim-bbye", lazy = false }, -- Avoid messing with windwos layouts when closing buffers
  {
    "ekickx/clipboard-image.nvim",
    lazy = false,
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
          img_handler = function(imh) -- New feature from PR #22
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
    config = function()
      require "impatient"
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    lazy = flase, --@important, might not be a agood ideia to make it so
    enabled = true,
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
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
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
  { "RRethy/vim-illuminate" },
  { "folke/trouble.nvim" }, -- LPS Diagnostic with colors and shit
  { "folke/lsp-colors.nvim" }, -- LSP colors that might be missings
  -- { 'jackguo380/vim-lsp-cxx-highlight',     }, -- LSP based cpp highlighting
  -->> Telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    cond = vim.fn.executable "make" == 1,
  },

  --Optionally  mine https://github.com/evertonse/nvim-treesitter, removed bug with windows that wasnt adressed nor have I seen any issues opened
  { "JoosepAlviste/nvim-ts-context-commentstring" }, -- Nice Vim commenting --  context_commentstring { enable = true },
  -- {'David-Kunz/markid',                                                                       }, -- Every identifier has the same color
  {
    "nvim-treesitter/playground",
    lazy = false,
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
  {
    "evertonse/vs.nvim",
    branch = "dev",
    lazy = true,
    config = function()
      local status_ok, _ = pcall(vim.cmd, "colorscheme vs")
      if not status_ok then
        return
      end
      --vim.api.nvim_set_hl(0,'Normal',{bg = "none"})
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },

  -->> Utils
  { "dstein64/vim-startuptime" },
  { "tpope/vim-surround" },

  { --https://github.com/andymass/vim-matchup
    "andymass/vim-matchup",
    config = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
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

