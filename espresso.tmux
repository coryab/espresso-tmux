#! /usr/bin/env bash

# Colors taken from https://github.com/dexpota/kitty-themes
background="#323232"
foreground="#ffffff"
cursor="#d6d6d6"
selection_background="#5b5b5b"
selection_foreground="#323232"
color0="#353535"
color8="#535353"
color1="#d25252"
color9="#f00c0c"
color2="#a4c161"
color10="#c1df74"
color3="#ffc56d"
color11="#e1e48a"
color4="#6c99ba"
color12="#8ab6d9"
color5="#d096d9"
color13="#efb5f7"
color6="#bdd6ff"
color14="#dbf4ff"
color7="#ededec"
color15="#ffffff"
active_tab_foreground="#ffffff"
active_tab_background="#535353"
inactive_tab_foreground="#535353"
inactive_tab_background="#353535"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"
   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
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

# Status
set "status" "on"
set "monitor-activity" "on"
set "status-justify" "left"
set "status-position" "bottom"
set "status-left-length" "100"
set "status-right-length" "100"
set "status-style" "fg=$color12,bg=$background,bold"

espresso_time_format=$(get "@time_format" "%R")
espresso_date_format=$(get "@date_format" "%d/%m/%Y")

datetime_block="#[fg=$color3,bg=$base] ${espresso_time_format} ${espresso_date_format}"
host_block="#[fg=$color12,bg=$base] #h "
set "status-right" "${datetime_block} ${host_block}"
set "status-left" "#[fg=$color5,bg=$background] #S "

setw "window-status-separator" ""
setw "window-status-style" "fg=$color5,bg=$background"
setw "window-status-current-style" "fg=$color1,bg=$background"
setw "window-status-activity-style" "fg=$background,bg=$color5"
set "window-status-format" "#[fg=$color5,bg=$background] #I: #W "
set "window-status-current-format" "#[fg=$color1,bg=$background] #I: #W "

# Pane
set "pane-border-style" "fg=$inactive_tab_foreground"
set "pane-active-border-style" "fg=$active_tab_foreground"
set "display-panes-colour" "$color7"
set "display-panes-active-colour" "$color3"

# Message
set "message-style" "fg=$background,bg=$color3"
set "message-command-style" "fg=$background,bg=$color3"
