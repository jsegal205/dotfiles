# After ./fresh-setup.sh finishes

Here are the following steps to remember to do that I have yet to figure out how to automate.

## Applications

### Visual Studio Code

- open chrome
- log into lastpass
- log into google
- log into github
- set up vs code sync extension

///

- run the following command

```bash
cp settings.json $HOME/Library/Application\ Support/Code/User/settings.json
```

### iTerm2

- load profile from ./iterm-default-profile.json

OR manually

- set up colors to be solarized dark
- add profile keybindings of

```
⌥ + <- (Option + Left arrow) :: Escape Sequence b
⌥ + -> (Option + Right arrow) :: Escape Sequence f
```

## Projects

- TODO: make this a script

```
    ssh-keygen -t rsa -b 4096 -C "jsegal205@gmail.com"
    == create password ==
    eval "$(ssh-agent -s)"

    echo  the following into ~/.ssh/config
    Host *
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_rsa

    ssh-add -K ~/.ssh/id_rsa
    pbcopy < ~/.ssh/id_rsa.pub
    chrome https://github.com/settings/keys

    mkdir projects && cd projects
    git clone git@github.com:jsegal205/scripts.git
    git clone git@github.com:jsegal205/jimsegal.com.git
    git clone git@github.com:jsegal205/jimsegal-api.git
    git clone git@github.com:jsegal205/jimsegal-db.git
    git clone git@github.com:jsegal205/dotfiles.git
```

## Services

### Postgres

- Create JimSegalApi database
- run migrations from https://github.com/jsegal205/jimsegal-db
- add .env to jimsegal-api

## System Preferences

### Display and ScreenSaver

- remove screen saver time

### Keyboard

- remove Siri from touch bar
- add lock computer to touch bar

### Notifications

- turn off notifications
