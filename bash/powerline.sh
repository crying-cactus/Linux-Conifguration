#!/usr/bin/env bash
#
# Powerline-style bash prompt (segments + angled separators).
# Source this from ~/.bashrc:
#   source ~/.config/bash/powerline.sh
#
# Requires a Nerd Font (or any font with Powerline glyphs) in your terminal.

# -- Colors (eclipse wallpaper palette, truecolor escapes) --
_PL_BG_HOST="16;32;44"      # dark navy  (#10202c-ish)
_PL_FG_HOST="106;183;255"   # thruster bright blue

_PL_BG_DIR="242;169;59"     # gold / corona
_PL_FG_DIR="13;10;8"        # near-black

_PL_BG_GIT="138;75;107"     # muted plum
_PL_FG_GIT="242;233;220"    # cream

_PL_FG_OK="138;154;91"      # olive green (success)
_PL_FG_FAIL="217;82;47"     # burnt orange/red (failure)

_pl_sep() {
    # $1 = foreground (matches previous segment's background)
    # $2 = background (next segment's background), or "none" for transparent
    if [ "$2" = "none" ]; then
        printf '\[\033[38;2;%sm\]\[\033[49m\]\uE0B0' "$1"
    else
        printf '\[\033[38;2;%sm\]\[\033[48;2;%sm\]\uE0B0' "$1" "$2"
    fi
}

__powerline_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || \
    branch=$(git rev-parse --short HEAD 2>/dev/null)
    [ -n "$branch" ] && printf ' %s' "$branch"
}

__powerline_set_ps1() {
    local exit_code=$?

    local host_seg dir_seg git_seg exit_fg exit_glyph
    local branch

    host_seg="\[\033[38;2;${_PL_FG_HOST}m\]\[\033[48;2;${_PL_BG_HOST}m\] \u@\h "
    dir_seg="\[\033[38;2;${_PL_FG_DIR}m\]\[\033[48;2;${_PL_BG_DIR}m\]  \w "

    branch=$(__powerline_git_branch)
    if [ -n "$branch" ]; then
        git_seg="\[\033[38;2;${_PL_FG_GIT}m\]\[\033[48;2;${_PL_BG_GIT}m\] ${branch} "
        last_bg="$_PL_BG_GIT"
    else
        git_seg=""
        last_bg="$_PL_BG_DIR"
    fi

    if [ $exit_code -eq 0 ]; then
        exit_fg="$_PL_FG_OK"
        exit_glyph="❯"
    else
        exit_fg="$_PL_FG_FAIL"
        exit_glyph="❯"
    fi

    PS1="${host_seg}$(_pl_sep "$_PL_BG_HOST" "$_PL_BG_DIR")${dir_seg}"
    if [ -n "$git_seg" ]; then
        PS1+="$(_pl_sep "$_PL_BG_DIR" "$_PL_BG_GIT")${git_seg}"
    fi
    PS1+="$(_pl_sep "$last_bg" none)\[\033[38;2;${exit_fg}m\] ${exit_glyph} \[\033[0m\]"
}

PROMPT_COMMAND=__powerline_set_ps1
