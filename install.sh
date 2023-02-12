ln -s src/nanorc ~/.nanorc
ln -s src/polybar ~/.config/polybar
ln -s src/alacritty ~/.config/alacritty
ln -s src/vimrc ~/.vimrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
mkdir ~/.local/share/fonts
cp fonts/* ~/.local/share/fonts
mkdir -p ~/.vim/bundle/
mkdir ~/.vim/colors
rm ~/.zshrc
rm ~/.p10k.zsh
ln -s src/zshrc ~/.zshrc
ln -s src/p10k.zsh ~/.p10k.zsh
git clone https://github.com/tomasr/molokai.git ~/.vim/colors/molokai
mv ~/.vim/colors/molokai/colors/molokai.vim ~/.vim/colors
rm -r ~/.vim/colors/molokai/
git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/tiagofumo/vim-nerdtree-syntax-highlight.git ~/.vim/bundle/nerdtree-git-plugin
git clone https://github.com/rust-lang/rust.vim.git ~/.vim/bundle/rust.vim
git clone https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
git clone https://github.com/ryanoasis/vim-devicons.git ~/.vim/bundle/vim-devicons
git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouComleteMe
git submodule update --init --recursive
python3 install.py --clangd-completer --ts-completer --rust-completer

