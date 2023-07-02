#! /usr/bin/env bash

. $(dirname "$0")/colors


get_tmux_option() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"
   if [ -n "$option_value" ]; then
      echo "$option_value"
   else
      echo "$default_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

main() {
    local theme
    theme="$(get_tmux_option "@espresso_variant" "main")"

    if [[ $theme == main ]]; then
        background=$black 
        status_color=$blue

        window_status_color=$magenta
        window_status_active_color=$cyan

    elif [[ $theme == blue ]]; then
        background=$blue
        status_color=$black

        window_status_color=$black
        window_status_active_color=$cyan
    fi
    
    message_background_color=$yellow
    message_color=$black

    pane_color=$blue
    pane_active_color=$bright_white

    active_tab_foreground=$bright_white
    active_tab_background=$black
    inactive_tab_foreground=$bright_black
    inactive_tab_background=$black

    # Status
    set "status" "on"
    set "monitor-activity" "on"
    set "status-justify" "left"
    set "status-position" "bottom"
    set "status-left-length" "100"
    set "status-right-length" "100"
    set "status-style" "fg=$status_color,bg=$background,bold"

    espresso_time_format=$(get_tmux_option "@time_format" "%R")
    espresso_date_format=$(get_tmux_option "@date_format" "%d/%m/%Y")

    datetime_block="${espresso_time_format} ${espresso_date_format}"
    host_block="#h "
    set "status-right" "${datetime_block} ${host_block}"
    set "status-left" "#[fg=$status_color,bg=$background] [#S] "

    # Windows
    set "window-status-format" "#I: #W "
    set "window-status-current-format" "#I: #W "

    setw "window-status-separator" "|"
    setw "window-status-style" "fg=$window_status_color,bg=$background"
    setw "window-status-current-style" "fg=$window_status_active_color,bg=$background"
    setw "window-status-activity-style" "fg=$background,bg=$window_status_color"


    # Pane
    set "pane-border-style" "fg=$inactive_tab_foreground,bg=$inactive_tab_background"
    set "pane-active-border-style" "fg=$active_tab_foreground,bg=$active_tab_background"
    set "display-panes-colour" "$pane_color"
    set "display-panes-active-colour" "$pane_active_color"

    # Message
    set "message-style" "fg=$message_color,bg=$message_background_color"
    set "message-command-style" "fg=$message_color,bg=$message_background_color" # vi command mode
}

main
