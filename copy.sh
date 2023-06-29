#!/usr/bin/bash 
cvim.lsp.buf_attach_client()p -rT . ~/code/config-files/nvchad/custom/
cd ~/code/config-files/
git add . && git commit -m "nvchad"
git push

