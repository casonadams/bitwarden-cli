# bitwarden-cli

Bitwarden CLI fuzzy finder

## setup

- Login

```sh
echo "export BW_SESSION=$(bw unlock --raw)" >> ~/.zprofile
exec zsh
```

### environment (optional)

```sh
BITWARDEN_GET_PASSWORD_KEY
BITWARDEN_GET_TOTP_KEY
```

## usage

| Shortcut | Description |
|----------|-------------|
|`alt + p` | password    |
|`alt + t` | totp        |
