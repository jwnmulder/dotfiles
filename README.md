# dotfiles

[![GitHub Actions pre-commit status](https://github.com/jwnmulder/dotfiles/workflows/pre-commit/badge.svg?branch=main)](https://github.com/jwnmulder/dotfiles/actions/workflows/pre-commit.yml?query=branch%3Amain)
[![GitHub Actions ci status](https://github.com/jwnmulder/dotfiles/workflows/CI/badge.svg?branch=main)](https://github.com/jwnmulder/dotfiles/actions/workflows/ci.yml?query=branch%3Amain)

## Setup dotfiles

On Linux

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)"

~/.local/bin/chezmoi init --apply jwnmulder
```

On Windows

```powershell
winget install twpayne.chezmoi

chezmoi init --apply jwnmulder
```

## Set ZSH as default shell

```bash
chsh -s $(which zsh)
```

## Updating dotfiles

```bash
chezmoi update
```

## Editing encrypted files

```bash
bin/edit-age-encrypted-in-vscode.sh home/.data/chezmoidata.yaml.age
```
