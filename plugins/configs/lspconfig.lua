local default_on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"
-- if you just want default config for the servers then put them in a table
local servers = { 
    "html",
    "cssls",
    "pylsp",
    --"tsserver", 
    "clangd",
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
  lsp_keymaps(bufnr)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
  return
end

