local BW_PASSWORD_KEY="${BW_PASSWORD_KEY:-^[p}"
local BW_TOTP_KEY="${BW_TOTP_KEY:-^[t}"

function __bw_copy() {
    local result=$1

    if [[ $(uname) == "Darwin" ]]; then
        printf "%s" $result | pbcopy
    else
        printf "%s" $result | xsel -i --clipboard
    fi
}

function __bw_get_id() {
    local mode=$1
    local search=""
    local token=$(__bw_session_token)

    if [[ ! -v $2 ]]; then
        search="-q $2"
    fi

    jq -r -c '.[] | .name + "/" + .login.username + " │ " + .id' <(bw list items --session $token) \
        | fzf ${search} -1 --preview-window=:nohidden --preview-window=right:0% --prompt="bw ${mode}> " \
        | cut -f2 -d "│" \
        | tr -d " "
}

function __bw_session_token() {
    local file_path="/tmp/.bw-$(whoami)-$(hostname)-42"
    local token

    if [[ ! -f "$file_path" ]]; then
        token=$(__bw_generate_unlock_token)
    fi

    if [[ $(uname) == "Darwin" ]]; then
        modification_time=$(stat -f "%m" "$file_path")
    else
        modification_time=$(stat -c "%Y" "$file_path")
    fi

    local current_time=$(date +%s)
    local age=$((current_time - modification_time))

    if [[ $age -gt 900 ]]; then
        token=$(__bw_generate_unlock_token)
    else
        token=$(cat $file_path)
    fi

    echo $token
}

function __bw_generate_unlock_token() {
    token=$(bw unlock --raw)
    bw sync --session $token
    echo -n $token > $file_path
    echo -n $token
}

function bw_pass() {
    local subcommand=${1}

    if [[ "${subcommand}" = "otp" ]]; then
        shift
        __bw_totp "${@}"
    elif [[ "${subcommand}" = "list" ]]; then
        __bw_list "${@}"
    else
        __bw_pass "${@}"
    fi
}

function __bw_totp() {
    local token=$(__bw_session_token)

    if [[ "$1" -eq "-c" ]]; then
        __bw_copy $(BW_SESSION=$token bw get totp "$(__bw_get_id totp)")
    else
        BW_SESSION=$token bw get totp "$(__bw_get_id totp)"
    fi
}

function __bw_pass() {
    local token=$(__bw_session_token)

    if [[ "$1" = "-c" ]]; then
        __bw_copy $(BW_SESSION=$token bw get password "$(__bw_get_id password $2)")
    else
        BW_SESSION=$token bw get password "$(__bw_get_id password $1)"
    fi
}

function __bw_list() {
    local token=$(__bw_session_token)

    jq -r -c '.[] | .name + "/" + .login.username' <(bw list items --session $token)
}

function __bw_password(){
    bw_pass -c
    zle accept-line
}

function __bw_otp(){
    bw_pass otp -c
    zle accept-line
}

zle -N "__bw_password"
zle -N "__bw_otp"

bindkey "${BW_PASSWORD_KEY}" __bw_password
bindkey "${BW_TOTP_KEY}" __bw_otp
