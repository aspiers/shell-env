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
#    - Add prot and unprot
#    - Do safes?kill(all)? functions
#

# }}}

# {{{ Loading status

zshrc_load_status () {
  echo -n "\r.zshrc load: $* ... \e[0K"
}

# }}}

# {{{ What version are we running?

zshrc_load_status 'checking version'

if [[ $ZSH_VERSION == 3.0.<->* ]]; then ZSH_STABLE_VERSION=yes; fi
if [[ $ZSH_VERSION == 3.1.<->* ]]; then ZSH_DEVEL_VERSION=yes;  fi

ZSH_VERSION_TYPE=old
if [[ $ZSH_VERSION == 3.1.<6->* ||
      $ZSH_VERSION == 3.2.<->*  ||
      $ZSH_VERSION == 4.<->* ]]
then
  ZSH_VERSION_TYPE=new
fi

# }}}
# {{{ Options

zshrc_load_status 'setting options'

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
     NO_glob_dots \
        glob_subst \
        hash_cmds \
        hash_dirs \
        hash_list_all \
        hist_allow_clobber \
        hist_beep \
        hist_ignore_dups \
        hist_ignore_space \
     NO_hist_no_store \
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

if [[ $ZSH_VERSION_TYPE == 'new' ]]; then
  setopt \
        hist_expire_dups_first \
        hist_ignore_all_dups \
     NO_hist_no_functions \
     NO_hist_save_no_dups \
        inc_append_history \
        list_packed \
     NO_rm_star_wait
fi

if [[ $ZSH_VERSION == 3.0.<6->* || $ZSH_VERSION_TYPE == 'new' ]]; then
  setopt \
        hist_reduce_blanks
fi

# }}}
# {{{ Environment

zshrc_load_status 'setting environment'

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
HISTSIZE=3000
SAVEHIST=3000

# }}}
# {{{ Maximum size of completion listing

# Only ask if line would scroll off screen
LISTMAX=0

# }}}
# {{{ Watching for other users

