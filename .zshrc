#!/bin/zsh
#
# .zshrc
# for zsh 3.1.6 and newer (may work OK with earlier versions)
#
# by Adam Spiers <adam@spiers.net>
#
# $Id$
#

# {{{ To do list

#
#    - special user@host cases?
#    - Completions: eterm stuff
#    - Add 'this shell used by others' mode
#    - Do safes?kill(all)? functions
#    - Fix zx alias
#

# }}}

# {{{ Options

setopt \
     NO_all_export \
        always_last_prompt \
     NO_always_to_end \
        append_history \
     NO_auto_cd \
        auto_list \
        auto_menu \
     NO_auto_name_dirs \
        auto_param_keys \
        auto_param_slash \
        auto_pushd \
        auto_remove_slash \
     NO_auto_resume \
        bad_pattern \
        bang_hist \
     NO_beep \
        brace_ccl \
        correct_all \
     NO_bsd_echo \
        cdable_vars \
     NO_chase_links \
     NO_clobber \
        complete_aliases \
        complete_in_word \
     NO_correct \
        correct_all \
        csh_junkie_history \
     NO_csh_junkie_loops \
     NO_csh_junkie_quotes \
     NO_csh_null_glob \
        equals \
        extended_glob \
        extended_history \
        function_argzero \
        glob \
     NO_glob_assign \
        glob_complete \
        glob_dots \
        glob_subst \
        hash_cmds \
        hash_dirs \
        hash_list_all \
        hist_allow_clobber \
        hist_beep \
        hist_ignore_dups \
        hist_ignore_space \
     NO_hist_no_store \
     NO_hist_save_no_dups \
        hist_verify \
     NO_hup \
     NO_ignore_braces \
     NO_ignore_eof \
        interactive_comments \
     NO_list_ambiguous \
     NO_list_beep \
        list_types \
        long_list_jobs \
        magic_equal_subst \
     NO_mail_warning \
     NO_mark_dirs \
     NO_menu_complete \
        multios \
        nomatch \
        notify \
     NO_null_glob \
        numeric_glob_sort \
     NO_overstrike \
        path_dirs \
        posix_builtins \
     NO_print_exit_value \
     NO_prompt_cr \
        prompt_subst \
        pushd_ignore_dups \
     NO_pushd_minus \
     NO_pushd_silent \
        pushd_to_home \
        rc_expand_param \
     NO_rc_quotes \
     NO_rm_star_silent \
     NO_sh_file_expansion \
        sh_option_letters \
        short_loops \
     NO_sh_word_split \
     NO_single_line_zle \
     NO_sun_keyboard_hack \
        unset \
     NO_verbose \
     NO_xtrace \
        zle

if [[ $ZSH_VERSION > 3.1.5 ]]; then
  setopt \
        hist_expire_dups_first \
        hist_ignore_all_dups \
     NO_hist_save_no_dups \
        inc_append_history
fi

if [[ $ZSH_VERSION == 3.0.6 || $ZSH_VERSION > 3.1.5 ]]; then
  setopt \
        hist_reduce_blanks
fi

if [[ $ZSH_VERSION > 3.1 ]]; then
  setopt \
     NO_hist_no_functions \
     NO_rm_star_wait \
        list_packed
fi

# }}}
# {{{ Environment

# REMINDER: Put non-interactive environment settings in .zshenv

# {{{ Colours

reset_colour="$(echo -n '\e[0m')"
bold_colour="$(echo -n '\e[1m')"

# Foreground

fg_grey="$(echo -n '\e[0;30m')"
fg_red="$(echo -n '\e[0;31m')"
fg_green="$(echo -n '\e[0;32m')"
fg_yellow="$(echo -n '\e[0;33m')"
fg_blue="$(echo -n '\e[0;34m')"
fg_magenta="$(echo -n '\e[0;35m')"
fg_cyan="$(echo -n '\e[0;36m')"
fg_white="$(echo -n '\e[0;37m')"

fg_bold_grey="$(echo -n '\e[1;30m')"
fg_bold_red="$(echo -n '\e[1;31m')"
fg_bold_green="$(echo -n '\e[1;32m')"
fg_bold_yellow="$(echo -n '\e[1;33m')"
fg_bold_blue="$(echo -n '\e[1;34m')"
fg_bold_magenta="$(echo -n '\e[1;35m')"
fg_bold_cyan="$(echo -n '\e[1;36m')"
fg_bold_white="$(echo -n '\e[1;37m')"

