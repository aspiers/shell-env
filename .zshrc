#!/bin/zsh
#
# .zshrc file
#
# by Adam Spiers <adam@spiers.net>
#
# $Id$
#

# {{{ To do list

#
#    - cx to figure out whether to output or not, then always load
#      on startup
#    - Cache $(rpm -qa) results and other stuff if poss.
#    - Set completions for Eterm stuff
#    - Add 'this shell used by others' mode
#    - Do safes?kill(all)? functions
#    - Fix zx alias
#    - Remove all assumptions (e.g. don't define CVS-related
#      functions if CVS isn't installed on this system)
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
     NO_hist_allow_clobber \
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

# }}}
# {{{ Environment

# REMINDER: Put non-interactive environment settings in .zshenv

# {{{ Common hostnames

hostnames=(\
    localhost \

### BEGIN PRIVATE
    # New College
    thelonious.new.ox.ac.uk newjcr.new.ox.ac.uk \
    cornholio.new.ox.ac.uk miles.new.ox.ac.uk \
    toots.new.ox.ac.uk ella.new.ox.ac.uk \
    nb5r1.new.ox.ac.uk \

    # OUCS
    ermine.ox.ac.uk sable.ox.ac.uk \

    # Robots
#    beatrice.robots.ox.ac.uk borachio.robots.ox.ac.uk \
#    hamlet.robots.ox.ac.uk don-jon.robots.ox.ac.uk \
#    leonato.robots.ox.ac.uk tybalt.robots.ox.ac.uk \
#    iris.robots.ox.ac.uk witch3.robots.ox.ac.uk \
#    robin.robots.ox.ac.uk armando.robots.ox.ac.uk \
#    slender.robots.ox.ac.uk \

    # Chris Evans
    ferret.lmh.ox.ac.uk \
#    enif.pcl.ox.ac.uk rage.pcl.ox.ac.uk \

    # Chris Cladingboel
    plato.wadham.ox.ac.uk \
    calvin.wadham.ox.ac.uk \

    # reqng
    scuttlebutt.explore.com \

    # Quake-related
#    totally.dappy.com utterly.barmy.com \
#    richard.lse.ac.uk www.unu.nottingham.ac.uk \
#    quake.minos.co.uk \

    # Micromedia
#    foundation.bsnet.co.uk www.mbn.co.uk lon-radius.intensive.net

    # Darren Nickerson
    hewes.icl.ox.ac.uk \

    # Mediaconsult
    proxy.mediaconsult.com 195.217.36.66 \
    tb303.mediaconsult.com 192.168.1.10 \
    prophet5.mediaconsult.com 192.168.1.17 \
    omni.mediaconsult.com 192.168.1.12 \
    tr808.mediaconsult.com 192.168.1.2 \

    # W3
    server1.w3w.net

### END PRIVATE
    # ftp sites
    sunsite.doc.ic.ac.uk
)

# }}}
# {{{ Colours

reset_colour="$(echo -n '\e[0m')"
fg_bold="$(echo -n '\e[1m')"

# Foreground

fg_grey="$(echo -n '\e[30m')"
fg_red="$(echo -n '\e[31m')"
fg_green="$(echo -n '\e[32m')"
fg_yellow="$(echo -n '\e[33m')"
fg_blue="$(echo -n '\e[34m')"
fg_magenta="$(echo -n '\e[35m')"
fg_cyan="$(echo -n '\e[36m')"
fg_white="$(echo -n '\e[37m')"

# Background

bg_grey="$(echo -n '\e[40m')"
bg_red="$(echo -n '\e[41m')"
bg_green="$(echo -n '\e[42m')"
bg_yellow="$(echo -n '\e[43m')"
bg_blue="$(echo -n '\e[44m')"
bg_magenta="$(echo -n '\e[45m')"
bg_cyan="$(echo -n '\e[46m')"
bg_white="$(echo -n '\e[47m')"

# Stop these screwing the environment listing up
bg_zzzz_clear=$bg_grey
fg_zzzz_clear=$fg_white$reset_colour

# }}}
# {{{ Hostnames involved in rc transfers

# Should be in `rcp' style format, e.g.
# rc_home='user@host.com:'

### BEGIN PRIVATE
rc_home='adam@thelonious.new.ox.ac.uk:'
### END PRIVATE

# }}}
# {{{ Filenames involved in rc transfers

# Let's not rely on that one to always work shall we :-)
#zsh_rcfiles=( ~/.[z]sh{rc,env}(N:s#$HOME#\\\\\~#) )

#zsh_rcfiles=( ~/.[z]sh{rc,env}(N:s#$HOME/##) )
#emacs_rcfiles=( \
#                ~/.[e]macs(N:s#$HOME/##) \
#                ~/lib/emacs/init/**/*.el(N:s#$HOME/##) \
#              )

#misc_rcfiles=( \
#               ~/.{bash,complete,ex,lftp,lynx,shell,ytalk}[r]c(N:s#$HOME/##) \
#             )

zsh_rcfiles=( .zshrc .zshenv )
emacs_rcfiles=( .emacs .emacs-common \
		lib/emacs/init/{common/{XEmacs,emacs},XEmacs/{options,custom},GNU_Emacs/custom}.el \
	      )

