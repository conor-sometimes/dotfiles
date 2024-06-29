# Dotfiles

### Managed with [chezmoi](https://github.com/twpayne/chezmoi)

## Init repo
```
sudo pacman -S chezmoi keepassxc

# Be aware, this will overwrite your own configs
# Run with `-n` to do a dry run first
chezmoi -v init https://github.com/conor-sometimes/dotfiles.git
```

## Pull the latest changes from your repo and apply them
```
chezmoi update && chezmoi -v apply
```

## Editing files
```
chezmoi cd
# Edit files here, don't edit configs at their destination as they wont be saved
# When finished
chezmoi -v apply
```

## Push changes
```
chezmoi cd
git add -A
git commit -s -m "Witty and hilarious commit message"
git push -u origin main
```