# Background

bg_grey="$(echo -n '\e[0;40m')"
bg_red="$(echo -n '\e[0;41m')"
bg_green="$(echo -n '\e[0;42m')"
bg_yellow="$(echo -n '\e[0;43m')"
bg_blue="$(echo -n '\e[0;44m')"
bg_magenta="$(echo -n '\e[0;45m')"
bg_cyan="$(echo -n '\e[0;46m')"
bg_white="$(echo -n '\e[0;47m')"

bg_bold_grey="$(echo -n '\e[1;40m')"
bg_bold_red="$(echo -n '\e[1;41m')"
bg_bold_green="$(echo -n '\e[1;42m')"
bg_bold_yellow="$(echo -n '\e[1;43m')"
bg_bold_blue="$(echo -n '\e[1;44m')"
bg_bold_magenta="$(echo -n '\e[1;45m')"
bg_bold_cyan="$(echo -n '\e[1;46m')"
bg_bold_white="$(echo -n '\e[1;47m')"

# Stop these screwing the environment listing up
bg_zzzz_clear=$bg_grey
fg_zzzz_clear=$fg_white$reset_colour

# }}}
# {{{ export COLUMNS

# Some programs might find this handy.  Shouldn't do any harm.

export COLUMNS

# }}}

# Variables used by zsh

# {{{ Function path

fpath=(
       ~/{lib/zsh,.zsh}/{functions,scripts}(N) 
       $fpath
       /usr/doc/zsh*/Functions(N)
      )

typeset -U fpath

# }}}
# {{{ Choose word delimiter characters in line editor

WORDCHARS=''

# }}}
# {{{ Save a large history

HISTFILE=~/.zshhistory
HISTSIZE=5000
SAVEHIST=5000

# }}}
# {{{ Maximum size of completion listing

# Only ask if line would scroll off screen
LISTMAX=0

# }}}
# {{{ Watching for other users

LOGCHECK=60
WATCHFMT="%n has %a %l from %M"

# }}}
# {{{ Auto logout

TMOUT=1800
#TRAPALRM () {
#  clear
#  echo Inactivity timeout on $TTY
#  echo
#  vlock -c
#  echo
#  echo Terminal unlocked. [ Press Enter ]
#}

# }}}

# }}}
# {{{ Prompts

# Note: ANSI escape sequences need to be quoted with %{ ... %}
# to tell zsh that they don't change the cursor position.

# Variables common to all prompt styles
prompt_newline=$(echo -ne "\n%{\r%}")

# {{{ adam1

prompt_adam1_setup () {
  base_prompt="%{$bg_blue%}%n@%m%{$reset_colour%} "
  post_prompt="%{$reset_colour%}"

  base_prompt_no_colour=$(echo "$base_prompt" | perl -pe "s/%{.*?%}//g")
  post_prompt_no_colour=$(echo "$post_prompt" | perl -pe "s/%{.*?%}//g")
}

