# Dotfiles

### Managed with [chezmoi](https://github.com/twpayne/chezmoi)

## Init repo
```
chezmoi init https://github.com/conor-sometimes/dotfiles.git
```

## Pull the latest changes from your repo and apply them
```
chezmoi update
```

## Deploy configs
```
chezmoi -v apply
```

# Editing files
```
chezmoi cd
* edit files *
```

## Apply changes
```
chezmoi -v apply
```

# Push changes
```
chezmoi cd
git add -A
git commit -s -m "Witty and hilarious commit message"
git push -u origin master
```
