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
# .chezmoidata_profiles.yaml.age
chezmoi decrypt .chezmoidata_profiles.yaml.age > .tmp.yaml
code --wait .tmp.yaml
chezmoi encrypt .tmp.yaml > .chezmoidata_profiles.yaml.age
rm .tmp.yaml

# .chezmoidata.yaml.age
chezmoi decrypt .chezmoidata.yaml.age > .tmp.yaml
code --wait .tmp.yaml
chezmoi encrypt .tmp.yaml > .chezmoidata.yaml.age
rm .tmp.yaml
```
