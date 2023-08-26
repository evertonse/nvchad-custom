local default_on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
capabilities.offsetEncoding = { "utf-16" }

-- please take a look at this https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#completionItemKind
local cmp = require "cmp"
local CompletionItemKind = {
  --[[Text ]]
  30,
  --[[Method = ]]
  2,
  --[[Function = ]]
  1,
  --[[Constructor = ]]
  4,
  --[[Field = ]]
  4,
  --[[Variable = ]]
  3,
  --[[Class = ]]
  7,
  --[[Interface = ]]
  8,
  --[[Module = ]]
  9,
  --[[Property = ]]
  10,
  --[[Unit = ]]
  11,
  --[[Value = ]]
  12,
  --[[Enum = ]]
  13,
  --[[Keyword = ]]
  14,
  --[[Snippet = ]]
  3,
  --[[Color = ]]
  16,
  --[[File = ]]
  17,
  --[[Reference = ]]
  18,
  --[[Folder = ]]
  19,
  --[[EnumMember = ]]
  20,
  --[[Constant = ]]
  21,
  --[[Struct = ]]
  22,
  --[[Event = ]]
  23,
  --[[Operator = ]]
  24,
  --[[TypeParameter = ]]
  25,
}

cmp.setup {
  sorting = {
    priority_weight = 1.2,
    comparators = {
      -- cmp.score_offset, -- not good at all
      cmp.config.compare.exact,
      function(e1, e2)
        local k1 = CompletionItemKind[e1:get_kind()]
        local k2 = CompletionItemKind[e2:get_kind()]
        if k1 < k2 then
          return true
        end
        return false
      end,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.recently_used,
      cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      cmp.config.compare.order,
      -- compare.scopes, -- what?
      -- compare.sort_text,
      -- compare.exact,
      -- compare.length, -- useless
      cmp.config.compare.offset,
      -- cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "bashls",
  -- "pylsp",
  "pyright",
  --"tsserver",
  "clangd",
  "opencl_ls",
}

local lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
  keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
  --keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>lspinfo<cr>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>lspinstallinfo<cr>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  --keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua require('nvchad_ui.renamer').open()<cr>", opts)

  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
end

local on_attach = function(client, bufnr)
  default_on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = true
  client.resolved_capabilities.document_range_formatting = true
  lsp_keymaps(bufnr)
end

for _, lsp in ipairs(servers) do
  if lsp == "pyright" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      autostart = true, -- This is the important new option
      capabilities = capabilities,
      filetypes = { "python" },
      settings = {
        python = {
          formatting = {
            provider = "black",
          },
        },
      },
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      autostart = true, -- This is the important new option
      capabilities = capabilities,
    }
  end
end

local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
  return
end

-- Start or restart Neovim.
-- The Black formatter should now be enabled for Python files. Y
-- ou can trigger formatting by using the appropriate Neovim command
-- (such as :lua vim.lsp.buf.formatting()).
require("luasnip").filetype_extend("html", { "django-html" })
require("luasnip").filetype_extend("htmldjango", { "django-html" })
require("luasnip").filetype_extend("htmldjango", { "html" })
