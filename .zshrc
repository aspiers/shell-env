#!/bin/zsh
#
# .zshrc
# for zsh 3.1.6 and newer (may work OK with earlier versions)
#
# by Adam Spiers <adam@spiers.net>
#
# Best viewed in emacs folding mode (folding.el).
# (That's what all the # {{{ and # }}} are for.)
#
# $Id$
#

[ -n "$INHERIT_ENV" ] && return 0

# {{{ To do list

#
#    - du1
#    - Do safes?kill(all)? functions
#

# }}}

sh_load_status .zshrc

# {{{ What version are we running?

if ! (( $+ZSH_VERSION_TYPE )); then
  if [[ $ZSH_VERSION == 3.0.<->* ]]; then ZSH_STABLE_VERSION=yes; fi
  if [[ $ZSH_VERSION == 3.1.<->* ]]; then ZSH_DEVEL_VERSION=yes;  fi

  ZSH_VERSION_TYPE=old
  if [[ $ZSH_VERSION == 3.1.<6->* ||
        $ZSH_VERSION == 3.<2->.<->*  ||
        $ZSH_VERSION == 4.<->* ]]
  then
    ZSH_VERSION_TYPE=new
  fi
fi

# }}}
# {{{ Profiling

[[ -n "$ZSH_PROFILE_RC" ]] && which zmodload >&/dev/null && zmodload zsh/zprof

# }}}

# {{{ Options

sh_load_status 'setting options'

setopt                       \
     NO_all_export           \
        always_last_prompt   \
     NO_always_to_end        \
        append_history       \
        auto_cd              \
        auto_list            \
        auto_menu            \
     NO_auto_name_dirs       \
        auto_param_keys      \
        auto_param_slash     \
        auto_pushd           \
        auto_remove_slash    \
     NO_auto_resume          \
        bad_pattern          \
        bang_hist            \
     NO_beep                 \
     NO_brace_ccl            \
        correct_all          \
     NO_bsd_echo             \
        cdable_vars          \
     NO_chase_links          \
     NO_clobber              \
        complete_aliases     \
        complete_in_word     \
     NO_correct              \
        correct_all          \
        csh_junkie_history   \
     NO_csh_junkie_loops     \
     NO_csh_junkie_quotes    \
     NO_csh_null_glob        \
        equals               \
        extended_glob        \
        extended_history     \
        function_argzero     \
        glob                 \
     NO_glob_assign          \
        glob_complete        \
     NO_glob_dots            \
        glob_subst           \
     NO_hash_cmds            \
        hash_dirs            \
        hash_list_all        \
        hist_allow_clobber   \
        hist_beep            \
        hist_ignore_dups     \
        hist_ignore_space    \
     NO_hist_no_store        \
        hist_verify          \
     NO_hup                  \
     NO_ignore_braces        \
     NO_ignore_eof           \
        interactive_comments \
     NO_ksh_glob             \
     NO_list_ambiguous       \
     NO_list_beep            \
        list_types           \
        long_list_jobs       \
        magic_equal_subst    \
     NO_mail_warning         \
     NO_mark_dirs            \
     NO_menu_complete        \
        multios              \
     NO_nomatch              \
        notify               \
     NO_null_glob            \
        numeric_glob_sort    \
     NO_overstrike           \
        path_dirs            \
        posix_builtins       \
     NO_print_exit_value     \
     NO_prompt_cr            \
        prompt_subst         \
        pushd_ignore_dups    \
     NO_pushd_minus          \
        pushd_silent         \
        pushd_to_home        \
        rc_expand_param      \
     NO_rc_quotes            \
     NO_rm_star_silent       \
     NO_sh_file_expansion    \
        sh_option_letters    \
        short_loops          \
        sh_word_split        \
     NO_single_line_zle      \
     NO_sun_keyboard_hack    \
        unset                \
     NO_verbose              \
        zle

if [[ $ZSH_VERSION_TYPE == 'new' ]]; then
  setopt                       \
     NO_hist_expire_dups_first \
        hist_find_no_dups      \
     NO_hist_ignore_all_dups   \
     NO_hist_no_functions      \
     NO_hist_save_no_dups      \
        inc_append_history     \
        list_packed            \
     NO_rm_star_wait
fi

if [[ $ZSH_VERSION == 3.0.<6->* || $ZSH_VERSION_TYPE == 'new' ]]; then
  setopt \
        hist_reduce_blanks
fi

# }}}
# {{{ Environment

sh_load_status 'setting environment'

