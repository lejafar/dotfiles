# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

platform=`uname`

set -o vi
export EDITOR=vim
#export BG=dark

# increase history size
HISTSIZE=2000
HISTFILESIZE=2000
HISTCONTROL=ignoredups
# make bash append rather than overwrite history on disk
shopt -s histappend
# whenever displaying the prompt, write the previous line to disk
PROMPT_COMMAND='history -a'
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
eval "$(shopt -p | grep globstar)"

# bindings a la emacs
bind -m vi-insert "\C-l":clear-screen
bind -m vi-insert "\C-p":previous-history
bind -m vi-insert "\C-n":next-history

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    if [ ! "$platform" == 'Darwin' ]; then
        # red for linux
        PROMPT_COLOR='\[\033[1;31;1m\]'
    else
        # yellow for mac
        PROMPT_COLOR='\[\033[1;33;1m\]'
    fi

	RESET_COLOR='\[\033[0m\]'
	PS1="${PROMPT_COLOR}\u@\h \w $ ${RESET_COLOR}"
else
    PS1='\u@\h \w $ '
fi

#export LSCOLORS="exFxCxDxBxegedabagacad"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ ! "$platform" == 'Darwin' ]; then
	alias ls='ls --color=auto -G'
fi
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#alias ls='ls --color=auto -G'
alias ll='ls -alGh'

if [ "$platform" == 'Darwin' ]; then
	alias alert='growlnotify -m DONE'
elif [ ! -z "TMUX" ]; then
	alias alert='tmux display-message DONE; echo -e "\a"'
else
	alias alert='echo -e "\a"'
	#notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

# set colors for ls
#[ "$BG" = "dark" ] && {
    #export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.cpp=01;34:*.hpp=01;34:*.py=01;34:*.pyc=01;30:*.o=01;30:*.lo=01;30';
#}

fixssh() {
    eval $(tmux show-env -s |grep '^SSH_')
}


latestTag(){
  # Get new tags from remote
  git fetch --tags
  # Get latest tag name
  latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)

  # Checkout latest tag
  git checkout $latestTag
}


# Git Aliases
alias gs='git status'
alias gstsh='git stash'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsh='git show'
alias gshw='git show'
alias gshow='git show'
alias gi='vim .gitignore'
alias gcm='git commit -m'
alias gcim='git commit -m'
alias gci='git commit'
alias gco='git co'
alias gcp='git cp'
alias ga='git add -A'
alias gap='git add -p'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gl='git l'
alias glg='git l'
alias glog='git l'
alias co='git co'
alias gf='git fetch'
alias gfch='git fetch'
alias gd='git diff'
alias gb='git b'
alias gbd='git b -D -w'
# Staged and cached are the same thing
alias gdc='git diff --cached -w'
alias gds='git diff --staged -w'
alias gpub='grb publish'
alias gtr='grb track'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gp='git push'
alias gpsh='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias gnb='git nb' # new branch aka checkout -b
alias grs='git reset'
alias grsh='git reset --hard'
alias gcln='git clean'
alias gclndf='git clean -df'
alias gclndfx='git clean -dfx'
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gt='git t'
alias gbg='git bisect good'
alias gbb='git bisect bad'
alias gdmb='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'


# Common shell functions
alias ..='cd ..'
alias less='less -r'
alias tf='tail -f'
alias l='less'
alias lh='ls -alt | head' # see the last modified files
alias screen='TERM=screen screen'
alias cc='clear'

# Zippin
alias gz='tar -zcvf'

alias ka9='killall -9'
alias k9='kill -9'


# TMUX
alias mmux='tmux new -s'
alias tls='tmux list-session'
alias hugg='tmux attach -t'
alias shoot='tmux kill-session -t'


# check recursively how many files are contained inside a directory
toomanyfiles(){
  find . -maxdepth $1 -exec sh -c  "printf \"{}:\"; find \"{}\" -type f | wc -l" \; | sort -t: -k2rn | head -n25
}
