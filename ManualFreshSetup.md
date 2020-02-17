# Manual Fresh Setup

## After ./fresh-setup.sh finishes

### Applications

#### Visual Studio Code

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

#### iTerm2

- load profile from ./iterm-default-profile.json

OR manually

- set up colors to be solarized dark
- add profile keybindings of

```
⌥ + <- (Option + Left arrow) :: Escape Sequence b
⌥ + -> (Option + Right arrow) :: Escape Sequence f
```

### Services

#### Postgres

- Create JimSegalApi database
- run migrations from https://github.com/jsegal205/jimsegal-db

### System Preferences

#### Display and ScreenSaver

- remove screen saver time

#### Keyboard

- remove Siri from touch bar
- add lock computer to touch bar

#### Notifications

- turn off notifications
