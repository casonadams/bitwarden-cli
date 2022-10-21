# bitwarden-cli

A zsh Bitwarden CLI fuzzy finder using `skim`

## requirements

- [bw](https://bitwarden.com/download/) might need to `chmod +x bw` and move add to $PATH
- [jq](https://stedolan.github.io/jq/)
- [sk](https://github.com/lotabout/skim#package-managers)

*Note* you can use `fzf` just create an `alias sk=fzf`

## setup

### zinit

```~/.zshrc
zinit wait lucid for \
  casonadams/bitwarden-cli \
  ;
```

### oh my zsh

```sh
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom/" git clone --depth=1 "https://github.com/casonadams/bitwarden-cli.git" "${ZSH_CUSTOM}/plugins/bitwarden-cli"
```

```~/.zshrc
plugins+=(
  bitwarden-cli
)
```

- Login only needed once

```sh
echo "export BW_SESSION=$(bw unlock --raw)" >> ~/.zprofile
exec zsh
```

### environment (optional)

- BW_PASSWORD_KEY (default `^[p`)
- BW_TOTP_KEY     (default `^[t`)
- BW_AUTO_COPY    (default `true`)

## usage (defaults)

| Shortcut | Description |
|----------|-------------|
|`alt + p` | password    |
|`alt + t` | totp        |