LOGCHECK=60
WATCHFMT="%B[%t]%b %n has %a %l from %M"

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
if (( $#_find_promptinit == 1 )) && [[ -r $_find_promptinit[1] ]]; then
  zshrc_load_status 'prompt system'

  autoload -U promptinit
  promptinit

  PS4="trace %N:%i> "
  #RPS1="$bold_colour$bg_red              $reset_colour"

  # Default prompt style
  if [[ -r /proc/$PPID/cmdline ]] && egrep -q 'Eterm|nexus|vga' /proc/$PPID/cmdline; then
    # probably OK for fancy graphic prompt
    prompt adam2
  else
    prompt adam2 plain
  fi
else
  PS1='%n@%m %B%3~%b %# '
fi

# }}}

# {{{ Completions

zshrc_load_status 'completion system'

# {{{ New advanced completion system

if /bin/true && [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  _compdir=/usr/share/zsh/functions
  [[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)
  autoload -U compinit
  compinit
else
  print "\nAdvanced completion system not found; ignoring zstyle settings."
  function zstyle { }
  function compdef { }
fi

##
## Enable the way cool bells and whistles.
##

# General completion technique
zstyle ':completion:*' completer _complete _correct _approximate _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

# Cache functions created by _regex_arguments
zstyle ':completion:*' cache-path ~/.zsh/.cache-path

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Include non-hidden directories in globbed file completions
# for certain commands
zstyle ':completion::complete:*' \
  tag-order 'globbed-files directories' all-files 
zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

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
# {{{ Simulate my old dabbrev-expand 3.0.5 patch 

zstyle ':completion:*:history-words' stop 'verbose'
zstyle ':completion:*:history-words' remove_all_dups 'yep'

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
else
  # Older versions don't like the above cruft
  _etc_hosts=()
fi

hosts=(
    "$_etc_hosts[@]"

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
    sunsite.org.uk
)

zstyle ':completion:*' hosts $hosts

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
  adamspiers:zsh.sourceforge.net
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
  {root,ben,nmcgroga,cclading,nick,stephen,bear,jo,cmb,dave,davetm}:thelonious.new.ox.ac.uk
  {root,tpcadmin}:hewes.icl.ox.ac.uk
  dnicker:ermine.ox.ac.uk
  chris:plato.wadham.ox.ac.uk
  {chris,weejock}:ferret.lmh.ox.ac.uk
  {root,adam,rian}:server1.w3w.net
)
### END PRIVATE

zstyle ':completion:*:my-accounts' users-hosts $my_accounts
zstyle ':completion:*:other-accounts' users-hosts $other_accounts

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
zstyle ':completion:*:*:telnet:*' hosts-ports-users $telnet_hosts_ports_use

# }}}

# }}}
# {{{ Aliases and functions

zshrc_load_status 'aliases and functions'

### BEGIN PRIVATE
# {{{ Updating rc files

rcup () {
  CVS_RSH=ssh CVSROOT=adam@thelonious.new.ox.ac.uk:/usr/local/cvsroot \
    cvs update "$@"
}

# }}}
### END PRIVATE
# {{{ Reloading .zshrc or functions

reload () {
  if [[ "$#*" -eq 0 ]]; then
    . ~/.zshrc
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

alias ls='/bin/ls --color -F'
# jeez I'm lazy ...
alias l='ls -l'
alias la='ls -la'
alias lsa='ls -a'
alias ld='ls -ld'
# damn, missed out lsd :-)

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
# {{{ finding out disk hogs

# {{{ du1 (du with depth 1)

du1 () {
  du "$@" | egrep -v '/.*/'
  # Another idea from Bart Schaefer, which I need to fix
  # to take parameters
  #du -s *(/)
}

# }}}
# {{{ fbig

# Find big files

fbig () {
  ls -alFR "$@" | sort -rn -k5 | less -r
}

# }}}
# {{{ fbigrpms

# Find rpms which take lots of space

alias fbigrpms='rpm --qf "%{SIZE}\t%{NAME}\n" -qa | sort -nr | less'

# }}}

# }}}
# {{{ Use this to untar after doing a tar ztvf/tvf/ztf command

# Thanks to Bart Schaefer for this one
alias xt='fc -e - tvf=xf ztf=zxf -1'

# }}}

# }}}
# {{{ Job/process control

alias j='jobs -l'
alias mps='ps -o user,pcpu,command'
pst () {
  pstree -p "$@" | less -S
}
which gps >/dev/null && alias gps='gitps -p afx; cx'
alias ra='ps auxww | grep -vE "(^($USERNAME|nobody|root|bin))|login"'
rj () {
  ps auxww | grep -E "($*|^USER)"
}
ru () {
  ps auxww | grep -E "^($*|USER)" | grep -vE "^$USERNAME|login"
}
compdef _users ru

# }}}
# {{{ History

alias h=history

# }}}
# {{{ Environment

alias ts=typeset

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
  last "$@" | head
}
compdef _users lh

alias f=finger

# su changes window title, even if we're not a login shell
su () {
  command su "$@"
  cx
}

# }}}
# {{{ No spelling correction

alias man='nocorrect man'

# }}}
# {{{ X windows related

# {{{ Changing terminal window/icon titles

set_title () {
  local num title

  case "$1" in
    window) num=2
	    ;;
      icon) num=1
	    ;;
         *) print "Usage: set_title ( window | title ) <title>"
	    return 1 
	    ;;
  esac

  title="$2"

  # Other checks will need to be added here.
  if [[ "$TERM" == 'linux' ]]; then
#    print "Cannot currently display $1 title; only remembering value set."
  else
    echo -n "\e]$num;$title\a"
  fi
}

cx () {
  local long_host short_host title_host short_from_opts

  long_host=${HOST}
  short_host=${HOST%%.*}

  if [[ "$1" == "-s" ]]; then
    short_from_opts=yes
    shift
  fi

  if [[ ${+CX_SHORT_HOSTNAMES} -eq 1 || "$short_from_opts" == "yes" ]]; then
    title_host=$short_host
  else
    title_host=$long_host
  fi

  if [[ "$USER" != "$USERNAME" ]]; then
    # We've probably su'ed to a different user but not as a login shell
    unset TITLE ITITLE
  fi   

  if [[ -z "$*" ]]; then
    # Revert window title to previous setting or default
    : ${TITLE="$USERNAME@${title_host}"}
    set_title window "$TITLE"

    # Revert window icon title to previous setting or default
    : ${ITITLE="$USERNAME@${short_host}"}
    set_title icon "$ITITLE"
  else
    # Change window title
    TITLE="$* : $USERNAME@${title_host}"
    set_title window "$TITLE"

    # Change window icon title
    ITITLE="$* @ $USERNAME@${short_host}"
    set_title icon "$ITITLE"
  fi
}

cxx () {
  # Clear titles
  unset TITLE ITITLE
  cx 
}

if [[ "$TERM" == xterm* ]]; then
  # Could also look at /proc/$PPID/cmdline ...
  cx
fi

# }}}
# {{{ export DISPLAY=:0.0

alias sd='export DISPLAY=:0.0'

# }}}

# }}}
# {{{ Different CVS setups

# Sensible defaults
unset CVS_SERVER
export CVSROOT
export CVS_RSH=ssh

scvs_local () {
  CVSROOT=/usr/local/cvsroot
  CVS_RSH=
}

# Add any other CVS setups you want here
### BEGIN PRIVATE
scvs_thelonious () {
  CVSROOT=adam@thelonious.new.ox.ac.uk:/usr/local/cvsroot
  CVS_RSH=ssh
}

