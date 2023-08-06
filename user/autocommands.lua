-- Apperantly " in front of a line in vimscript is a comment?
vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
   " autocmd BufWinEnter * :colorscheme vs
   " autocmd BufWritePost,FileWritePost * :colorscheme vs
   " autocmd BufReadPost * :colorscheme vs
   " autocmd WinNew * :print "hello"
   " autocmd FileType qf set nobuflisted
   " autocmd VimEnter * :colorscheme vs 
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _nvimtree
    autocmd!
    "autocmd WinNew * :colorscheme blue
  augroup end
]]

-- vim.cmd [[ autocmd RecordingEnter * set cmdheight=1 |  nmap Q q | echo "recording start" ]]
vim.cmd [[ autocmd RecordingEnter * set cmdheight=1 |  nmap q <Nop> | echo "recording start" ]]
-- vim.cmd [[ autocmd RecordingLeave * set cmdheight=0 |  nmap Q qq | nnoremap ; @q | set cmdheight=1 | echo "recording stop" ]]

-- vim.cmd([[ autocmd FileType *.c nnoremap <buffer> <F5> :wa<CR>:term gcc % -o %:r && ./%:r<CR> ]])
-- vim.cmd [[autocmd filetype cpp nnoremap <F5> :!g++ % -ggdb -o %:r && ./%:r <CR>]]
-- vim.cmd [[autocmd FileType c nnoremap <F5> :!gcc % -g -o %:r && ./%:r <CR>]]
vim.cmd [[autocmd FileType c nnoremap <F5> :!make run <CR>]]

vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)
vim.cmd [[autocmd filetype python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>]]
-- vim.cmd [[autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>]]
vim.cmd [[autocmd filetype cpp nnoremap <F5> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>]]
