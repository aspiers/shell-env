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

# {{{ To do list

#
#    - du1
#    - Do safes?kill(all)? functions
#

# }}}

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
# {{{ Loading status

zshrc_load_status () {
  # \e[0K is clear to right
  echo -n "\r.zshrc load: $* ... \e[0K"
}

# }}}

# {{{ Options

zshrc_load_status 'setting options'

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
        brace_ccl            \
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
        hash_cmds            \
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
     NO_list_ambiguous       \
     NO_list_beep            \
        list_types           \
        long_list_jobs       \
        magic_equal_subst    \
     NO_mail_warning         \
     NO_mark_dirs            \
     NO_menu_complete        \
        multios              \
        nomatch              \
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
     NO_sh_word_split        \
     NO_single_line_zle      \
     NO_sun_keyboard_hack    \
        unset                \
     NO_verbose              \
        zle

if [[ $ZSH_VERSION_TYPE == 'new' ]]; then
  setopt                       \
        hist_expire_dups_first \
        hist_ignore_all_dups   \
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

zshrc_load_status 'setting environment'

# {{{ INFOPATH

[[ "$ZSH_VERSION_TYPE" == 'old' ]] || typeset -T INFOPATH infopath
typeset -U infopath # no duplicates
export INFOPATH
infopath=( 
          ~/local/$OSTYPE/info(N)
          ~/local/info(N)
          /usr/local/info(N)
          /usr/info(N)
          $infopath
         )

# }}}
# {{{ MANPATH

case "$OSTYPE" in
  linux*)
    # Don't need to do anything through the cunningness
    # of AUTOPATH in /etc/man.config!
    ;;

  *)
    # Don't trust system-wide MANPATH?  Remember what it was, for reference.
    sysmanpath=$HOME/.sysmanpath
    [ -e $sysmanpath ] || echo "$MANPATH" > $sysmanpath
    manpath=( )
    for dir in "$path[@]"; do
      [[ "$dir" == */bin ]] || continue
      mandir="${dir//\/bin//man}"
      [[ -d "$mandir" ]] && manpath=( "$mandir" "$manpath[@]" )
    done

    # ... or *do* trust system-wide MANPATH
    #MANPATH=/usr/local/bin:/usr/X11R6/bin:/usr/local/sbin:/usr/sbin:/sbin:$MANPATH
    ;;
esac

# }}}

# Variables used by zsh

# {{{ Choose word delimiter characters in line editor

WORDCHARS=''

# }}}
# {{{ Save a large history

HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000

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
  zshrc_load_status 'prompt system'

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
    if prompt -h adam2 | grep -q 8bit; then
      prompt adam2 8bit $adam2_colors
    else
      prompt adam2 $adam2_colors
    fi
  else
    if prompt -h adam2 | grep -q plain; then
      prompt adam2 plain $adam2_colors
    else
      prompt adam2 $adam2_colors
    fi
  fi

  if [[ $TERM == tgtelnet ]]; then
    prompt off
  fi
else
  PS1='%n@%m %B%3~%b %# '
fi

# }}}

# {{{ Completions

zshrc_load_status 'completion system'

# {{{ Set up new advanced completion system

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  autoload -U compinit
  compinit -C # don't perform security check
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

zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# }}}
# {{{ Include non-hidden dirs in globbed file completions for certain commands

#zstyle ':completion::complete:*' \
#  tag-order 'globbed-files directories' all-files 
#zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# }}}
# {{{ Don't complete backup files as executables

zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# }}}
# {{{ Don't complete uninteresting users

zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
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
# {{{ Completion for 'kill'

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# }}}
# {{{ Simulate my old dabbrev-expand 3.0.5 patch 

zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# }}}
# {{{ Common usernames

# users=( tom dick harry )

### BEGIN PRIVATE
#users=( adam adams ben nmcgroga chris cclading nick stephen bear Jo jo root tpcadmin dnicker )
### END PRIVATE

#zstyle ':completion:*' users $users

# }}}
# {{{ Common hostnames

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}
# _ssh_known_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})
else
  # Older versions don't like the above cruft
  _etc_hosts=()
fi

hosts=(
    "$_etc_hosts[@]"

    localhost

### BEGIN PRIVATE
    # home
    adamspiers.{dyndns,homelinux}.org

    # guideguide
    proxy.london.guideguide.com 194.203.206.225
    {aviator,vaeth}.guideguide.com

    # plig
    {,riffraff.}plig.net adamspiers.org

    # New College
    corelli.new.ox.ac.uk 163.1.145.123

    # RAM
    {bach,gw,jascha,purcell,lib}.ram.ac.uk
    general.ulcc.ac.uk

    # Chris Evans
    ferret.lmh.ox.ac.uk

    # Chris Cladingboel
    plato.wadham.ox.ac.uk

    # Darren Nickerson
    hewes.icl.ox.ac.uk

    # W3
    server1.w3w.net

    # Gareth Hughes (cmed)
    194.202.166.101

### END PRIVATE

    # ftp sites
    sunsite.org.uk
)

