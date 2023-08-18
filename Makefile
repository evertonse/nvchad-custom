push: 
	 git add . && git commit -m "$$(date)" && git push

pull:
	git pull

clean:
	rm -rf ~/.local/share/nvim rm -rf ~/.cache/nvim

query:
	cp -rf ./queries/ ../../

unistall: clean
	rm -rf ~/.config/nvim 

install: 
	git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1; nvim; ln -s ~/dotfiles/nvim/custom ~/.config/nvim/lua/custom;

.PHONY: install uninstall query clean, pull, push
