autoload -Uz add-zsh-hook

_zed_terminal_title_should_run() {
    [[ "$TERM_PROGRAM" == "zed" ]]
}

_zed_terminal_title_set() {
    _zed_terminal_title_should_run || return 0
    print -Pn "\e]2;${PWD:t}\a"
}

add-zsh-hook precmd _zed_terminal_title_set
add-zsh-hook preexec _zed_terminal_title_set
