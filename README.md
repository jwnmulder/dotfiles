# dotfiles

## Setup dotfiles 

```bash
curl -fLo ~/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x ~/.local/bin/yadm
~/.local/bin/yadm clone https://github.com/jwnmulder/dotfiles.git
~/.local/bin/yadm bootstrap
```

## Updating dotfiles

```bash
yadm pull -r
yadm bootstrap
```