misc_rcfiles=( \
               .{bash,complete,ex,lftp,lynx,shell,ytalk}rc \
             )

all_rcfiles=( $zsh_rcfiles $emacs_rcfiles $misc_rcfiles )

# }}}

# Variables used by zsh

# {{{ Prompts

# Note: ANSI escape sequences need to be quoted with %{ ... %}
# to tell zsh that they don't change the cursor position.

BASE_PROMPT="%{$bg_blue%}%n@%m%{$reset_colour%} "
POST_PROMPT="%{$reset_colour%}"

BASE_PROMPT_NO_COLOUR=$(echo "$BASE_PROMPT" | perl -pe "s/%{.*?%}//g")
POST_PROMPT_NO_COLOUR=$(echo "$POST_PROMPT" | perl -pe "s/%{.*?%}//g")

# Define prompts

PROMPT_NEWLINE=$(echo -ne "\n%{\r%}")

function precmd {
    setopt noxtrace localoptions
    local base_prompt base_prompt_etc prompt_length space_left

    base_prompt=$(print -P "$BASE_PROMPT_NO_COLOUR")
    base_prompt_etc=$(print -P "$base_prompt%(4~|...|)%3.")
    prompt_length=${#base_prompt_etc}
#    echo "Prompt length is $prompt_length"
#    echo "Base prompt length is $#base_prompt"
    if [[ $prompt_length -lt 40 ]]; then
        PATH_PROMPT="%{$fg_bold$fg_cyan%}%(4~|...|)%3.%{$fg_white%}"
    else
        space_left=$(( $COLUMNS - $#base_prompt - 2 ))
#        echo "Space left is $space_left"
        PATH_PROMPT="%{$fg_bold$fg_green%}%${space_left}<...<%~$PROMPT_NEWLINE%{$fg_white%}"
    fi
    PS1="$BASE_PROMPT$PATH_PROMPT %# $POST_PROMPT"
    PS2="$BASE_PROMPT$PATH_PROMPT %_> $POST_PROMPT"
    PS3="$BASE_PROMPT$PATH_PROMPT ?# $POST_PROMPT"
}

PS4="traced-> "
#RPS1="$fg_bold$bg_red              $reset_colour"

# }}}
# {{{ Function path

if [[ -d $HOME/.zsh/scripts ]]; then
    fpath=( $HOME/.zsh/scripts $fpath)
fi

temp_zshfuncs=( /usr/doc/zsh*/Functions(N) )
if [[ $#temp_zshfuncs -gt 0 ]]; then
    fpath=($fpath /usr/doc/zsh*/Functions(N) )
fi
unset temp_zshfuncs

typeset -U fpath

# }}}
# {{{ Choose word delimiter characters in line editor

WORDCHARS=''

# }}}
# {{{ Save a large history

HISTFILE=$HOME/.zshhistory
HISTSIZE=5000
SAVEHIST=5000

# }}}
# {{{ Maximum size of completion listing

LISTMAX=0

# }}}
# {{{ Watching for other users

LOGCHECK=60
WATCHFMT="%n has %a %l from %M"

# }}}
# {{{ Auto logout

TMOUT=1800
#function TRAPALRM {
#  clear
#  echo Inactivity timeout on $TTY
#  echo
#  vlock -c
#  echo
#  echo Terminal unlocked. [ Press Enter ]
#}

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

function fbig {
    ls -alFR $* | sort -r -k5 | less -r
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

alias du1='du | grep -v "\.\/.*\/"'

# }}}
# {{{ Making stuff publicly accessible

function mp {
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
function srpmrm {
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
function pst {
    pstree -p $*
}
alias ra='ps auxww | grep -vE "(^($USER|nobody|root|bin))|login"'
function rj {
    ps auxww | grep -E "($*|^USER)"
}
function ru {
    ps auxww | grep -E "^($*|USER)" | grep -vE "^$USER|login"
}

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

function lh {
    last $* | head
}

alias f=finger

# su to root and change window title
alias root='echo -n "]0;root@${HOST}"; su -; cxx'

# }}}
# {{{ No spelling correction

alias man='nocorrect man'

# }}}
# {{{ X windows related

# {{{ Changing Eterm/xterm/rxvt/telnet client titles/fonts/pixmaps

function cx {
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
        
    if [[ "$*" == "" ]]; then
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

# Change rxvt font size
function cf {
    if [[ "$*" == "" ]]; then
    echo -n "\e]50;#3\a"
    else
    echo -n "\e]50;#$*\a"
    fi
}

# Change rxvt pixmap
function cb {
    if [[ "$*" == "" ]] && \
       [[ "`which randomise_textures`" != "randomise_textures not found" ]]; \
    then
        echo -n "\e]20;`randomise_textures`\a"
    else
        echo -n "\e]20;$*\a"
    fi
}

# Change Eterm pixmap
function epix {
    if [[ "$*" == "" ]] && \
       [[ "`which randomise_textures`" != "randomise_textures not found" ]]; \
    then
        echo -n "\e]20;`randomise_textures`\a"
    else
        echo -n "\e]20;$*\a"
    fi
}

# Toggle Eterm transparency
function etr {
    echo -e "\e]6;0\a"
}

# Set Eterm tint
function etint {
    case "$*" in
           red)   echo -e "\e]6;2;0xff8080\a" ;;
         green)   echo -e "\e]6;2;0x80ff80\a" ;;
          blue)   echo -e "\e]6;2;0x8080ff\a" ;;
          cyan)   echo -e "\e]6;2;0x80ffff\a" ;;
       magenta)   echo -e "\e]6;2;0xff80ff\a" ;;
        yellow)   echo -e "\e]6;2;0xffff80\a" ;;
             *)   echo -e "\e]6;2;0xffffff\a"
    esac
}

# Set Eterm shade
function eshade {
    local percent

    if [[ "$*" == "" ]]; then
	percent=0
    else
	percent="$*"
    fi
    echo -e "\e]6;1;$percent%\a"
    unset percent
}

# }}}
# {{{ Starting emacs with a title

function et {
    emacs -T "$*: emacs@${HOST}" --xrm="emacs.iconName: $*: emacs@${HOST}" $* &
}

# }}}
# {{{ export DISPLAY=:0.0

alias sd='export DISPLAY=:0.0'

# }}}
# {{{ xauth add of current host

alias xa='xauth add `hostname`/unix:0 `xauth list | head -1 | awk "{print \\$2 \" \" \\$3}"`'

# }}}

# }}}
# {{{ rc files

# {{{ Reload .zshrc

alias reload='. ~/.zshrc'

# }}}
# {{{ rc file transfers

function sendhome {
    if [[ $#* -eq 0 ]]; then
        echo 'Usage: sendhome <files>'
        return 1
    fi

    if [[ "`which rsync`" != "rsync not found" ]]; then
        pushd ~ >/dev/null
        rsync -aHRuvz -e ssh $* $rc_home
        if [[ $OLDPWD != $PWD ]] popd >/dev/null
    else
        echo rsync not found and no other transfer method implemented yet
    fi
}

function gethome {
    if [[ $#* -eq 0 ]]; then
        echo 'Usage: gethome <files>'
        return 1
    fi

    if [[ "`which rsync`" != "rsync not found" ]]; then
        rsync -aHRuvz -e ssh $rc_home"$^^*" ~
    else
        echo rsync not found and no other transfer method implemented yet
    fi
}

#  function send_files {
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

# }}}
# {{{ Other programs

# {{{ apropos

alias ap=apropos

# }}}
# {{{ CVS

function cvst {
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

function cvsd {
    cvs diff $* |& less
}

function cvsl {
    cvs log $* |& less
}

function cvsll {
    rcs2log $* | less
}

function cvsv {
    cvs log $* 2>/dev/null | egrep '^(head|Working file): '
}

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

if [[ `which ncftp` != "ncftp not found" ]]; then
    alias ftp=ncftp
fi

# }}}
# {{{ Viewing files with strings

sl () {
    strings $* | less
}

# }}}
# {{{ Viewing files in $PATH

# wl stands for `Which Less'

wl () {
    if [[ "`which $*`" == "$* not found" ]]; then
	which $*
    else
	less `which $*`
    fi
}

# }}}
# {{{ Unified diffing files

dl () {
    diff -u $* | less
}

# }}}

# }}}

# }}}
# {{{ Completions

# {{{ Set default completion

# Don't need this now we have history-dabbrev-expand.  (For anyone
# else reading this, I wrote a patch for 3.0.5 which implemented the
# equivalent of tcsh's history-dabbrev-expand.  It's possible to do it
# neater since 3.1.x, I believe, but I haven't investigated that yet.)

# compctl -D -f + -H 0 '' -X '(No file found; using history)'

# }}}
# {{{ Set variables to be used by completions

groups=( $(cut -d: -f1 /etc/group) )
#groups=( "${${(f)$(</etc/group)}%%:*}" )

# Set commonly-used usernames (for completions)
# usernames=( )
### BEGIN PRIVATE
usernames=( adam adams ben nmcgroga chris cclading nick stephen bear Jo jo root tpcadmin dnicker )
### END PRIVATE

if [[ -r /proc/filesystems ]]; then
    # Linux
    filesystems="${${(f)$(</proc/filesystems)}#*    }"
else
    filesystems='ufs 4.2 4.3 nfs tmp mfs S51K S52K'
fi

# Find out all of Perl's base pods
if [[ "`which basepods`" == 'basepods not found' ]]; then
    foo=( `find /usr/lib/perl5 -name perl.pod` )
    perl_basepods=( ${foo:h}/*.pod(:r:t) )
    unset foo
else
    local foo
    foo=( `basepods` )
    perl_basepods=( $foo:t:r )
    unset foo
fi

# Find out all of Perl's built-in functions from perlfunc man page

perlfunc=`man -w perlfunc` && \
perl_funcs=(`perl -lne '$in_funcs++, next if /Alphabetical/; \
                        next unless $in_funcs; \
                        if (/^\.Ip "(\w+)/) { \
                          print $1 unless $func{$1}; $func{$1}++ \
                        }' $perlfunc` )

# This one does something similar to pminst from tchrist's pmtools.
# We don't call it dynamically from the completion because it's
# too slow.

compctl_pminst () {
    local inc libdir new_pms_absolute new_pms
    inc=( $( perl -e 'print "@INC"' ) )
    reply=( )
    for libdir in $inc; do
        if [[ $libdir != '.' ]]; then
#           echo Searching in $libdir ...
            new_pms_absolute=( ${^libdir}/**/*.pm(N) )
            new_pms=( $new_pms_absolute(:s#$libdir/##:s#site_perl/##:r:fs#/#::#) )
            reply=( $new_pms $reply )
        fi
    done
}

compctl_pminst_refresh () {
    local reply
    compctl_pminst
    perl_modules=( $reply )
    typeset -U perl_modules
}

if [[ "`which pminst`" == 'pminst not found' ]] compctl_pminst_refresh

# }}}
# {{{ Set functions to be used by completions

compctl_whoson () {
    # remember to remove duplicates, while keeping reply unlocal
    typeset -U reply2
    reply2=( `users` )
    reply=( $reply2 )
}

compctl_dummy () {
    reply=( $1 )
}

# These won't be necessary once we move to 3.1 or 3.2.
# Extraneous variables needed because array interpolation inside
# functions seems a little broken.

compctl_glob_files_dirs_links () {
    local dirs files files2 links link2

    # Globbing flags:
    #   /  directories
    #   @  symlinks
    #   N  avoid errors if non-existent
    #   M  set MARK_DIRS for this glob (append a trailing / for dirs)
    #
    # ${^foo} construct turns on RC_EXPAND_PARAM (double for off)

    dirs=( $1*(/NM) )
    files=( $1$2(NM) )
    links=( $1*(@NM) )
    files2=( ${^files}" " )
    links2=( ${^links}"/" )
    reply=( ${dirs:-''} ${links2:-''} ${files:-''} )
}


compctl_spec () {
    compctl_glob_files_dirs_links ${1:-''} "*.spec"
}

compctl_rpm () {
    compctl_glob_files_dirs_links ${1:-''} "*.rpm"
}

compctl_targz () {
    compctl_glob_files_dirs_links ${1:-''} "*.(tar.gz|t[ag]z|tar.Z|tz|tarZ)"
}

compctl_tar () {
    compctl_glob_files_dirs_links ${1:-''} "*.tar"
}

compctl_pack () {
    local dirs links link2
    dirs=( /PACK/$1*(/NM) )
    links=( /PACK/$1*(@NM) )
    dirs2=( ${^dirs#/PACK/} )
    links2=( ${^links#/PACK/}"/" )
    reply=( ${dirs2:-''} ${links2:-''} )
}

# }}}

# {{{ Shell builtins

compctl -g '*(-/)' -n cd chdir dirs pushd
compctl -c which
compctl -a alias unalias
compctl -v getln getopts read unset vared
compctl -E export
compctl -A shift
compctl -c type whence where which
compctl -m -x 'W[1,-*d*]' -n - 'W[1,-*a*]' -a - 'W[1,-*f*]' -F -- unhash
compctl -m -q -S '=' -x 'W[1,-*d*] n[1,=]' -g '*(-/)' - \
    'W[1,-*d*]' -n -q -S '=' - 'n[1,=]' -g '*(*)' -- hash
compctl -F functions unfunction
compctl -k '(al dc dl do le up al bl cd ce cl cr dc dl do ho is le ma nd nl se so up)' echotc
compctl -v -S '=' -q declare export integer local readonly typeset
compctl -eB -x 'p[1] s[-]' -k '(a f m r)' - \
    'C[1,-*a*]' -ea - 'C[1,-*f*]' -eF - 'C[-1,-*r*]' -ew -- disable
compctl -dB -x 'p[1] s[-]' -k '(a f m r)' - \
    'C[1,-*a*]' -da - 'C[1,-*f*]' -dF - 'C[-1,-*r*]' -dw -- enable
compctl -k "(${(j: :)${(f)$(limit)}%% *})" limit unlimit
compctl -l '' -x 'p[1]' -f -- . source
# Redirection below makes zsh silent when completing unsetopt xtrace
compctl -s '$(setopt 2>/dev/null)' + -o + -x 's[no]' -o -- unsetopt
compctl -s '$(unsetopt)' + -o + -x 's[no]' -o -- setopt
compctl -s '${^fpath}/*(N:t)' autoload
compctl -b bindkey
compctl -c -x 'C[-1,-*k]' -A - 'C[-1,-*K]' -F - 'C[-1,-*L]' -s '$(compctl -L | grep -vE "^compctl -[CDT]" | awk "{print \$NF}")' -- compctl
compctl -x 'C[-1,-*e]' -c - 'C[-1,-[ARWI]##]' -f -- fc
compctl -x 'p[1]' - 'p[2,-1]' -l '' -- sched
compctl -x 'C[-1,[+-]o]' -o - 'c[-1,-A]' -A -- set
# Anything after nohup is a command by itself with its own completion
compctl -l '' nohup noglob exec nice eval - time rusage
compctl -l '' -x 'p[1]' -eB -- builtin
compctl -l '' -x 'p[1]' -em -- command
compctl -x 'p[1]' -c - 'p[2,-1]' -k signals -- trap

# Another possibility for cd/pushd is to use it in conjunction with the
# cdmatch function (in the Functions subdirectory of zsh distribution).
#compctl -K cdmatch -S '/' -q -x 'p[2]' -Q -K cdmatch2 - \
#    'S[/][~][./][../]' -g '*(-/)' + -g '*(-/D)' - \
#    'n[-1,/]' -K cdmatch -S '/' -q -- cd chdir pushd

# }}}

# {{{ File management

compctl -g '*(-/)' -n md mkdir rd rmdir
compctl -s '$(groups)' + -k groups newgrp mp

# }}}
# {{{ Compression and decompression

compctl -f -g '*(-/)' -x 'p[1],s[-]' -k '(ztvf zcvf zxf zxvf tvf cvf xvf -ztvf -zcvf -zxf -zxvf -tvf -cvf -xvf)' - 'W[1,*c*]' -f -g '*(-/)' - 'W[1,*(z*f|f*z)*] p[2]' -K compctl_targz -Q -S '' - 'W[1,*f*] p[2]' -K compctl_tar -Q -S '' -- gnutar gtar tar
compctl -x 'R[-*[dt],^*]' -g '*.(gz|z|Z|t[agp]z|tarZ|tz)' + -g '*(-/)' + -f - \
    's[]' -g '^*(.(tz|gz|t[agp]z|tarZ|zip|ZIP|jpg|JPG|gif|GIF|[zZ])|[~#])' \
    + -f -- gzip
compctl -g '*.(gz|z|Z|t[agp]z|tarZ|tz)' + -g '*(-/)' gunzip gzcat zcat
compctl -g '*.Z' + -g '*(-/)' uncompress zmore
compctl -g '*.F' + -g '*(-/)' melt fcat

# }}}
# {{{ Changing permissions

compctl -f -x 'p[1], p[2] C[-1,-*]' -k groups -- chgrp
compctl -f -x 'p[1] n[-1,.][-1,:], p[2] C[-1,-*] n[-1,.][-1,:]' -k groups - \
    'p[1], p[2] C[-1,-*]' -u -S ':' -q -- chown
compctl -f -x 'p[1]' -k '(600 644 700 755 1775 4775 -R)' - 'p[2] w[1,-R]' -k '(600 644 700 755 1775 4775)' - 'p[2] s[-]' -k '(R)' -- chmod

# }}}
# {{{ Processes and jobs

compctl -x 's[-],p[1]' -k '(aux auxww)' -- ps
compctl -X 'ra does not take arguments' ra
compctl -K compctl_whoson rj
compctl -K compctl_whoson ru
compctl -z -P '%' bg
compctl -j -P '%' fg jobs disown
compctl -j -P '%' + -s '`ps -x | tail +2 | cut -c1-5`' wait

# kill takes signal names as the first argument after -, but job names
# after % or PIDs as a last resort

compctl -j -P '%' + -s '`ps -x | tail +2 | cut -c1-5`' + \
    -x 's[-] p[1]' -k "($signals[1,-3])" -- kill

# }}}

# {{{ Local & remote users

compctl -k usernames -K compctl_whoson -S '@' -q -x 'C[0,newc????]' -K compctl_dummy -S '@sable.ox.ac.uk' - 'n[-1,@]' -k hostnames -- finger f

compctl -k usernames -K compctl_whoson -S '@' -q -x 'C[0,newc????]' -K compctl_dummy -S '@sable.ox.ac.uk' - 'p[1] S[-]' -k '(-x)' - 'n[-1,@]' -k hostnames - 'p[3,-1] W[1,-*],p[2] W[1,^-*]' -k '(&)' -Q -- ytalk

compctl -K compctl_whoson last lh write

# }}}
# {{{ Connecting to remote hosts

compctl -k hostnames ping telnet ftp host nslookup rup rusers

# If the command is rsh, make the first argument complete to hosts and treat the
# rest of the line as a command on its own.
compctl -k hostnames -x 'p[2,-1]' -l '' -- rsh

# rlogin takes hosts and users after `-l'
compctl -k hostnames -x 'c[-1,-l]' -k usernames -- rlogin

compctl -k hostnames -x 'c[-1,-l]' -k usernames -- \
    + -k usernames -S '@' -x 'n[1,@]' -k hostnames -- ssh

compctl -x 'n[1,:]' -f - \
           'n[1,@]' -k hostnames -S ':' - \
           'p[1] W[2,*:*]' -f - \
           'p[2] W[1,*:*]' -f -- \
      + -k usernames -S '@' \
      + -K whoson -S '@' -u -S '@' \
      + -k hostnames -S ':' \
      + -f \
    rcp scp

# talk completion: complete local users, or users at hosts listed via rwho
#compctl -K talkmatch talk ytalk ytalk3
#function talkmatch {
#    local u
#    reply=($(users))
#    for u in "${${(f)$(rwho 2>/dev/null)}%%:*}"; do
#    reply=($reply ${u%% *}@${u##* })
#    done
#}

# }}}
# {{{ Running new shells

# shells: compctl needs some more enhancement to do -c properly.
compctl -f -x 'C[-1,-*c]' -c - 'C[-1,[-+]*o]' -o -- bash ksh sh zsh

# su takes a username and args for the shell.
compctl -u -x 'w[1,-]p[3,-1]' -l sh - 'w[1,-]' -u - 'p[2,-1]' -l sh -- su

# }}}

# {{{ dd

compctl -k '(if of conv ibs obs bs cbs files skip file seek count)' \
    -S '=' -x 's[if=], s[of=]' -f - 'C[0,conv=*,*] n[-1,,], s[conv=]' \
    -k '(ascii ebcdic ibm block unblock lcase ucase swap noerror sync)' \
    -q -S ',' - 'n[-1,=]' -X '<number>'  -- dd

# }}}
# {{{ man

# There are (at least) two ways to complete manual pages. 

#compctl -c -x 's[-]' -k '(M P S a c d D f k K w W)' + -f -- man

# This one is extremely memory expensive if you have lots of man pages

man_var() {
    man_pages=( ${^$(man -w | sed 's/:/ /g')}/man*/*(N:t:r) )
    compctl -k man_pages -x 'C[-1,-P]' -m - \
        'R[-*l*,;]' -- + -g '*.(man|[0-9nlpo](|[a-z])) *(-/)' man
    reply=( $man_pages )
}
compctl -K man_var -x 'C[-1,-P]' -m - \
    'R[-*l*,;]' -- + -g '*.(man|[0-9nlpo](|[a-z])) *(-/)' man

# This one isn't that expensive but somewhat slower

#man_glob () {
#   local a
#   read -cA a
#   if [[ $a[2] == -s ]] then         # Or [[ $a[2] == [0-9]* ]] for BSD
#     reply=( ${^$(man -w | sed 's/:/ /g')}/man$a[3]/$1*$2(N:t:r) )
#   else
#     reply=( ${^$(man -w | sed 's/:/ /g')}/man*/$1*$2(N:t:r) )
#   fi
#}
#compctl -K man_glob -x 'C[-1,-P]' -m - \
#    'R[-*l*,;]' -g '*.(man|[0-9nlpo](|[a-z]))' + -g '*(-/)' -- man

# }}}
# {{{ find

compctl  -g '*(-/)' -d -x 'c[-1,-name]' -f - 'c[-1,-newer]' -f - 'c[-1,-{,n}cpio]' -f - 'c[-1,-exec]' -c - 'c[-1,-ok]' -c - 'c[-1,-user]' -u - 'c[-1,-group]'  - 'c[-1,-fstype]' -k '(nfs 4.2)' - 'c[-1,-type]' -k '(b c d f l p s)' - 's[-]' -k '(name newer cpio ncpio exec ok user group fstype type atime ctime depth inum ls mtime nogroup nouser perm print prune size xdev)' -- find
# Find is very system dependent, this one is for GNU find.
# Note that 'r[-exec,;]' must come first
compctl -x \
    'r[-exec,;][-ok,;]' -l '' - 's[-]' \
    -s 'daystart {max,min,}depth follow noleaf version xdev {a,c,}newer {a,c,m}{min,time} empty false {fs,x,}type gid inum links {i,}{l,}name {no,}{user,group} path perm regex size true uid used exec {f,}print{f,0,} ok prune ls' - \
    'p[1]' -g '. .. *(-/)' - \
    'C[-1,-((a|c|)newer|fprint(|0|f))]' -f - \
    'c[-1,-fstype]' -s $filesystems - \
    'c[-1,-group]' -k groups - \
    'c[-1,-user]' -u -- find

# }}}
# {{{ xsetroot

compctl -k '(-help -def -display -cursor -cursor_name -bitmap -mod -fg -bg -grey -rv -solid -name)' -x \
    'c[-1,-display]' -s '$DISPLAY' -k hosts -S ':0' - \
    'c[-1,-cursor]' -f -  'c[-2,-cursor]' -f - \
    'c[-1,-bitmap]' -g '/usr/include/X11/bitmaps/*' - \
    'c[-1,-cursor_name]' -K Xcursor - \
    'C[-1,-(solid|fg|bg)]' -K Xcolours -- xsetroot

# }}}
# {{{ wl

compctl -c wl

# }}}

# {{{ Box administration-type commands

# {{{ RedHat Linux rpm utility

compctl -s '$(rpm -qa)' -x \
    's[--]' -s 'oldpackage percent replacefiles replacepkgs noscripts root excludedocs includedocs test upgrade test clean short-circuit sign recompile rebuild resign querytags queryformat version help quiet rcfile force hash' - \
    's[ftp:]' -P '//' -s '$(<~/.zsh/ftphosts)' -S '/' - \
    'c[-1,--root]' -g '*(-/)' - \
    'c[-1,--rcfile]' -f - \
    'p[1] s[-b],s[-t]' -k '(p l c i b a)' - \
    'C[-1,-b*]' -K compctl_spec -Q -S '' - \
    'C[-1,-t*]' -K compctl_targz -Q -S '' - \
    'c[-1,--queryformat] N[-1,{]' \
        -s '"${${(f)$(rpm --querytags)}#RPMTAG_}"' -S '}' - \
    'W[1,-q*] C[-1,-([^-]*|)f*]' -f - \
    'W[1,-([^-]*|)([iU])*], W[1,-q*] C[-1,-([^-]*|)p*], r[--rebuild,qux][--recompile,qux]' \
      -K compctl_rpm -Q -S '' -- \
  rpm

# }}}
# {{{ edquota

compctl -k usernames edquota

# }}}
# {{{ loadkeys

compctl -g '/usr/lib/kbd/keytables/*(:t)' loadkeys

# }}}
# {{{ setfont

compctl -g '/usr/lib/kbd/consolefonts/*(:t)' setfont

# }}}

# }}}

# {{{ C/C++/program building

# {{{ make and relations

compctl -s "\$(awk '/^[a-zA-Z0-9][^     ]+:/ {print \$1}' FS=: [mM]akefile)" \
  -x 'c[-1,-f]' -f -- make gmake pmake

# }}}
# {{{ cc

# Generic completion for C compiler.
compctl -g "*.[cCoa]" -x 's[-I]' -g "*(-/)" - \
    's[-l]' -s '${(s.:.)^LD_LIBRARY_PATH}/lib*.a(:t:r:s/lib//)' -- cc

# }}}
# {{{ gcc

# GCC completion, by Andrew Main
# completes to filenames (*.c, *.C, *.o, etc.); to miscellaneous options after
# a -; to various -f options after -f (and similarly -W, -g and -m); and to a
# couple of other things at different points.
# The -l completion is nicked from the cc compctl above.
# The -m completion should be tailored to each system; the one below is i386.
compctl -g '*.([cCmisSoak]|cc|cxx|ii|k[ih])' -x \
    's[-l]' -s '${(s.:.)^LD_LIBRARY_PATH}/lib*.a(:t:r:s/lib//)' - \
    'c[-1,-x]' -k '(none c objective-c c-header c++ cpp-output assembler assembler-with-cpp)' - \
    'c[-1,-o]' -f - \
    'C[-1,-i(nclude|macros)]' -g '*.h' - \
    'C[-1,-i(dirafter|prefix)]' -g '*(-/)' - \
    's[-B][-I][-L]' -g '*(-/)' - \
    's[-fno-],s[-f]' -k '(all-virtual cond-mismatch dollars-in-identifiers enum-int-equiv external-templates asm builtin strict-prototype signed-bitfields signd-char this-is-variable unsigned-bitfields unsigned-char writable-strings syntax-only pretend-float caller-saves    cse-follow-jumps cse-skip-blocks delayed-branch elide-constructors expensive-optimizations fast-math float-store force-addr force-mem inline-functions keep-inline-functions memoize-lookups default-inline defer-pop function-cse inline peephole omit-frame-pointer rerun-cse-after-loop schedule-insns schedule-insns2 strength-reduce thread-jumps unroll-all-loops unroll-loops)' - \
    's[-g]' -k '(coff xcoff xcoff+ dwarf dwarf+ stabs stabs+ gdb)' - \
    's[-mno-][-mno][-m]' -k '(486 soft-float fp-ret-in-387)' - \
    's[-Wno-][-W]' -k '(all aggregate-return cast-align cast-qual char-subscript comment conversion enum-clash error format id-clash-6 implicit inline missing-prototypes missing-declarations nested-externs import parentheses pointer-arith redundant-decls return-type shadow strict-prototypes switch template-debugging traditional trigraphs uninitialized unused write-strings)' - \
    's[-]' -k '(pipe ansi traditional traditional-cpp trigraphs pedantic pedantic-errors nostartfiles nostdlib static shared symbolic include imacros idirafter iprefix iwithprefix nostdinc nostdinc++ undef)' \
    -X 'Use "-f", "-g", "-m" or "-W" for more options' -- gcc g++

# }}}
# {{{ Utilities for executables

# strip, profile, and debug only executables.  The compctls for the
# debuggers could be better, of course.

#compctl -g '*(*)' strip gprof adb dbx xdbx ups
#compctl -g '*.[ao]|*(*)' nm

# }}}

# }}}
# {{{ Perl

if [[ "`which pminst`" == "pminst not found" ]]; then
    compctl -k perl_modules + -f pmpath pmvers pmdesc pmload pmexp pmeth pmls pmcat pman pmfunc podgrep podtoc podpath
    compctl -k perl_modules -k perl_basepods -f -x 'c[-1,-f]' -k perl_funcs -- + -k man_pages perldoc
else
    compctl -s '$(pminst)' + -f pmpath pmvers pmdesc pmload pmexp pmeth pmls pmcat pman pmfunc podgrep podtoc podpath
    compctl -s '$(pminst)' -k perl_basepods -f -x 'c[-1,-f]' -k perl_funcs -- + -k man_pages perldoc
fi

# }}}
# {{{ RCS

# For rcs users, co and rlog from the RCS directory.  We don't want to see
# the RCS and ,v though.
compctl -g 'RCS/*(:s@RCS/@@:s/,v//)' co rlog rcs rcsdiff

# }}}
# {{{ CVS

# By Bart Schaefer, tweaked by Adam Spiers
#
# There's almost no way to make this all-inclusive, but ...
#
#
cvsflags=(-H -Q -q -r -w -l -n -t -v -b -e -d)
cvscmds=(add admin checkout commit diff history import export log rdiff
	    release remove status tag rtag update)
cvshelpcmds=(--help --help-commands --help-options --help-synonyms)

# diff assumes gnu rcs using gnu diff
# log assumes gnu rcs

compctl -k "($cvscmds $cvsflags)" \
    -x "c[-1,-D]" -k '(today yesterday 1\ week\ ago)' \
    - "r[add,;][new,;]" -k "(-k -m)" -f \
    - "r[admin,;][rcs,;]" -K cvstargets \
    - "r[checkout,;][co,;][get,;]" -k "(-A -N -P -Q -c -f -l -n -p -q -s -r -D -d -k -j)" \
    - "r[commit,;][ci,;]" -k "(-n -R -l -f -m -r)"  -K cvstargets \
    - "r[diff,;]" -k "(-l -D -r -c -u -b -w)" -K cvstargets \
    - "r[history,;] c[-1,-u]" -u \
    - "r[history,;]" \
	-k "(-T -c -o -m -x -a -e -l -w -D -b -f -n -p -r -t -u)" \
	-K cvstargets \
    - "r[import,;]" -k "(-Q -q -I -b -m)" -f \
    - "r[export,;]" -k "(-N -Q -f -l -n -q -r -D -d)" -f \
    - "r[rlog,;][log,;]" -k "(-l -R -h -b -t -r -w)" -K cvstargets \
    - 'r[rlog,;][log,;] s[-w] n[-1,,],s[-w]' -u -S , -q \
    - "r[rdiff,;][patch,;]" -k "(-Q -f -l -c -u -s -t -D -r -V)" -K cvstargets \
    - "r[release,;]" -k "(-Q -d -q)" -f \
    - "r[remove,;][rm,;][delete,;]" -k "(-l -R)" -K cvstargets \
    - "r[status,;]" -k "(-v -l -R)" -K cvstargets \
    - "r[tag,;][freeze,;]" -k "(-Q -l -R -q -d -b)" -K cvstargets \
    - "r[rtag,;][rfreeze,;]" -k "(-Q -a -f -l -R -n -q -d -b -r -D)" -f \
    - "r[update,;]" -k "(-A -P -Q -d -f -l -R -p -q -k -r -D -j -I)" \
	-K cvstargets \
    - "p[1]" -k "($cvscmds $cvsflags $cvshelpcmds)" \
    -- cvs
unset cvsflags cvscmds

cvstargets() {
    local nword args pref f
    setopt localoptions nullglob
    read -nc nword; read -Ac args
    pref=$args[$nword]
    if [[ -d $pref:h && ! -d $pref ]]
    then
	pref=$pref:h
    elif [[ $pref != */* ]]
    then
	pref=
    fi
    [[ -n "$pref" && "$pref" != */ ]] && pref=$pref/
    if [[ -f ${pref}CVS/Entries ]]
    then
	reply=( "${pref}${^${${(f@)$(<${pref}CVS/Entries)}#/}%%/*}"
		${pref}*/**/CVS(:h) )
    else
	reply=( ${pref}*/**/CVS(:h) )
    fi
}

# }}}

# {{{ TeX-/LaTeX-/PS- related

# {{{ xdvi

compctl -g '*.dvi' -x 's[-]' -k '(nogrey gamma margins sidemargin topmargin offsets xoffset yoffset paper altfont expert hush hushspecials hushchars hushchecksums display geometry icongeometry iconic keep copy thorough nopostscript noghostscript version maketexpk mfmode)' -- xdvi

# }}}

# Run ghostscript on postscript files, but if no postscript file matches what
# we already typed, complete directories as the postscript file may not be in
# the current directory.
compctl -g '*.(e|E|)(ps|PS)' + -g '*(-/)' \
    gs ghostview nup psps pstops psmulti psnup psselect

# Similar things for tex, texinfo and dvi files.
compctl -g '*.tex*' + -g '*(-/)' {,la,gla,ams{la,},{g,}sli}tex texi2dvi
compctl -g '*.dvi' + -g '*(-/)' dvips

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

if [[ `which dircolors` != "dircolors not found" ]]; then
    eval "`dircolors -b`"
fi

# }}}

# }}}

# {{{ Specific to xterms

if [[ ${TERM:-''} == 'xterm' ]]; then
    unset TMOUT
fi

# }}}
# {{{ Specific to hosts

if [[ -r $HOME/.zshrc.local ]]; then
    . $HOME/.zshrc.local
fi

if [[ -r $HOME/.zshrc.${HOST%%.*} ]]; then
    . $HOME/.zshrc.${HOST%%.*}
fi

# }}}

# {{{ Lines added by compinstall from zsh 3.1.6

# The following lines were added by compinstall
_compdir=/opt/zsh-3.1.6/share/zsh/functions
[[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)
autoload -U compinit
compinit
compconf completer=_complete:_correct:_approximate
# End of lines added by compinstall

# }}}
