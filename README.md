# dots
YADM-managed dotfiles:
https://thelocehiliosan.github.io/yadm/

Bootstrap:
```
/bin/bash -c "$(curl -fL https://raw.githubusercontent.com/vmizener/dots/master/.config/yadm/bootstrap)"
```

Note that updating neovim will produce spurious errors; just ignore them.
(TODO: keep an eye on a vim-packer update regarding this)

Configure p10k prompt by running `p10k configure`.
Answer "NO" to the request to append to your zshrc at the end (it's already setup to use it)
