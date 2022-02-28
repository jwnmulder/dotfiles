# dotfiles

## Setup dotfiles 

```bash
mkdir -p ~/.local/bin
curl -fLo ~/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x ~/.local/bin/yadm
~/.local/bin/yadm clone https://github.com/jwnmulder/dotfiles.git --bootstrap
```

## Set ZSH as default shell

```bash
chsh -s $(which zsh)
```

## Updating dotfiles

```bash
yadm pull -r
yadm bootstrap
```
