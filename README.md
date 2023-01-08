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
# pull only
chezmoi update --apply=false

chezmoi apply
```

## Editing encrypted files

```bash
.bin/edit-age-encrypted-in-vscode.sh .data/chezmoidata.yaml.age
.bin/edit-age-encrypted-in-vscode.sh .data/chezmoidata_profiles.yaml.age
```
