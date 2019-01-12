#!/bin/bash

VERTICAL_MONITOR_WALLPAPERS=($HOME/dotfiles/.wallpaper/vertical/*)
HORIZONTAL_MONITOR_WALLPAPERS=($HOME/dotfiles/.wallpaper/horizontal/*)

function get_random_wallpaper_from_array {
    local wallpapers=("$@")
    local count=${#wallpapers[@]}
    local random_value=$((0 + RANDOM % $count))
    echo ${wallpapers[random_value]}
}

function get_vertical_wallpaper {
    echo $(get_random_wallpaper_from_array "${VERTICAL_MONITOR_WALLPAPERS[@]}")
}

function get_horizontal_wallpaper {
    echo $(get_random_wallpaper_from_array "${HORIZONTAL_MONITOR_WALLPAPERS[@]}")
}

function set_background_for_current_setup {
    local left_vertical=$1
    local center_horizontal=$2
    local right_horizontal=$3
    
    eval feh --bg-fill $center_horizontal $left_vertical $right_horizontal
}

function get_random_wallpapers_for_current_setup {
    local vertical=$(get_vertical_wallpaper)
    local horizontal1=$(get_horizontal_wallpaper)
    local horizontal2=$(get_horizontal_wallpaper)
  
    local vertical_file_name=$(get_filename_from_path $vertical)
    local horizontal1_file_name=$(get_filename_from_path $horizontal1)
    local horizontal2_file_name=$(get_filename_from_path $horizontal2)

    if [[ ( "$vertical_file_name" == "$horizontal1_file_name" ) || ( "$horizontal1_file_name" == "$horizontal2_file_name" ) || ( "$vertical_file_name" == "$horizontal2_file_name" ) ]]; then
        get_random_wallpapers_for_current_setup
        return
    fi
    set_background_for_current_setup $vertical $horizontal1 $horizontal2 
}

function get_filename_from_path {
    echo $(basename $1)
}

function get_dirname_from_path {
    echo $(dirname $1)
}

get_random_wallpapers_for_current_setup
