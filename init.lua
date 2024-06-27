-- I think it might be better to put it right here
-- some of these autocommands are like too slow,
-- I mean changing the whole colorscheme as workaround for
-- NvChad chanding the colorscheme everyime we bufwrite
require "custom.user.autocommands"
vim.cmd ':set clipboard=""'
vim.cmd ':set laststatus=0'
vim.cmd ':set display-=msgsep'
vim.cmd ':set nomore'

  
-- vim.cmd ':set lz' -- Lazy Redraw
-- vim.cmd ":set ttyfast" -- Lazy Redraw
vim.treesitter.language.register("c", "*.cl")
vim.treesitter.language.register("c", "*.h")
vim.treesitter.language.register("c", ".h")
vim.treesitter.language.register("c", "cl")

vim.cmd [[ :set iskeyword-=- ]]
vim.cmd [[ :set updatetime=10 ]]

vim.loader.enable()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true
    }
)