scvs_alsa () {
  CVSROOT=
  CVS_RSH=ssh
}

scvs_mediaconsult_remote () {
  CVSROOT=proxy.mediaconsult.com:/share/cvsroot
  CVS_RSH=~/bin/cvs_rsh
}

scvs_mediaconsult_local () {
  CVSROOT=prophet5.mediaconsult.com:/share/cvsroot
  CVS_RSH=ssh
}

scvs_zsh_local () {
  if [[ "$1" == 'write' ]]; then
    CVSROOT=adamspiers@cvs1:/cvsroot/zsh
  else
    CVSROOT=:pserver:anonymous@cvs1:/cvsroot/zsh
  fi
  CVS_RSH=ssh
}

scvs_zsh_remote () {
  if [[ "$1" == 'write' ]]; then
    CVSROOT=adamspiers@cvs.zsh.sourceforge.net:/cvsroot/zsh
  else
    CVSROOT=:pserver:anonymous@cvs.zsh.sourceforge.net:/cvsroot/zsh
  fi
  CVS_RSH=ssh
}
### END PRIVATE

# }}}
# {{{ Other programs

# {{{ less

alias v=less

# }}}
# {{{ CVS

if which cvs >/dev/null; then
  cvst () {
    perl -MGetopt::Std -wl -- - "$@" <<'End_of_Perl'
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
    cvs diff -N "$@" 2>&1 | less
  }

  cvsl () {
    cvs log "$@" 2>&1 | less
  }

  cvsll () {
    rcs2log "$@" | less
  }

  cvss () {
    cvs status -v "$@"
  }

  cvsq () {
    cvs -nq update
  }
fi

# }}}
### BEGIN PRIVATE
# {{{ mutt

alias m=mutt

# }}}
### END PRIVATE
# {{{ apropos

alias ap=apropos

# }}}
# {{{ editors

alias e='emacs &!'
alias fe='emacs -nw --eval "(setq make-backup-files nil)"'
alias pico='/usr/bin/pico -z'

# }}}
# {{{ remote logins

ssh () {
  command ssh "$@"
  cx
}

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
# {{{ watching log files

alias tf='less +F'

# }}}

# }}}

# {{{ Global aliases

# WARNING: global aliases are evil.  Use with caution.

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

# }}}

# }}}
# {{{ Key bindings 

zshrc_load_status 'key bindings'

bindkey -s '^X^Z' '%-^M'
bindkey '^[e' expand-cmd-path
bindkey -s '^X?' '\eb=\ef\C-x*'
bindkey '^[^I' reverse-menu-complete
bindkey '^X^N' accept-and-infer-next-history
bindkey '^[p' history-beginning-search-backward
bindkey '^[n' history-beginning-search-forward
bindkey '^[P' history-beginning-search-backward
bindkey '^[N' history-beginning-search-forward
bindkey '^W' kill-region
bindkey '^I' complete-word
bindkey '^[b' emacs-backward-word
bindkey '^[f' emacs-forward-word

# Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'

# }}}
# {{{ Miscellaneous

zshrc_load_status 'miscellaneous'

# {{{ Hash named directories

hash -d I3=/usr/src/redhat/RPMS/i386
hash -d I6=/usr/src/redhat/RPMS/i686
hash -d NA=/usr/src/redhat/RPMS/noarch
hash -d SR=/usr/src/redhat/SRPMS
hash -d SP=/usr/src/redhat/SPECS
hash -d SO=/usr/src/redhat/SOURCES
hash -d BU=/usr/src/redhat/BUILD
hash -d CV=/usr/local/cvsroot
#hash -df

# }}}
# {{{ ls colours

if which dircolors >/dev/null; then
  # show directories in yellow
  eval "`dircolors -b <(echo 'DIR 01;33')`"
fi

if [[ $ZSH_VERSION > 3.1.5 ]]; then
  zmodload -i zsh/complist

  zstyle ':completion:*' list-colors ''

  zstyle ':completion:*:*:kill:*:processes' list-colors \
    '=(#b) #([0-9]#)*=0=01;31'

  # show directories in yellow
  zstyle ':completion:*' list-colors 'di=01;33'
fi  

# }}}

# }}}

# {{{ Specific to xterms

if [[ "${TERM}" == xterm* ]]; then
  unset TMOUT
fi

# }}}
# {{{ Specific to hosts

if [[ -r ~/.zshrc.local ]]; then
  zshrc_load_status '.zshrc.local'
  . ~/.zshrc.local
fi

if [[ -r ~/.zshrc.${HOST%%.*} ]]; then
  zshrc_load_status ".zshrc.${HOST%%.*}"
  . ~/.zshrc.${HOST%%.*}
fi

# }}}

# {{{ Clear up after status display

echo -n "\r"

# }}}
