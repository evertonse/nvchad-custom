# Setup
## Install
- `git clone https://github.com/evertonse/nvchad-custom.git && cd nvchad-custom && python3 setup.py install`
## Uninstall 
- `python3 setup.py install`

# Tips
- ideas for overrides of plugins ``https://astronvim.com/3.2.0/Configuration/plugin_defaults`` **astrovim**

### Profiling
Try run nvim with nvim -u NONE. Is it still slow?

Try profiling when inside that file.
``:profile start profile.log``
``:profile func *``
``:profile file *.``
Now start doing what is slow
``:profile pause.``
Quit vim and open profile.log.
At the end you should see sum of functions exec times and count of usage. Should point you.

bot summon :help profile

:) Hope it helps

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1; nvim
ln -s ~/dotfiles/nvim/custom ~/.config/nvim/lua/custom
touch -a -m ~/dotfiles/nvim/custom/override.lua