# {{{ INFOPATH

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T INFOPATH infopath
typeset -U infopath # no duplicates
export INFOPATH
infopath=( 
          ~/{share/,}info(N)
          /usr/{share/,}info(N)
          $infopath
         )

# }}}
# {{{ MANPATH

case "$OSTYPE" in
  linux*)
    # Don't need to do anything through the cunningness
    # of AUTOPATH in /etc/manpath.config!
    ;;

  *)
    echo "Not Linux? really?" >&2
    ;;
esac

# Add extra paths to path determined by /etc/man.config
MANPATH="`MANPATH= manpath`"
manpath=(
    $ZDOTDIR/share/[m]an(N)
    "$manpath[@]"
)

# }}}
# {{{ LANG

# Eterm sucks
if [[ "$LANG" == *UTF-8 ]] && grep Eterm /proc/$PPID/cmdline >&/dev/null; then
    LANG="${LANG%.UTF-8}"
fi

# }}}

# Variables used by zsh

# {{{ Choose word delimiter characters in line editor

# The manual defines WORDCHARS as "a list of non-alphanumeric
# characters considered part of a word by the line editor."
# Nevertheless the effect is not intuitive and best understood by
# experimenting with the value.
WORDCHARS='>~'

# }}}
# {{{ Save a large history

HISTFILE=~/.zshhistory
HISTSIZE=10000
SAVEHIST=10000

# }}}
# {{{ Maximum size of completion listing

#LISTMAX=0    # Only ask if line would scroll off screen
LISTMAX=1000  # "Never" ask

# }}}
# {{{ Watching for other users

LOGCHECK=60
WATCHFMT="[%B%t%b] %B%n%b has %a %B%l%b from %B%M%b"

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

# Load the theme-able prompt system and use it to set a prompt.
# Probably only suitable for a dark background terminal.

local _find_promptinit
_find_promptinit=( $^fpath/promptinit(N) )
if (( $#_find_promptinit >= 1 )) && [[ -r $_find_promptinit[1] ]]; then
  sh_load_status 'prompt system'

  autoload -U promptinit
  promptinit

  PS4="trace %N:%i> "
  #RPS1="$bold_colour$bg_red              $reset_colour"

  # Default prompt style
  adam2_colors=( white cyan cyan green )

  if [[ -r $zdotdir/.zsh_prompt ]]; then
    . $zdotdir/.zsh_prompt
  fi

  if [[ -r /proc/$PPID/cmdline ]] &&
       egrep -q 'watchlogs|kates|nexus|vga' /proc/$PPID/cmdline;
  then
    # probably OK for fancy graphic prompt
    if [[ "`prompt -h adam2`" == *8bit* ]]; then
      prompt adam2 8bit $adam2_colors
    else
      prompt adam2 $adam2_colors
    fi
  else
    if [[ "`prompt -h adam2`" == *plain* ]]; then
      prompt adam2 plain $adam2_colors
    else
      prompt adam2 $adam2_colors
    fi
  fi

  # TopGun ssh for Palm
  case "$TERM" in
      tgtelnet) prompt off ;;
      dumb)
          # Make sure emacs tramp.el doesn't hang.
          # The default value of tramp-shell-prompt-regexp gets confused
          # by CR carriage return characters unless you change the first
          # ^ to \\(^|^M\\) (N.B. ^M would need to be the raw character
          # in that).  But instead we can just stop zsh producing them.

          # Note that zsh's 'off' prompt theme's prompt_opts causes
          # prompt_cr to be enabled.
          #prompt off
          #setopt no_prompt_cr

          # Or we can make our own "theme" right here:
          functions precmd  >/dev/null && unfunction precmd
          functions preexec >/dev/null && unfunction preexec
          setopt no_prompt_cr prompt_subst no_prompt_bang prompt_percent
          PS1="[%n@%m %1~]\$ "
          PS2="> "

          # http://www.emacswiki.org/emacs/TrampMode#toc3 suggests these too
          # but I don't seem to need them:
          #unsetopt zle
          #unsetopt prompt_subst
          ;;
  esac
else
  PS1='%n@%m %B%3~%b %# '
fi

# }}}

# {{{ Completions

sh_load_status 'completion system'

# {{{ Set up new advanced completion system

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  autoload -Uz compinit
  zstyle :compinstall filename '/home/adam/.zshrc'
  compinit -u # use with care!!
else
  print "\nAdvanced completion system not found; ignoring zstyle settings."
  function zstyle { }
  function compdef { }

  # an antiquated, barebones completion system is better than nowt
  which zmodload >&/dev/null && zmodload zsh/compctl
