# After ./fresh-setup.sh finishes

Here are the following steps to remember to do that I have yet to figure out how to automate.

## Applications

## Projects

- TODO: make this a script

```bash
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

## System Preferences

### Display and ScreenSaver

- remove screen saver time

### Notifications

- turn off application notifications