zstyle ':completion:*' hosts $hosts

# }}}
# {{{ (user,host) pairs

# All my accounts:
#my_accounts=(
#  {joe,root}@mymachine.com
#  jbloggs@myothermachine.com
#)

### BEGIN PRIVATE
my_accounts=(
  {localadams,root}@{pulse,adamspiers.{dyndns,homelinux}.org}
  adams@adamspiers.org
  adam@corelli.new.ox.ac.uk
  adam@aviator.guideguide.com
  {adam,root}@thelonious.new.ox.ac.uk
  adam@hewes.icl.ox.ac.uk
  security@{plato.wadham,thelonious.new,ferret.lmh}.ox.ac.uk
  {adams,root}@server1.w3w.net
  adams@{proxy.guideguide.com,195.217.36.66}
  adamspiers@ssh.sourceforge.net
  adam@landfill.tequilarista.org
  adams@plig.net
)
### END PRIVATE

# Other people's accounts:
#other_accounts=(
#  {fred,root}@hismachine.com
#  vera@hermachine.com
#)

### BEGIN PRIVATE
other_accounts=(
  {root,ben,nmcgroga,cclading,nick,stephen,bear,jo,cmb,dave,davetm}@thelonious.new.ox.ac.uk
  {root,tpcadmin}@hewes.icl.ox.ac.uk
  dnicker@ermine.ox.ac.uk
  chris@plato.wadham.ox.ac.uk
  {chris,weejock}@ferret.lmh.ox.ac.uk
  {root,adam,rian}@server1.w3w.net
)
### END PRIVATE

zstyle ':completion:*:my-accounts' users-hosts $my_accounts
zstyle ':completion:*:other-accounts' users-hosts $other_accounts

# }}}
# {{{ (host, port, user) triples for telnet

#  telnet_users_hosts_ports=(
#    user1@host1:
#    user2@host2:
#    @mail-server:{smtp,pop3}
#    @news-server:nntp
#    @proxy-server:8000
#  )
### BEGIN PRIVATE
telnet_users_hosts_ports=(
  @{localhost,thelonious.new.ox.ac.uk}:{smtp,www,pop3,imap}
)
### END PRIVATE
zstyle ':completion:*:*:telnet:*' users-hosts-ports $telnet_users_hosts_ports

# }}}

# }}}
# {{{ Aliases and functions

zshrc_load_status 'aliases and functions'

# {{{ Better word navigation

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

zle -N backward-to-space
zle -N forward-to-space

zle -N backward-to-/
zle -N forward-to-/

bindkey "^[B"  backward-to-space
bindkey "^[F"  forward-to-space
bindkey "^[^b" backward-to-/
bindkey "^[^f" forward-to-/

# }}}
# {{{ zrecompile

autoload zrecompile

# }}}
# {{{ which/where

# reverse unwanted aliasing of `which' by distribution startup
# files (e.g. /etc/profile.d/which*.sh); zsh's which is perfectly
# good as is.

alias which >&/dev/null && unalias which

alias wh=where

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

restart () {
  exec $SHELL $SHELL_ARGS "$@"
}

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

if ls -F --color >&/dev/null; then
  alias ls='command ls -F --color'
elif ls -F >&/dev/null; then
  alias ls='command ls -F'
elif ls --color >&/dev/null; then
  alias ls='command ls --color'
fi

# jeez I'm lazy ...
alias l='ls -lh'
alias la='ls -lha'
alias lsa='ls -ah'
alias lsh='ls -dh .*'
alias lsr='ls -Rh'
alias ld='ls -ldh'
alias lt='ls -lth'
alias lrt='ls -lrth'
alias lart='ls -larth'
alias lr='ls -lRh'
alias lsL='ls -L'
alias lL='ls -Ll'
# damn, missed out lsd :-)
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

# }}}
# {{{ Job/process control

alias j='jobs -l'
alias dn=disown

# }}}
# {{{ History

alias h='history -$LINES'

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

if [[ "$TERM" == ([Ex]term*|screen*) ]]; then
  # Could also look at /proc/$PPID/cmdline ...
  cx
fi

# }}}
alias sc=screen