fi

# }}}
# {{{ General completion technique

# zstyle ':completion:*' completer \
#   _complete _prefix _approximate:-one _ignored \
#   _complete:-extended _approximate:-four
zstyle ':completion:*' completer _complete _prefix _ignored _complete:-extended

zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

zstyle ':completion:*:approximate-one:*'  max-errors 1
zstyle ':completion:*:approximate-four:*' max-errors 4

# e.g. f-1.j<TAB> would complete to foo-123.jpeg
zstyle ':completion:*:complete-extended:*' \
  matcher 'r:|[.,_-]=* r:|=*'

# }}}
# {{{ Fancy menu selection when there's ambiguity

#zstyle ':completion:*' menu yes select interactive
#zstyle ':completion:*' menu yes=long select=long interactive
#zstyle ':completion:*' menu yes=10 select=10 interactive

# }}}
# {{{ Completion caching

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# }}}
# {{{ Expand partial paths

# e.g. /u/s/l/D/fs<TAB> would complete to
#      /usr/src/linux/Documentation/fs
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# }}}
# {{{ Include non-hidden dirs in globbed file completions for certain commands

#zstyle ':completion::complete:*' \
#  tag-order 'globbed-files directories' all-files 
#zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# }}}
# {{{ Don't complete backup files (e.g. 'bin/foo~') as executables

zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# }}}
# {{{ Don't complete uninteresting users

zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

# }}}
# {{{ Output formatting

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
 
# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# }}}
# {{{ Array/association subscripts

# When completing inside array or association subscripts, the array
# elements are more useful than parameters so complete them first:
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters 

# }}}
# {{{ Completion for processes

zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always

# }}}
# {{{ Simulate my old dabbrev-expand 3.0.5 patch 

zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# }}}
# {{{ Usernames

run_hooks .zsh/users.d
zstyle ':completion:*' users $zsh_users

# }}}
# {{{ Hostnames

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  # Extract hosts from /etc/hosts
  # ~~ no glob_subst -> don't treat contents of /etc/hosts like pattern
  # (f) shorthand for (ps:\n:) -> split on \n ((p) enables recognition of \n etc.)
  # %%\#* -> remove comment lines and trailing comments
  # (ps:\t:) -> split on tab
  # ##[:blank:]#[^[:blank:]]# -> remove comment lines
  
  : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}
# _ssh_known_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})
else
  # Older versions don't like the above cruft
  _etc_hosts=()
fi

zsh_hosts=(
    "$_etc_hosts[@]"
    localhost
)

run_hooks .zsh/hosts.d
zstyle ':completion:*' hosts $zsh_hosts

# }}}
# {{{ (user, host) account pairs

run_hooks .zsh/accounts.d
zstyle ':completion:*:my-accounts'    users-hosts "$my_accounts[@]"
zstyle ':completion:*:other-accounts' users-hosts "$other_accounts[@]"

# }}}

# {{{ pdf

compdef _pdf pdf

# }}}

# }}}
# {{{ Aliases and functions

sh_load_status 'aliases and functions'

# {{{ Motion/editing

# {{{ Better word navigation

# Remember, WORDCHARS is defined as a 'list of non-alphanumeric
# characters considered part of a word by the line editor'.

# Elsewhere we set it to the empty string.

_my_extended_wordchars='*?_-.[]~=&;!#$%^(){}<>:@,\\'
_my_extended_wordchars_space="${_my_extended_wordchars} "
_my_extended_wordchars_slash="${_my_extended_wordchars}/"

# is the current position \-quoted ?
is_backslash_quoted () {
    test "${BUFFER[$CURSOR-1,CURSOR-1]}" = "\\"
}

unquote-forward-word () {
    while is_backslash_quoted
      do zle .forward-word
    done
}

unquote-backward-word () {
    while is_backslash_quoted
      do zle .backward-word
    done
}

backward-to-space () {
    local WORDCHARS="${_my_extended_wordchars_slash}"
    zle .backward-word
    unquote-backward-word
}

forward-to-space () {
     local WORDCHARS="${_my_extended_wordchars_slash}"
     zle .forward-word
     unquote-forward-word
}

backward-to-/ () {
    local WORDCHARS="${_my_extended_wordchars}"
    zle .backward-word
    unquote-backward-word
}

forward-to-/ () {
     local WORDCHARS="${_my_extended_wordchars}"
     zle .forward-word
     unquote-forward-word
}

