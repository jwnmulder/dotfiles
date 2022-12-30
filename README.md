# dotfiles

## Setup dotfiles 

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin

chezmoi init jwnmulder
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
