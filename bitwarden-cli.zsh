GET_PASSWORD_KEY="${BITWARDEN_GET_PASSWORD_KEY:-^[p}"
GET_TOTP_KEY="${BITWARDEN_GET_TOTP_KEY:-^[t}"

function .print() {
  local result=$1
  read -s "reply?$result" < /dev/tty
  zle reset-prompt
  return 0
}

function .copy() {
  local result=$1
  echo $result
  zle accept-line
  return 0
}

function .bw_get_id() {
  jq --unbuffered -r '.[] | .name + ";" + .login.username + ";" + .id' <(bw list items) \
    | sk --no-clear-if-empty --prompt="bitwarden-cli> " \
    | cut -f3 -d ";"
}

function bw_get_password() {
  .print $(bw get password "$(.bw_get_id)")
}

function bw_get_totp() {
  .print $(bw get totp "$(.bw_get_id)")
}

function bw_copy_totp() {
  .copy $(bw get totp "$(.bw_get_id)")
}

zle -N bw_get_password
zle -N bw_get_totp

bindkey "$GET_PASSWORD_KEY" bw_get_password
bindkey "$GET_TOTP_KEY" bw_get_totp
