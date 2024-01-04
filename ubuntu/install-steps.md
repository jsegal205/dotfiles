# Ubuntu related steps for fresh install

## For ASDF

`apt get build-essential libssl-dev unzip`

## For Erlang

`apt get libncurses-dev`

## For Oh-my-zsh

Instructions from https://github.com/ohmyzsh/ohmyzsh#basic-installation

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### For Elixir plugin warning

Instructions from https://github.com/gusaiani/elixir-oh-my-zsh#oh-my-zsh

```bash
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/gusaiani/elixir-oh-my-zsh.git elixir
```

### Syntax Highlighting warning

```bash
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting
```

## For Python

`apt get pip liblzma-dev`

## For ZSH theme

### Native

`apt install fonts-powerline`

### WSL

- go to https://github.com/powerline/fonts/blob/master/RobotoMono/Roboto%20Mono%20for%20Powerline.ttf
- download
- install
- restart terminal
