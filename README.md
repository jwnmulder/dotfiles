# dotfiles

## Setup dotfiles 

```bash
mkdir -p ~/.local/bin
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

chezmoi init https://github.com/jwnmulder/dotfiles.git
chezmoi apply
```

## Set ZSH as default shell

```bash
chsh -s $(which zsh)
```

## Updating dotfiles

```bash
chezmoi update
```