# }}}
# {{{ Other users

compdef _users lh

alias f=finger
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

# }}}
# {{{ X windows related

# {{{ export DISPLAY=:0.0

alias sd='export DISPLAY=:0.0'

# }}}

# }}}
# {{{ Different CVS setups

# Sensible defaults
unset CVS_SERVER
export CVSROOT
export CVS_RSH=ssh

# see scvs function

# }}}
# {{{ Other programs

# {{{ less

alias v=less
alias vs='less -S'

# }}}
# {{{ mutt

m () {
  cx mutt
  mutt "$@"
  cxx
}

compdef _mutt m

# }}}
# {{{ editors

# emacs, windowed
e () {
  if [[ -n "$OTHER_USER" ]]; then
    emacs -l $ZDOTDIR/.emacs "$@" &!
  else
    emacs "$@" &!
  fi
}

# enable ^Z
alias pico='/usr/bin/pico -z'

# }}}
# {{{ remote logins

ssh () {
  command ssh "$@"
  cx
}

# Best to run this from .zshrc.local
#dsa >&DN || echo "ssh-agent setup failed; run dsa."

# }}}
# {{{ ftp

if which lftp >&/dev/null; then
  alias ftp=lftp
elif which ncftp >&/dev/null; then
  alias ftp=ncftp
fi

# }}}
# {{{ watching log files

alias tf='less +F'

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
# {{{ Paging with less / head / tail

alias -g L='| less'
alias -g LS='| less -S'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g H='| head -20'
alias -g T='| tail -20'

# }}}
# {{{ Sorting / counting

alias -g C='| wc -l'

alias -g S='| sort'
alias -g US='| sort -u'
alias -g NS='| sort -n'
alias -g RNS='| sort -nr'

# }}}
# {{{ Common filenames

alias -g DN=/dev/null
alias -g VM=/var/log/messages
alias -g VL=/var/log

# }}}
# {{{ grep, xargs

alias -g G='| egrep'
alias -g X='| xargs'

# }}}

# }}}

# }}}
# {{{ Key bindings 

zshrc_load_status 'key bindings'

bindkey -s '^X^Z' '%-^M'
bindkey '^[e' expand-cmd-path
#bindkey -s '^X?' '\eb=\ef\C-x*'
bindkey '^[^I' reverse-menu-complete
bindkey '^X^N' accept-and-infer-next-history
bindkey '^[p' history-beginning-search-backward
bindkey '^[n' history-beginning-search-forward
bindkey '^[P' history-beginning-search-backward
bindkey '^[N' history-beginning-search-forward
bindkey '^W' kill-region
bindkey '^I' complete-word
# bindkey '^[b' emacs-backward-word
# bindkey '^[f' emacs-forward-word

zmodload zsh/deltochar >&/dev/null && bindkey '^[z' zap-to-char

# Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'

alias no=ls  # for Dvorak

# }}}
# {{{ Miscellaneous

zshrc_load_status 'miscellaneous'

# {{{ Hash named directories

hash -d RP=/usr/src/redhat/RPMS
hash -d I3=/usr/src/redhat/RPMS/i386
hash -d I6=/usr/src/redhat/RPMS/i686
hash -d NA=/usr/src/redhat/RPMS/noarch
hash -d SR=/usr/src/redhat/SRPMS
hash -d SP=/usr/src/redhat/SPECS
hash -d SO=/usr/src/redhat/SOURCES
hash -d BU=/usr/src/redhat/BUILD
hash -d LI=/usr/src/linux
hash -d L4=/usr/src/linux-2.4
hash -d CV=/usr/local/cvsroot
hash -d RC=/etc/rc.d/init.d
#hash -df

# }}}
# {{{ ls colours

if which dircolors >&/dev/null && [[ -e "${zdotdir}/.dircolors" ]]; then
  # show directories in yellow
  eval `dircolors -b $zdotdir/.dircolors`
fi

if [[ $ZSH_VERSION > 3.1.5 ]]; then
  zmodload -i zsh/complist

  zstyle ':completion:*' list-colors ''

  zstyle ':completion:*:*:kill:*:processes' list-colors \
    '=(#b) #([0-9]#)*=0=01;31'

  # completion colours
  zstyle ':completion:*' list-colors "$LS_COLORS"
fi  

# }}}
# {{{ Don't always autologout

if [[ "${TERM}" == ([Ex]term*|dtterm|screen*) ]]; then
  unset TMOUT
fi

# }}}

# }}}

# {{{ Specific to local setups

zshrc_load_status 'local hooks'
run_local_hooks .zshrc

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