# Create new user-defined widgets pointing to eponymous functions.
zle -N backward-to-space
zle -N forward-to-space
zle -N backward-to-/
zle -N forward-to-/

# }}}
# {{{ kill-region-or-backward-(big-)word

# autoloaded
zle -N kill-region-or-backward-word
zle -N kill-region-or-backward-big-word

# }}}
# {{{ kill-big-word

kill-big-word () {
    local WORDCHARS="${_my_extended_wordchars_slash}"
    zle .kill-word
}

zle -N kill-big-word

# }}}
# {{{ transpose-big-words

# autoloaded
zle -N transpose-big-words

# }}}
# {{{ magic-forward-char

zle -N magic-forward-char

# }}}
# {{{ magic-forward-word

zle -N magic-forward-word

# }}}
# {{{ incremental-complete-word

# doesn't work?
zle -N incremental-complete-word

# }}}

# }}}
# {{{ zrecompile

autoload zrecompile

# }}}
# {{{ which/where

# reverse unwanted aliasing of `which' by distribution startup
# files (e.g. /etc/profile.d/which*.sh); zsh's 'which' is perfectly
# good as is.

alias which >&/dev/null && unalias which

# }}}
# {{{ run-help

alias run-help >&/dev/null && unalias run-help
autoload run-help

# }}}
# {{{ zcalc

autoload zcalc

# }}}
# {{{ Restarting zsh or bash; reloading .zshrc or functions

bash () {
  NO_SWITCH="yes" command bash "$@"
}

bx () {
  PS4="$(. ~/.bashenv.d/PS4; echo $PS4)" bash -x "$@"
}

restart () {
  if jobs | grep . >/dev/null; then
    echo "Jobs running; won't restart." >&2
    jobs -l >&2
  else
    exec $SHELL $SHELL_ARGS "$@"
  fi
}
alias rstt=restart

profile () {
  ZSH_PROFILE_RC=1 $SHELL "$@"
}

reload () {
  if [[ "$#*" -eq 0 ]]; then
    . $zdotdir/.zshrc
  else
    local fn
    for fn in "$@"; do
      unfunction $fn
      autoload -U $fn
    done
  fi
}
compdef _functions reload

# }}}
# {{{ ls aliases

if ls -F --color / >&/dev/null; then
    LS_OPTS='-F --color'
elif ls -F / >&/dev/null; then
    LS_OPTS='-F'
elif ls --color / >&/dev/null; then
    LS_OPTS='--color'
fi

# jeez I'm lazy ...
for opts in {,a}{,r}{,t}{,L}{,S}; do
    eval "alias l$opts='ls -lh$opts $LS_OPTS'"
    eval "alias ll$opts='ls -l$opts $LS_OPTS'"
    eval "alias ls$opts='ls ${opts:+-$opts} $LS_OPTS'"
done

alias ld='ls -ldh'
alias sl=ls # often screw this up

# }}}
# {{{ File management/navigation

# {{{ Changing/making/removing directory

alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..
alias -g ......=../../../../..
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
# blegh
alias ..='cd ..'
alias ../..='cd ../..'
alias ../../..='cd ../../..'
alias ../../../..='cd ../../../..'
alias ../../../../..='cd ../../../../..'

alias cd/='cd /'

alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

