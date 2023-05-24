# bitwarden-cli

A zsh Bitwarden CLI fuzzy finder using `fzf`

## requirements

- [bw](https://bitwarden.com/download/)
- [fzf](https://github.com/junegunn/fzf)
- [jq](https://stedolan.github.io/jq/)

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

```sh
bw login
```

** Note if having issues remove /tmp/.bw* file **

### environment (optional)

- BW_PASSWORD_KEY (default `^[p`)
- BW_TOTP_KEY     (default `^[t`)

## usage (defaults)

| Shortcut | Description |
|----------|-------------|
|`alt + p` | password    |
|`alt + t` | totp        |

| Commands        | Description                            |
|-----------------|----------------------------------------|
|`bw_pass`        | password                               |
|`bw_pass otp`    | totp                                   |
|`bw_pass -c`     | password to clipboard                  |
|`bw_pass otp -c` | totp to clipboard                      |
|`bw_pass list`   | list passwords names                   |
|`bw_pass name`   | password (name should come from list)  |
