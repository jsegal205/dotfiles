# Ubuntu related steps for fresh install

## For ASDF

`apt get build-essential libssl-dev unzip`

## For Erlang

`apt get libncurses-dev`

## For Oh-my-zsh

Instructions from [ohmyzsh github](https://github.com/ohmyzsh/ohmyzsh#basic-installation)

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### For Elixir plugin warning

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

## GPG commit signing

Run `../gpg/main.sh` from this directory's parent (repo root). It generates
a personal key and an "agents" key (skipping either that already exists),
points `~/.gitconfig`'s `signingkey` at the personal one, and prints both
public keys at the end - add them to GitHub > Settings > SSH and GPG keys.

### Cache gpg passphrase

install agent:

```sh
sudo apt install gnupg2 gnupg-agent
```

copy local gpg-agent config:

```sh
cp ./gpg-agent.conf ~/.gnupg/gpg-agent.conf
```

Current TTL values are set for 400 days.

## For ZSH theme

copy the .zshrc file into the root .zshrc file

```bash
cp ./.zshrc ~/.zshrc
```

### Native

`apt install fonts-powerline`

### WSL

- go to [powerline github](https://github.com/powerline/fonts/blob/master/RobotoMono/Roboto%20Mono%20for%20Powerline.ttf)
- download
- install
- restart terminal
