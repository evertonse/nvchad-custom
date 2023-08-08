-- I think it might be better to put it right here
-- some of these autocommands are like too slow,
-- I mean changing the whole colorscheme as workaround for
-- NvChad chanding the colorscheme everyime we bufwrite
require "custom.user.autocommands"
vim.cmd ':set clipboard=""'
vim.opt.rtp:prepend "righthere, how?"
vim.treesitter.language.register("c", "*.cl")
vim.treesitter.language.register("c", "cl")
-- vim.loader.enable()