# Sweet trick from zshwiki.org :-)
cd () {
  if (( $# != 1 )); then
    builtin cd "$@"
    return
  fi

  if [[ -f "$1" ]]; then
    builtin cd "$1:h"
  else
    builtin cd "$1"
  fi
}

z () {
  cd ~/"$1"
}

alias md='mkdir -p'
alias rd=rmdir

alias d='dirs -v'

po () {
  popd "$@"
  dirs -v
}

# }}}
# {{{ Renaming

autoload zmv
alias mmv='noglob zmv -W'

# }}}
# {{{ tree

alias tre='tree -C'

# }}}

# }}}
# {{{ Job/process control

alias j='jobs -l'
alias dn=disown
compdef _jobs_fg dn

# }}}
# {{{ History

alias h='history -f 1 | less +G'
alias hh='history'

# }}}
# {{{ Environment

alias ts=typeset
compdef _typeset ts

# }}}
# {{{ Terminal

alias cls='clear'
alias term='echo $TERM'
# {{{ Changing terminal window/icon titles

which cx >&/dev/null || cx () { }

if [[ "$TERM" == ([Ex]term*|rxvt*|screen*) ]] && [[ -z "$SKIP_CX" ]]; then
    # Could also look at /proc/$PPID/cmdline ...
    # Don't do this, as it resets window titles set by tmux etc.
    # cx
    :
fi

# }}}

# }}}
# {{{ Other users

compdef _users lh

alias f='finger -m'
compdef _finger f

# su changes window title, even if we're not a login shell
su () {
    command su "$@"
    cx
}

# }}}
# {{{ No spelling correction

alias man='nocorrect man'
alias mysql='nocorrect mysql'
alias mysqlshow='nocorrect mysqlshow'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rj='nocorrect rj'
alias yast='nocorrect yast'
alias yast2='nocorrect yast2'

# }}}
# {{{ X windows related

# {{{ export DISPLAY=:0.0

sd () {
    source $ZDOTDIR/.Xdisplay.${HOST%%.*}
}

# }}}

# }}}
# {{{ Different CVS setups

# Sensible defaults
unset CVS_SERVER
export CVSROOT
export CVS_RSH=ssh

# see scvs function

# }}}
# {{{ MIME handling

autoload zsh-mime-setup
zsh-mime-setup

# }}}
# {{{ Other programs

# {{{ less

if ! which less >&/dev/null; then
  alias less=more
fi

alias v=less
alias vs='less -S'

# }}}
# {{{ editors

# enable ^Z
alias pico='/usr/bin/pico -z'

if which vim >&/dev/null; then
    alias vi=vim
fi

# }}}
# {{{ arch

if which larch >&/dev/null; then
    alias a=larch
    compdef _larch a
fi

# }}}
# {{{ bzip2

alias bz=bzip2
alias buz=bunzip2

# }}}

# }}}

# {{{ Global aliases

# WARNING: global aliases are evil.  Use with caution.

# {{{ For screwed up keyboards missing pipe

alias -g PIPE='|'

# }}}
# {{{ Lists of pipelines

alias -g AD='&& div &&'

# }}}

# {{{ Paging with less / head / tail / dts

alias -g L='| less'
alias -g LS='| less -S'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g TRIM='| trim-lines'

alias -g H='| head'
alias -g HL='| head -n $(( +LINES ? LINES - 4 : 20 ))'
alias -g EH='|& head'
alias -g EHL='|& head -n $(( +LINES ? LINES - 4 : 20 ))'

alias -g T='| tail'
alias -g TL='| tail -n $(( +LINES ? LINES - 4 : 20 ))'
alias -g ET='|& tail'
alias -g ETL='|& tail -n $(( +LINES ? LINES - 4 : 20 ))'

alias -g DTS='|& dts'

alias -g F='| fzf'
alias -g EF='|& fzf'

# }}}
# {{{ Sorting / counting

alias -g C='| wc -l'

alias -g S='| sort'
alias -g Su='| sort -u'
alias -g Sn='| sort -n'
alias -g Snr='| sort -nr'
alias -g SUc='| sort | uniq -c'
alias -g SUd='| sort | uniq -d'
alias -g Uc='| uniq -c'
alias -g Ud='| uniq -d'

# }}}
# {{{ Common filenames

alias -g DN=/dev/null
alias -g DZ=/dev/zero
if [[ -e /var/log/syslog ]]; then
    alias -g VM=/var/log/syslog
else
    alias -g VM=/var/log/messages
fi

# }}}
# {{{ grep, xargs

# see also grep-shortcuts script
for global_alias_switches in {,i}{,l,L}{,r}{,v}{,C}; do
    case "$global_alias_switches" in
        *C*)
            rhs_switches="${global_alias_switches//C/}"
            color=--color=always
            ;;
        *)
            rhs_switches="$global_alias_switches"
            color=
            ;;
    esac

    [ -n "$rhs_switches" ] && rhs_switches="-$rhs_switches"

    eval "alias -g  G$global_alias_switches='| egrep $rhs_switches $color'"
    eval "alias -g EG$global_alias_switches='|& egrep $rhs_switches $color'"
    eval "alias -g XG$global_alias_switches='| xargs egrep $rhs_switches $color'"
    eval "alias -g X0G$global_alias_switches='| xargs -0 egrep $rhs_switches $color'"
done

