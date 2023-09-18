-- I think it might be better to put it right here
-- some of these autocommands are like too slow,
-- I mean changing the whole colorscheme as workaround for
-- NvChad chanding the colorscheme everyime we bufwrite
require "custom.user.autocommands"
vim.cmd ':set clipboard=""'
-- vim.cmd ':set lz' -- Lazy Redraw
-- vim.cmd ":set ttyfast" -- Lazy Redraw
vim.opt.rtp:prepend "righthere, how?"
vim.treesitter.language.register("c", "*.cl")
vim.treesitter.language.register("c", "*.h")
vim.treesitter.language.register("c", ".h")
vim.treesitter.language.register("c", "cl")
-- vim.loader.enable()
vim.cmd [[ let g:c_syntax_for_h = 1 ]]
vim.cmd [[ :set iskeyword-=_ ]]
