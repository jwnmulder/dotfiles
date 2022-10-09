if (( $+commands[batcat] )); then
    alias cat='batcat --paging=never'
elif (( $+commands[bat] )); then
    alias cat='bat --paging=never'
fi
