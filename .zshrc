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
#    - Add prot and unprot
#    - Do safes?kill(all)? functions
#    - Fix zx alias
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

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
  _compdir=/usr/share/zsh/functions
  [[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)
  autoload -U compinit
  compinit
else
  print "Advanced completion system not found; ignoring compstyle settings."
  function compstyle { }
fi

##
## Enable the way cool bells and whistles.
##

# General completion technique
compstyle '*' completer _complete _correct _approximate
compstyle ':incremental' completer _complete _correct
compstyle ':predict' completer _complete

# Cache functions created by _regex_arguments
compstyle '*' cache-path ~/.zsh/.cache-path

# Expand partial paths
compstyle '*' expand 'yes'

# Separate matches into groups
compstyle '*:matches' group 'yes'

# Describe each match group.
# This one assumes that your terminal has a dark background.
compstyle '*:descriptions' format "$fg_bold[white]%d$fg[white]"

# Describe options in full
compstyle '*:options' description 'yes'
compstyle '*:options' auto-description '%d'

# }}}
# {{{ Simulate my old dabbrev-expand 3.0.5 patch 

compstyle '*:history-words' stop 'verbose'
compstyle '*:history-words' remove_all_dups 'yep'

# }}}
# {{{ Common usernames

# users=( tom dick harry )

### BEGIN PRIVATE
#users=( adam adams ben nmcgroga chris cclading nick stephen bear Jo jo root tpcadmin dnicker )
### END PRIVATE

#compstyle '*' users $users

# }}}
# {{{ Common hostnames

hosts=(
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

compstyle '*' hosts $hosts

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
  {root,ben,nmcgroga,cclading,nick,stephen,bear,jo,cmb,dave,davetm}:thelonious.new.ox.ac.uk
  {root,tpcadmin}:hewes.icl.ox.ac.uk
  dnicker:ermine.ox.ac.uk
  chris:plato.wadham.ox.ac.uk
  {chris,weejock}:ferret.lmh.ox.ac.uk
  {root,adam,rian}:server1.w3w.net
)
### END PRIVATE

compstyle '*:my-accounts' users-hosts $my_accounts
compstyle '*:other-accounts' users-hosts $other_accounts

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

zshrc_load_status 'aliases and functions'

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
  du $* | egrep -v '/.*/'
}

# }}}
# {{{ fbig

fbig () {
  ls -alFR $* | sort -rn -k5 | less -r
}

# }}}
# {{{ fbigrpms

alias fbigrpms='rpm --qf "%{SIZE}\t%{NAME}\n" -qa | sort -n | less'

# }}}

# }}}
# {{{ Use this one to untar after doing a tar ztvf or tvf command

# FIXME! Doesn't work
#alias zx='!:s/tvf/xvf'

# }}}

# }}}
# {{{ Job/process control

alias j='jobs -l'
alias mps='ps -o user,pcpu,command'
pst () {
  pstree -p $* | less -S
}
alias gps='gitps -p afx; cx'
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
  last $* | head
}
compdef _users lh

alias f=finger

# su to root and change window title
alias root='echo -n "\e]0;root@${HOST}\a"; su -; cx'

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

if [[ "$TERM" == xterm* ]]; then
  # Could also look at /proc/$PPID/cmdline ...
  cx
fi


# }}}
# {{{ export DISPLAY=:0.0

alias sd='export DISPLAY=:0.0'

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
### BEGIN PRIVATE
# {{{ mutt

alias m=mutt

# }}}
### END PRIVATE
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
alias th='ssh -l adam thelonious.new.ox.ac.uk; cx'
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
alias -g EL='|& less'
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
bindkey '^I' expand-or-complete-prefix
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
hash -d SR=/usr/src/redhat/SRPMS
hash -d SP=/usr/src/redhat/SPECS
hash -d SO=/usr/src/redhat/SOURCES
hash -d BU=/usr/src/redhat/BUILD
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