for global_alias_switches in {,0}{,1}{,r}{,n}; do
    other_switches=()
    rhs_switches="$global_alias_switches"
    while true; do
        case "$rhs_switches" in
            *1*)
                rhs_switches="${rhs_switches//1/}"
                other_switches+="-n1"
                ;;
            *n*)
                rhs_switches="${rhs_switches//n/}"
                other_switches+='-d "\n"'
                ;;
            *)
                break
                ;;
        esac
    done

    if [ -z "$global_alias_switches" ]; then
        global_alias_switches="A"
    fi
    xargs_options="${rhs_switches:+ -$rhs_switches} ${other_switches[@]}"
    eval "alias -g X$global_alias_switches='| xargs$xargs_options'"
done

# }}}
# {{{ awk

alias -g A='| awk '
alias -g A1="| awk '{print \$1}'"
alias -g A2="| awk '{print \$2}'"
alias -g A3="| awk '{print \$3}'"
alias -g A4="| awk '{print \$4}'"
alias -g A5="| awk '{print \$5}'"
alias -g A6="| awk '{print \$6}'"
alias -g A7="| awk '{print \$7}'"
alias -g A8="| awk '{print \$8}'"
alias -g A9="| awk '{print \$9}'"
alias -g EA='|& awk '
alias -g EA1="|& awk '{print \$1}'"
alias -g EA2="|& awk '{print \$2}'"
alias -g EA3="|& awk '{print \$3}'"
alias -g EA4="|& awk '{print \$4}'"
alias -g EA5="|& awk '{print \$5}'"
alias -g EA6="|& awk '{print \$6}'"
alias -g EA7="|& awk '{print \$7}'"
alias -g EA8="|& awk '{print \$8}'"
alias -g EA9="|& awk '{print \$9}'"

# }}}

# }}}

# }}}
# {{{ Key bindings 

sh_load_status 'key bindings'

bindkey -s '^X^Z' '%-^M'
bindkey -s '^[H' ' --help'
bindkey -s '^[V' ' --version'
bindkey '^[e' expand-cmd-path
#bindkey -s '^X?' '\eb=\ef\C-x*'
bindkey '^[^I'   reverse-menu-complete
bindkey '^X^N'   accept-and-infer-next-history
bindkey '^[p'    history-beginning-search-backward
bindkey '^[n'    history-beginning-search-forward
bindkey '^[P'    history-beginning-search-backward
bindkey '^[N'    history-beginning-search-forward
bindkey '^w'     kill-region-or-backward-word
bindkey '^[^W'   kill-region-or-backward-big-word
bindkey '^[T'    transpose-big-words
bindkey '^I'     complete-word
bindkey '^Xi'    incremental-complete-word
bindkey '^F'     magic-forward-char
# bindkey '^[b'    emacs-backward-word
# bindkey '^[f'    emacs-forward-word
bindkey '^[f'    magic-forward-word
bindkey '^[B'    backward-to-space
bindkey '^[F'    forward-to-space
bindkey '^[^b'   backward-to-/
bindkey '^[^f'   forward-to-/
bindkey '^[^[[C' emacs-forward-word
bindkey '^[^[[D' emacs-backward-word

bindkey '^[D'  kill-big-word

if zmodload zsh/deltochar >&/dev/null; then
  bindkey '^[z' zap-to-char
  bindkey '^[Z' delete-to-char
fi

# Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'

alias no=ls  # for Dvorak

# }}}
# {{{ Miscellaneous

sh_load_status 'miscellaneous'

# {{{ ls colours

if which dircolors >&/dev/null && [[ -e "${zdotdir}/.dircolors" ]]; then
  eval "`dircolors -b $zdotdir/.dircolors`"
fi

if [[ $ZSH_VERSION > 3.1.5 ]]; then
  zmodload -i zsh/complist

  zstyle ':completion:*' list-colors ''

  zstyle ':completion:*:*:*:*:processes' list-colors \
    '=(#b) #([0-9]#)*=0=01;31'

  # completion colours
  zstyle ':completion:*' list-colors "$LS_COLORS"
fi  

# }}}
# {{{ Don't always autologout

if [[ "${TERM}" == ([Ex]term*|rxvt*|dtterm|screen*) ]]; then
  unset TMOUT
fi

# }}}

# }}}

# {{{ Specific to local setups

sh_load_status 'local hooks'
run_hooks .zshrc.d

# }}}

# {{{ Clear up after status display

if [[ $TERM == tgtelnet ]]; then
  echo
else
  echo -n "\r"
fi

# }}}
# {{{ Profile report

if [[ -n "$ZSH_PROFILE_RC" ]]; then
  zprof >! ~/zshrc.zprof
  exit
fi

# }}}

# {{{ Search for history loosing bug

which check_hist_size >&/dev/null && check_hist_size

# }}}
