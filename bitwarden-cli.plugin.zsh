local BW_PASSWORD_KEY="${BW_PASSWORD_KEY:-^[p}"
local BW_TOTP_KEY="${BW_TOTP_KEY:-^[t}"
local BW_AUTO_COPY="${BW_AUTO_COPY:-true}"

function .copy() {
  local result=$1

  if $BW_AUTO_COPY; then
    printf "%s" $result | pbcopy
    zle accept-line
  else
    read -s "reply?$result" < /dev/tty
    zle reset-prompt
  fi
}

function .bw_get_id() {
  local mode=$1
  jq -r -c '.[] | .id + " │ [" + .name + "](" + .login.username + ")"' <(bw list items) \
    | sk --preview-window=:nohidden --preview-window=right:0% --prompt="bw ${mode}> " \
    | cut -f1 -d "│" \
    | tr -d " "
}

function bw_get_password() {
  .copy $(bw get password "$(.bw_get_id password)")
}

function bw_get_totp() {
  .copy $(bw get totp "$(.bw_get_id totp)")
}

zle -N bw_get_password
zle -N bw_get_totp

bindkey "${BW_PASSWORD_KEY}" bw_get_password
bindkey "${BW_TOTP_KEY}" bw_get_totp
