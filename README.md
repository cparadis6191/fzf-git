# fzf Git

## Installation Instructions

Run the following command to create symbolic links in the local bin directory
to the tools contained in this repository:

```
$ stow --target="$HOME/.local/bin" \
> bin
```

Run the following command to add fish key bindings to the tools contained in
this repository:

```
$ echo 'source ~/.local/etc/fzf-git/fzf-git.fish' >> "$HOME/.local/etc/.config/fish/config.fish"
```
