# bitwarden-cli

A zsh Bitwarden CLI fuzzy finder using `skim`

## requirements

- [bw](https://bitwarden.com/download/)
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

### login

This should only need to be run once. And there might
be better ways to `login` and `logout` that are more
secure. This is just an example of what is needed
to get this plugin to work

```sh
echo "export BW_SESSION=$(bw unlock --raw)" >> ~/.zprofile
exec zsh
```

### linux alias

```~/.zshrc
alias pbcopy='xsel -i --clipboard'
alias pbpaste='xsel -o --clipboard'
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