prompt_adam1_precmd () {
  setopt noxtrace localoptions
  local base_prompt_expanded_no_colour base_prompt_etc
  local prompt_length space_left

  base_prompt_expanded_no_colour=$(print -P "$base_prompt_no_colour")
  base_prompt_etc=$(print -P "$base_prompt%(4~|...|)%3~")
  prompt_length=${#base_prompt_etc}
# echo "Prompt length is $prompt_length"
# echo "Base prompt length is $#base_prompt_expanded_no_colour"
  if [[ $prompt_length -lt 40 ]]; then
    path_prompt="%{$fg_bold_cyan%}%(4~|...|)%3~%{$fg_bold_white%}"
  else
    space_left=$(( $COLUMNS - $#base_prompt_expanded_no_colour - 2 ))
#   echo "Space left is $space_left"
    path_prompt="%{$fg_bold_green%}%${space_left}<...<%~$prompt_newline%{$fg_bold_white%}"
  fi
  PS1="$base_prompt$path_prompt %# $post_prompt"
  PS2="$base_prompt$path_prompt %_> $post_prompt"
  PS3="$base_prompt$path_prompt ?# $post_prompt"
}

prompt_adam1 () {
  prompt_adam1_setup
  precmd  () { prompt_adam1_precmd }
  preexec () { }
}

available_prompt_styles=( $available_prompt_styles adam1 )

# }}}
# {{{ adam2

# And you thought the last one was extreme.  If you've ever seen a
# more complex prompt in your whole life, please e-mail it to me; I'd
# love to know that I'm not the saddest person on the planet.

prompt_adam2_setup () {
  # Some can't be local
  local prompt_gfx_tlc prompt_gfx_mlc prompt_gfx_blc prompt_gfx_bbox 

  if [[ $1 == 'plain' ]]; then
    shift
    prompt_gfx_tlc='.'
    prompt_gfx_mlc='|'
    prompt_gfx_blc='\`'
    prompt_gfx_hyphen='-'
  else
    prompt_gfx_tlc=$(echo "\xda")
    prompt_gfx_mlc=$(echo "\xc3")
    prompt_gfx_blc=$(echo "\xc0")
    prompt_gfx_hyphen=$(echo "\xc4")
  fi

  # Colour scheme
  prompt_scheme_colour1=${1:-'cyan'}    # hyphens
  prompt_scheme_colour2=${2:-'green'}   # current directory
  prompt_scheme_colour3=${3:-'cyan'}    # user@host

  local num
  for num in 1 2 3; do
    # Grok this!
    eval "prompt_colour$num="'${(P)$(echo "fg_$prompt_scheme_colour'"$num\")}"
    eval "prompt_bold_colour$num="'${(P)$(echo "fg_bold_$prompt_scheme_colour'"$num\")}"
  done

  prompt_gfx_tbox=$(echo "%{$prompt_bold_colour1%}${prompt_gfx_tlc}%{$prompt_colour1%}${prompt_gfx_hyphen}")
  prompt_gfx_bbox=$(echo "%{$prompt_bold_colour1%}${prompt_gfx_blc}${prompt_gfx_hyphen}%{$prompt_colour1%}")

  # This has to be the coolest prompt hack in the entire world.
  # Uhhhh ... or something.
  prompt_gfx_bbox_to_mbox=$(echo "%{\e[A\r$prompt_bold_colour1${prompt_gfx_mlc}$prompt_colour1${prompt_gfx_hyphen}\e[B%}")

  l_paren=$(echo "%{$fg_bold_grey%}(")
  r_paren=$(echo "%{$fg_bold_grey%})")

  l_bracket=$(echo "%{$fg_bold_grey%}[")
  r_bracket=$(echo "%{$fg_bold_grey%}]")

  prompt_machine=$(echo "%{$prompt_colour3%}%n%{$prompt_bold_colour3%}@%{$prompt_colour3%}%m")

  prompt_padding_text=`perl -e "print qq{${prompt_gfx_hyphen}} x 200"`

  prompt_line_1a="$prompt_gfx_tbox$l_paren%{$prompt_bold_colour2%}%~$r_paren%{$prompt_colour1%}"
  prompt_line_1a_no_colour=$(echo "$prompt_line_1a" | perl -pe "s/%{.*?%}//g")
  prompt_line_1b=$(echo "$l_paren$prompt_machine$r_paren%{$prompt_colour1%}${prompt_gfx_hyphen}")
  prompt_line_1b_no_colour=$(echo "$prompt_line_1b" | perl -pe "s/%{.*?%}//g")

  prompt_line_2="$prompt_gfx_bbox${prompt_gfx_hyphen}%{$fg_white%}"

  prompt_char="%(!.#.>)"
}

prompt_adam2_precmd () {
  setopt noxtrace localoptions
  local prompt_line_1a_no_colour_expanded prompt_line_2a_no_colour_expanded
  local prompt_padding_size prompt_padding prompt_line_1 pre_prompt
  local prompt_pwd_size

  prompt_line_1a_no_colour_expanded=$(print -P "$prompt_line_1a_no_colour")
  prompt_line_1b_no_colour_expanded=$(print -P "$prompt_line_1b_no_colour")
  prompt_padding_size=$(( $COLUMNS
                            - $#prompt_line_1a_no_colour_expanded 
                            - $#prompt_line_1b_no_colour_expanded ))

  if [[ $prompt_padding_size -ge 0 ]]; then
    prompt_padding=$(printf "%$prompt_padding_size.${prompt_padding_size}s" "$prompt_padding_text")
    prompt_line_1="$prompt_line_1a$prompt_padding$prompt_line_1b"
  else
    prompt_padding_size=$(( $COLUMNS
                              - $#prompt_line_1a_no_colour_expanded ))

    if [[ $prompt_padding_size -ge 0 ]]; then
      prompt_padding=$(printf "%$prompt_padding_size.${prompt_padding_size}s" "$prompt_padding_text")
      prompt_line_1="$prompt_line_1a$prompt_padding"
    else
      prompt_pwd_size=$(( $COLUMNS - 5 ))
      prompt_line_1="$prompt_gfx_tbox$l_paren%{$prompt_bold_colour2%}%$prompt_pwd_size<...<%~%<<$r_paren%{$prompt_colour1$prompt_gfx_hyphen%}"
    fi
  fi

  pre_prompt="$prompt_line_1$prompt_newline$prompt_line_2"

  PS1="$pre_prompt%{$fg_bold_white%}$prompt_char "
  PS2="$prompt_line_2%{$prompt_gfx_bbox_to_mbox$fg_bold_white%}%_: "
  PS3="$prompt_line_2%{$prompt_gfx_bbox_to_mbox$fg_bold_white%}?# "
}

prompt_adam2_preexec () {
  print -n "$fg_white"
}

prompt_adam2 () {
  prompt_adam2_setup $*
  precmd () { prompt_adam2_precmd }
  preexec () { prompt_adam2_preexec }
}

available_prompt_styles=( $available_prompt_styles adam2 )

# }}}
# {{{ Switching prompt styles

prompt () {
  if [[ $#* -eq 0 || -z "$available_prompt_styles[(r)$1]" ]]; then
    echo "Usage: prompt <new prompt style> <params>"
    echo "Available styles: $available_prompt_styles[*]"
    return 1
  fi

  eval prompt_$1 $argv[2,-1]
}

# }}}

PS4="trace %N:%i> "
#RPS1="$bold_colour$bg_red              $reset_colour"

# Default prompt style
if [[ -r /proc/$PPID/cmdline ]] && egrep -q 'Eterm|nexus|vga' /proc/$PPID/cmdline; then
  # probably OK for fancy graphic prompt
  prompt adam2
else
  prompt adam2 plain
fi

# }}}
# {{{ Completions

# {{{ New advanced completion system

# The following lines were added by compinstall
_compdir=/usr/share/zsh/functions
[[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)
autoload -U compinit
compinit

compconf completer=_complete 
# End of lines added by compinstall

# Enable the way cool bells and whistles
compconf description_format="$fg_bold_white%d$fg_white"
compconf group_matches=yep
compconf describe_options=yep
compconf autodescribe_options='%d'

# }}}

# {{{ Simulate my old dabbrev-expand 3.0.5 patch 

compconf history_stop=verbose
compconf history_remove_all_dups=yep

# }}}

# {{{ Common usernames

# users=( tom dick harry )

### BEGIN PRIVATE
#users=( adam adams ben nmcgroga chris cclading nick stephen bear Jo jo root tpcadmin dnicker )
### END PRIVATE

# }}}
# {{{ Common hostnames

hostnames=(
    localhost

### BEGIN PRIVATE
    # New College
    thelonious.new.ox.ac.uk newjcr.new.ox.ac.uk

    # OUCS
    ermine.ox.ac.uk sable.ox.ac.uk

    # Robots
#    beatrice.robots.ox.ac.uk borachio.robots.ox.ac.uk
#    hamlet.robots.ox.ac.uk don-jon.robots.ox.ac.uk
#    leonato.robots.ox.ac.uk tybalt.robots.ox.ac.uk
#    iris.robots.ox.ac.uk witch3.robots.ox.ac.uk
#    robin.robots.ox.ac.uk armando.robots.ox.ac.uk
#    slender.robots.ox.ac.uk

    # Chris Evans
    ferret.lmh.ox.ac.uk
#    enif.pcl.ox.ac.uk rage.pcl.ox.ac.uk

    # Chris Cladingboel
    plato.wadham.ox.ac.uk
    calvin.wadham.ox.ac.uk

    # reqng
    scuttlebutt.explore.com

    # Quake-related
#    totally.dappy.com utterly.barmy.com
#    richard.lse.ac.uk www.unu.nottingham.ac.uk
#    quake.minos.co.uk

    # Micromedia
#    foundation.bsnet.co.uk www.mbn.co.uk lon-radius.intensive.net

    # Darren Nickerson
    hewes.icl.ox.ac.uk

    # Mediaconsult
    proxy.mediaconsult.com 195.217.36.66

    # W3
    server1.w3w.net

### END PRIVATE

    # ftp sites
    sunsite.doc.ic.ac.uk
)

# }}}
# {{{ (user,host) pairs

# All my accounts:
#my_accounts=(
#    joe:
#    {joe,root}:mymachine.com
#    jbloggs:myothermachine.com
#)

### BEGIN PRIVATE
my_accounts=(
  {localadams,root}:{pulse.{localdomain,mediaconsult.com,ram.ac.uk},a25.ram.ac.uk,localhost.localdomain}
  {adam,root}:thelonious.new.ox.ac.uk
  adam:hewes.icl.ox.ac.uk
  {adams,root}:
  security:{plato.wadham,thelonious.new,ferret.lmh}.ox.ac.uk
  {adams,root}:server1.w3w.net
  {adams,root}:{proxy.mediaconsult.com,195.217.36.66}
)
### END PRIVATE

# Other people's accounts:
#other_accounts=(
#    bob:
#    {fred,root}:hismachine.com
#    vera:hermachine.com
#)

### BEGIN PRIVATE
other_accounts=(
  {root,ben,nmcgroga,chris,cclading,nick,stephen,bear,jo,cmb,dave,davetm}:thelonious.new.ox.ac.uk
  {root,tpcadmin}:hewes.icl.ox.ac.uk
  dnicker:ermine.ox.ac.uk
  chris:plato.wadham.ox.ac.uk
  {chris,weejock}:ferret.lmh.ox.ac.uk
  {root,adam,rian}:server1.w3w.net
)
### END PRIVATE

# }}}
# {{{ (host, port, user) triples for telnet

#  telnet_hosts_ports_users=(
#    host1::user1
#    host2::user2
#    mail-server:{smtp,pop3}:
#    news-server:nntp:
#    proxy-server:8000:
#  )
### BEGIN PRIVATE
telnet_hosts_ports_users=(
  {localhost,thelonious.new.ox.ac.uk}:{smtp,www,pop3,imap}:
)
### END PRIVATE

# }}}

# }}}
# {{{ Aliases and functions

# {{{ ls aliases

alias ls='/bin/ls --color -F'
# jeez I'm lazy ...
alias l='ls -l'
alias la='ls -la'
alias lsa='ls -a'
alias ld='ls -ld'
# damn, missed out lsd :-)

fbig () {
  ls -alFR $* | sort -rn -k5 | less -r
}

# }}}
# {{{ File management

# {{{ Changing/making/removing directory

alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd......='cd ../../../../..'
alias cd/='cd /'

alias md='mkdir -p'
alias rd=rmdir

alias dirs='dirs -v'
alias d=dirs

# Don't need this because auto_pushd is set
#alias pu=pushd

alias po=popd
alias pwd='pwd -r'

# }}}
# {{{ du1 (du with depth 1)

du1 () {
  du $* | egrep -v '/.*/'
}

# }}}
# {{{ Making stuff publicly accessible

mp () {
  if [[ $#* -lt 3 ]]; then
    echo "Usage: mp <group> <files> ..."
    return 1
  fi

  chgrp $1 $*[2,-1]
  chmod go+rX $*[2,-1]
}

# }}}
# {{{ Use this one to untar after doing a tar ztvf or tvf command

# FIXME! Doesn't work
#alias zx='!:s/tvf/xvf'

# }}}
# {{{ Uninstalling src.rpms

# This uninstalls a src.rpm.  Unfortunately it needs the original
# src.rpm to be supplied as a parameter.
srpmrm () {
  local rpmnameroot rpm
  rpm -qpl $1 | grep -v '\.spec$' | xargs -i rm /usr/src/redhat/SOURCES/{}
  rpm -qpl $1 | grep '\.spec$' | xargs -i rm /usr/src/redhat/SPECS/{}
  rpmnameroot=${${1:t}%%-*}
  foreach rpm in /usr/src/redhat/BUILD/${rpmnameroot}*; do
    echo $rpm | xargs -p -i rm -rf {}
  done
}

# }}}

# }}}
# {{{ Job/process control

alias j='jobs -l'
alias mps='ps -o user,pcpu,command'
pst () {
  pstree -p $* | less -S
}
alias ra='ps auxww | grep -vE "(^($USER|nobody|root|bin))|login"'
rj () {
  ps auxww | grep -E "($*|^USER)"
}
ru () {
  ps auxww | grep -E "^($*|USER)" | grep -vE "^$USER|login"
}
compdef _users ru

# }}}
# {{{ History

alias h=history

# }}}
# {{{ Terminal

# {{{ cls := clear

alias cls='clear'

# }}}
# {{{ Changing terminal type

alias v1='export TERM=vt100'
alias v2='export TERM=vt220'
alias vx='export TERM=xterm-color'

# }}}

# }}}

# {{{ Other users

lh () {
  last $* | head
}
compdef _users lh

alias f=finger

# su to root and change window title
alias root='echo -n "]0;root@${HOST}"; su -; cxx'

# }}}
# {{{ No spelling correction

alias man='nocorrect man'

# }}}
# {{{ X windows related

# {{{ Changing Eterm/xterm/rxvt/telnet client titles/fonts/pixmaps

cx () {
  local longhost shorthost short_from_opts

  shorthost=${HOST%%.*}

  if [[ "$1" == "-s" ]]; then
    short_from_opts=yes
    shift
  fi

  if [[ ${+CX_SHORTHOSTNAMES} -eq 1 || "$short_from_opts" == "yes" ]]; then
    longhost=$shorthost
  else
    longhost=${HOST}
  fi
        
  if [[ -z "$*" ]]; then
    # Change window title
    echo -n "\e]2;$USER@${longhost}\a"

    # Change window icon title
    echo -n "\e]1;$USER@${longhost}\a"
  else
    # Change window title
    echo -n "\e]2;$* : $USER@${longhost}\a"

    # Change window icon title
    echo -n "\e]1;$* @ ${longhost}\a"
  fi
}
alias cxx=cx

if [[ "$TERM" == xterm* ]]; then
  # Could also look at /proc/$PPID/cmdline ...
  cx
fi

# Change rxvt font size
cf () {
  if [[ -z "$*" ]]; then
    echo -n "\e]50;#3\a"
  else
    echo -n "\e]50;#$*\a"
  fi
}
_cf () {
  local expl
  _description expl 'font size'
  compadd "$expl[@]" - 1 2 3 4
}
compdef _cf cf

# Change rxvt pixmap
cb () {
  if [[ -z "$*" ]] && which randomise_textures >/dev/null; then
    echo -n "\e]20;`randomise_textures`\a"
  else
    echo -n "\e]20;$*\a"
  fi
}

# Change Eterm pixmap
epix () {
  if [[ -z "$*" ]] && which randomise_textures >/dev/null; then
    echo -n "\e]20;`randomise_textures`\a"
  else
    echo -n "\e]20;$*\a"
  fi
}

# Toggle Eterm transparency
etr () {
  echo -e "\e]6;0\a"
}

# Set Eterm tint
etint () {
  case "$*" in
        red)  echo -e "\e]6;2;0xff8080\a" ;;
      green)  echo -e "\e]6;2;0x80ff80\a" ;;
       blue)  echo -e "\e]6;2;0x8080ff\a" ;;
       cyan)  echo -e "\e]6;2;0x80ffff\a" ;;
    magenta)  echo -e "\e]6;2;0xff80ff\a" ;;
     yellow)  echo -e "\e]6;2;0xffff80\a" ;;
          *)  echo -e "\e]6;2;0xffffff\a" ;;
  esac
}
_etint () {
  local expl
  _description expl 'tint colour'
  compadd "$expl[@]" - red green blue cyan magenta yellow
}
compdef _etint etint


# Set Eterm shade
eshade () {
  local percent

  if [[ -z "$*" ]]; then
    percent=0
  else
    percent="$*"
  fi
  echo -e "\e]6;1;$percent%\a"
}

# }}}
# {{{ Starting emacs with a title

et () {
  emacs -T "$*: emacs@${HOST}" --xrm="emacs.iconName: $*: emacs@${HOST}" $* &
}

# }}}
# {{{ export DISPLAY=:0.0

alias sd='export DISPLAY=:0.0'

# }}}
# {{{ xauth add of current host

# This is unreliable
alias xa='xauth add `hostname`/unix:0 `xauth list | head -1 | awk "{print \\$2 \" \" \\$3}"`'

# }}}

# }}}
# {{{ rc files

# {{{ Hostnames involved in rc transfers

# Should be in `rcp' style format, e.g.
# rc_home='user@host.com:'

### BEGIN PRIVATE
rc_home='adam@thelonious.new.ox.ac.uk:'
### END PRIVATE

# }}}
# {{{ Filenames involved in rc transfers

# Let's not rely on this one to always work, m'kay?
#zsh_rcfiles=( ~/.[z]sh{rc,env}(N:s#$HOME#\\\\\~#) )

#zsh_rcfiles=( ~/.[z]sh{rc,env}(N:s#$HOME/##) )
#emacs_rcfiles=(
#                ~/.[e]macs(N:s#$HOME/##)
#                ~/lib/emacs/init/**/*.el(N:s#$HOME/##)
#              )

#misc_rcfiles=(
#               ~/.{bash,complete,ex,lftp,lynx,shell,ytalk}[r]c(N:s#$HOME/##)
#             )

zsh_rcfiles=( .zshrc .zshenv )
emacs_rcfiles=( .emacs .emacs-common
                lib/emacs/init/{common/{XEmacs,emacs},XEmacs/{options,custom},GNU_Emacs/custom}.el
              )

misc_rcfiles=(
               .{bash,complete,ex,lftp,lynx,shell,ytalk}rc
             )

all_rcfiles=( $zsh_rcfiles $emacs_rcfiles $misc_rcfiles )

# }}}
# {{{ rc file transfers

sendhome () {
  if [[ $#* -eq 0 ]]; then
    echo 'Usage: sendhome <files>'
    return 1
  fi

  if which rsync >/dev/null; then
    pushd ~ >/dev/null
    rsync -aHRuvz -e ssh $* $rc_home
    if [[ $OLDPWD != $PWD ]] popd >/dev/null
  else
    echo rsync not found and no other transfer method implemented yet
  fi
}

gethome () {
  if [[ $#* -eq 0 ]]; then
    echo 'Usage: gethome <files>'
    return 1
  fi

  if which rsync >/dev/null; then
    rsync -aHRuvz -e ssh $rc_home"$^^*" ~
  else
    echo rsync not found and no other transfer method implemented yet
  fi
}

#  send_files () {
#      # Usage: 1st word contains all hosts, 2nd word contains all files
#      local host hosts files
#      if [[ $#* -eq 1 ]]; then
#          hosts="thelonious.new.ox.ac.uk hewes.icl.ox.ac.uk"
#          files="$1"
#      elif [[ $#* -eq 2 ]]; then
#          hosts="$1"
#          files="$2"
#      else
#          echo 'Usage: sendfiles ["hosts"] "files"'
#          return 1
#      fi
#  }
#
#  #    echo Copying files ${=files} to hosts ${^^=hosts}:
#      foreach host ( ${=hosts} ) {
#          if [[ "$host" != "$HOST" ]]; then
#              echo -n "${host%%.*} ... "
#              scp -r ${=files} $host:
#          fi
#      }
#  }    

# }}}

# {{{ Reloading .zshrc or functions

reload () {
  if [[ "$#*" -eq 0 ]]; then
    . ~/.zshrc
  else
    local fn
    for fn in $*; do
      unfunction $fn
      autoload -U $fn
    done
  fi
}
compdef _functions reload

# }}}

# }}}
# {{{ Other programs

# {{{ CVS

if which cvs >/dev/null; then
  cvst () {
    perl -MGetopt::Std -wl -- - $* <<'End_of_Perl'
      $dir = '';
      getopts('av', \%opts);
      $| = 1;
      open(CVS, "cvs status @ARGV 2>&1 |") or die "cvs status failed: $!\n";
      open(STDERR, ">&STDOUT") or die "Can't dup stdout";
      while (<CVS>) {
        chomp;
        if (/cvs (?:status|server): Examining (.*)/) {
          $dir = "$1/";
        } elsif (/^File:\s+(.*)\s+Status:\s+(.*)/) {
          ($file, $status) = ($1, $2);
          next if ($status eq 'Up-to-date' && ! $opts{'a'});
          $str = "File: $dir$file";
          print $str, ' ' x (45 - length($str)), "Status: $status";
        } elsif (/revision/ && $opts{'v'}) {
          next if ($status eq 'Up-to-date' && ! $opts{'a'});
          print;
        } elsif (/^cvs status:/ || /password:/i) {
          print;
        }
      }
      close(CVS);
End_of_Perl
  }

  cvsd () {
    cvs diff -N $* |& less
  }

  cvsl () {
    cvs log $* |& less
  }

  cvsll () {
    rcs2log $* | less
  }

  cvss () {
    cvs status -v $*
  }

  cvsq () {
    cvs -nq update
  }
fi

# }}}
# {{{ apropos

alias ap=apropos

# }}}
# {{{ editors

alias fe='emacs -nw --eval "(setq make-backup-files nil)"'
alias pico='/usr/bin/pico -z'

# }}}
# {{{ remote logins

if [[ -x ~/bin/detect_ssh-agent ]]; then
  alias dsa='. ~/bin/detect_ssh-agent'
  alias sa=ssh-add

  # Sod it; run it now
  . ~/bin/detect_ssh-agent >&/dev/null
fi

### BEGIN PRIVATE
alias th='ssh -l adam thelonious.new.ox.ac.uk'
### END PRIVATE

# }}}
# {{{ ftp

if which lftp >/dev/null; then
  alias ftp=lftp
elif which ncftp >/dev/null; then
  alias ftp=ncftp
fi

# }}}
# {{{ Viewing files in $PATH

# wl stands for `which less'

wl () {
  if which $* >/dev/null; then
    less `which $*`
  else
    which $*
  fi
}

# }}}
# {{{ strings(1)

# sl stands for `strings less'

sl () {
  strings `which $*` | less
}

# }}}
# {{{ Unified diffing files

dl () {
  diff -u $* | less
}

# }}}

# WARNING: These two use global aliases, which is slightly evil.

# {{{ Paging with less / head / tail

alias -g L='| less'
alias -g H='| head -20'
alias -g T='| tail -20'

# }}}
# {{{ Sorting / counting

alias -g W='| wc -l'

alias -g S='| sort'
alias -g US='| sort -u'
alias -g NS='| sort -n'
alias -g RNS='| sort -nr'

# }}}

# }}}

# }}}
# {{{ Key bindings 

bindkey -s '^X^Z' '%-^M'
bindkey '^[e' expand-cmd-path
bindkey -s '^X?' '\eb=\ef\C-x*'
bindkey '^[^I' reverse-menu-complete
bindkey '^[p' history-beginning-search-backward
bindkey '^[n' history-beginning-search-forward
bindkey '^[P' history-beginning-search-backward
bindkey '^[N' history-beginning-search-forward
bindkey '^W' kill-region
bindkey '^I' expand-or-complete-prefix

# Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'

# }}}
# {{{ Miscellaneous

# {{{ Hash named directories

#hash -df

# }}}
# {{{ ls colours

if which dircolors >/dev/null; then
  # show directories in yellow
  eval "`dircolors -b <(echo 'DIR 01;33')`"
fi

if [[ $ZSH_VERSION > 3.1.5 ]]; then
  zmodload -i complist
  ZLS_COLOURS=${LS_COLORS-${LS_COLOURS-''}}
fi  

# }}}

# }}}

# {{{ Specific to xterms

if [[ "${TERM}" == xterm* ]]; then
  unset TMOUT
fi

# }}}
# {{{ Specific to hosts

[[ -r ~/.zshrc.local ]]       && . ~/.zshrc.local
[[ -r ~/.zshrc.${HOST%%.*} ]] && . ~/.zshrc.${HOST%%.*}

# }}}

