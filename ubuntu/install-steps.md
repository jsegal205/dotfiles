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

Follow the instructions on [github docs](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key?platform=linux)

but if that link doesn't exist (for whatever reason) run:

```sh
gpg --full-generate-key
```

Follow the prompts to setup key. Save the passphrase for caching later.

```sh
gpg --list-secret-keys --keyid-format=long
```

Results will look like this:

```sh
$ gpg --list-secret-keys --keyid-format=long
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot <hubot@example.com>
ssb   4096R/4BB6D45482678BE3 2016-03-10
```

Copy the gpg key id. This is the value after the forward slash in the `sec` row. In the above, it will be `3AA5C34371567BD2`.

Then run:

```sh
gpg --armor --export <gpg key id>
```

Add gpg key to github.

Finally, update your local git config with the following statements:

```sh
git config --global commit.gpgsign true
git config --global user.signingkey <gpg key id>
```

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

- go to <https://github.com/powerline/fonts/blob/master/RobotoMono/Roboto%20Mono%20for%20Powerline.ttf>
- download
- install
- restart terminal
