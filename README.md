# Adam's UNIX shell environment

This is my collection of UNIX shell configuration files and utilities.
These days I only use them with zsh and bash on Linux, but in the
past I also used them on various Solaris and FreeBSD machines, and
for the most part they should work on any POSIX-oriented UNIX.

## Contents

* Configuration files for zsh
    * [`.zshrc`](https://github.com/aspiers/shell-env/blob/master/.zshrc) - config for interactive instances only
    * [`.zshenv`](https://github.com/aspiers/shell-env/blob/master/.zshenv) - config for non-interactive *and* interactive instances
    * [`.zsh/`](https://github.com/aspiers/shell-env/tree/master/.zsh/) hierarchy, including:
        * [`.zsh/functions/`](https://github.com/aspiers/shell-env/tree/master/.zsh/functions/) - various handy interactive and completion functions
        * [`.zsh/accounts.d/`](https://github.com/aspiers/shell-env/tree/master/.zsh/accounts.d/) - for configuring completion of (user, host) pairs
        * [`.zsh/users.d/`](https://github.com/aspiers/shell-env/tree/master/.zsh/users.d/) - for configuring completion of users

* Configuration files for bash
    * [`.bashrc`](https://github.com/aspiers/shell-env/blob/master/.bashrc) - config for interactive instances only
    * [`.bash_profile`](https://github.com/aspiers/shell-env/blob/master/.bash_profile) - config for interactive "login shell" instances only
    * [`.bashenv`](https://github.com/aspiers/shell-env/blob/master/.bashenv) - config for non-interactive *and* interactive instances

* Configuration files to be shared by any Bourne-compatible shell
    * [`.shared_env`](https://github.com/aspiers/shell-env/blob/master/.shared_env) - config for non-interactive *and* interactive instances
    * [`.shared_rc`](https://github.com/aspiers/shell-env/blob/master/.shared_rc) - config for interactive instances only

* Mechanism for automatically switching between shells. <br/>
  Useful for when you do not have root privileges and want to run a
  locally compiled version of `zsh` rather than a system-wide shell.
  See:
    * [`.switch_shell`](https://github.com/aspiers/shell-env/blob/master/.switch_shell)
    * [`.ns`](https://github.com/aspiers/shell-env/blob/master/.ns)

* Perl library [`lib/perl5/Sh.pm`](https://github.com/aspiers/shell-env/blob/master/lib/perl5/Sh.pm) providing some handy native Perl
  replacements for shell-like operations.

* Hook-runner mechanism for building composite configuration out of
  multiple files in a [`foo.d/`](https://github.com/aspiers/shell-env/tree/master/foo.d/) hierarchy.  For more information see:
    * [`doc/ConfigHooks.org`](https://github.com/aspiers/shell-env/blob/master/doc/ConfigHooks.org)
    * [`.zsh/functions/find_hooks`](https://github.com/aspiers/shell-env/blob/master/.zsh/functions/find_hooks) - find applicable hook files 
      underneath [`foo.d/`](https://github.com/aspiers/shell-env/tree/master/foo.d/) hierarchy
    * [`.zsh/functions/run_hooks`](https://github.com/aspiers/shell-env/blob/master/.zsh/functions/run_hooks) - run hook files found by [`find_hooks`](https://github.com/aspiers/shell-env/blob/master/find_hooks), 
      assuming that they contain shell code
    * [`lib/libhooks.sh`](https://github.com/aspiers/shell-env/blob/master/lib/libhooks.sh) - concatenate hook files found by [`find_hooks`](https://github.com/aspiers/shell-env/blob/master/find_hooks) into 
      a single configuration file which can then be consumed by an external
      program such as `ssh`, `mutt`, `crontab` etc.

* Configuration files for various commonly used UNIX utilities and libraries:
    * `less`
    * `rsync`
    * `ls`
    * `readline`

* Useful utility and wrapper scripts under [`bin/`](https://github.com/aspiers/shell-env/tree/master/bin/):
    * [`AC-online`](https://github.com/aspiers/shell-env/blob/master/bin/AC-online) - Determine if we are running off battery.
    * [`AC-state`](https://github.com/aspiers/shell-env/blob/master/bin/AC-state) - Determine AC power adapter state.
    * [`abs`](https://github.com/aspiers/shell-env/blob/master/bin/abs) - Convert a relative path to absolute path(s) with 
      all symlinks resolved.
    * [`active-since`](https://github.com/aspiers/shell-env/blob/master/bin/active-since) - Determine whether I've touched the keyboard
      since a given time.
    * [`age-of`](https://github.com/aspiers/shell-env/blob/master/bin/age-of) - Show the age in seconds of a running or completed
      command run under the [`age-track`](https://github.com/aspiers/shell-env/blob/master/bin/age-track) wrapper.
    * [`age-track`](https://github.com/aspiers/shell-env/blob/master/bin/age-track) - Track the start and end times of a command, ensuring
      against concurrent invocations.  Useful as a helper for asynchronous
      process invocations.
    * [`alertme`](https://github.com/aspiers/shell-env/blob/master/bin/alertme) - Poor man's attention grabber.
    * [`beep`](https://github.com/aspiers/shell-env/blob/master/bin/beep) - Make some kind of noise reliably.
    * [`bip`](https://github.com/aspiers/shell-env/blob/master/bin/bip) - Wrapper around [`play`](http://sox.sourceforge.net/sox.html) to generate a sine wave of a given frequency / duration / volume.
    * [`bsplit`](https://github.com/aspiers/shell-env/blob/master/bin/bsplit) - Split a file or STDIN into buckets.
    * [`c3`](https://github.com/aspiers/shell-env/blob/master/bin/c3) - Show 3 months of the calendar.
    * [`cg`](https://github.com/aspiers/shell-env/blob/master/bin/cg) - Shortcut for `chgrp`.
    * [`clip`](https://github.com/aspiers/shell-env/blob/master/bin/clip) - Copy a symLink In Place - converts a symlink to a real file.
      Suspiciously similar to [`harden-ln`](https://github.com/aspiers/shell-env/blob/master/bin/harden-ln) (below).
    * [`cm`](https://github.com/aspiers/shell-env/blob/master/bin/cm) - Shortcut which allows you to omit `chmod` from
      typical `chmod 775 foo` command lines.
    * [`colour-diff-output`](https://github.com/aspiers/shell-env/blob/master/bin/colour-diff-output) - Colour-codes `diff` output (see [`dl`](https://github.com/aspiers/shell-env/blob/master/bin/dl) below)
    * [`count-dirents`](https://github.com/aspiers/shell-env/blob/master/bin/count-dirents) - Count the number of files in a bunch of directories.
    * [`cp-merge`](https://github.com/aspiers/shell-env/blob/master/bin/cp-merge) - Copies the entire contents of one directory to another,
      even if some subdirectories are common to both source and destination
      directories.  See also [`mv-merge`](https://github.com/aspiers/shell-env/blob/master/bin/mv-merge).
    * [`crypt`](https://github.com/aspiers/shell-env/blob/master/bin/crypt) - Generate a hashed password.
    * [`csort`](https://github.com/aspiers/shell-env/blob/master/bin/csort) - `sort(1)` helper which allows custom sort orders based on string/regexp matching
    * [`cy`](https://github.com/aspiers/shell-env/blob/master/bin/cy) - Show a whole calendar year.
    * [`dbm`](https://github.com/aspiers/shell-env/blob/master/bin/dbm) - [Simple DBM file reader/writer](http://adamspiers.org/computing/dbm/)
    * [`dfh`](https://github.com/aspiers/shell-env/blob/master/bin/dfh) - `df -h` wrapper
    * [`dfl`](https://github.com/aspiers/shell-env/blob/master/bin/dfl) - alternative `df` wrapper
    * [`dfll`](https://github.com/aspiers/shell-env/blob/master/bin/dfll) - to [`dfl`](https://github.com/aspiers/shell-env/blob/master/bin/dfl) what `ls -l` is to `ls -lh`
    * [`diff-inodes`](https://github.com/aspiers/shell-env/blob/master/bin/diff-inodes) - Compares output of [`dump-inodes`](https://github.com/aspiers/shell-env/blob/master/bin/dump-inodes) (below) with
      inode details in another tree.
    * [`diff-less`](https://github.com/aspiers/shell-env/blob/master/bin/diff-less) - Wrapper around `less` for viewing output from
      [`colour-diff-output`](https://github.com/aspiers/shell-env/blob/master/bin/colour-diff-output).  Used by [`tty-colour-diff`](https://github.com/aspiers/shell-env/blob/master/bin/tty-colour-diff).
    * [`div`](https://github.com/aspiers/shell-env/blob/master/bin/div) - Echo a highly visible divider.
    * [`dl`](https://github.com/aspiers/shell-env/blob/master/bin/dl) - `diff` wrapper.
    * [`dts`](https://github.com/aspiers/shell-env/blob/master/bin/dts) - Runs a command, date/time-stamping each line of STDOUT.
    * [`du1`](https://github.com/aspiers/shell-env/blob/master/bin/du1) - Run `du` with maximum depth 1
    * [`du2`](https://github.com/aspiers/shell-env/blob/master/bin/du2) - Run `du` with maximum depth 2
    * [`dump-inodes`](https://github.com/aspiers/shell-env/blob/master/bin/dump-inodes) - Dump machine-readable inode meta-data via `find` for
      use with [`diff-inodes`](https://github.com/aspiers/shell-env/blob/master/bin/diff-inodes).
    * [`dutree`](https://github.com/aspiers/shell-env/blob/master/bin/dutree) - Print sorted indented rendition of du output.
    * [`dwatch`](https://github.com/aspiers/shell-env/blob/master/bin/dwatch) - Simple monitor to watch for when things change.
    * [`edate`](https://github.com/aspiers/shell-env/blob/master/bin/edate) - Show seconds since UNIX epoch.
    * [`fbig`](https://github.com/aspiers/shell-env/blob/master/bin/fbig) - Find big files.
    * [`fds`](https://github.com/aspiers/shell-env/blob/master/bin/fds) - Shortcut to [`file-datestamp`](https://github.com/aspiers/shell-env/blob/master/bin/file-datestamp) (below).
    * [`feed`](https://github.com/aspiers/shell-env/blob/master/bin/feed) - Feed keystrokes to a command then interact with it as normal.
      Requires Perl's `Expect` module.
    * [`file-datestamp`](https://github.com/aspiers/shell-env/blob/master/bin/file-datestamp) - Produce a date-stamp suitable for use within filenames.
    * [`find-wan-gateway`](https://github.com/aspiers/shell-env/blob/master/bin/find-wan-gateway) - Find upstream WAN's gateway.  See also [`pingwan`](https://github.com/aspiers/shell-env/blob/master/bin/pingwan).
    * [`fs-monitor`](https://github.com/aspiers/shell-env/blob/master/bin/fs-monitor) - Poll a filesystem via `df`.
    * [`fswap`](https://github.com/aspiers/shell-env/blob/master/bin/fswap) - Swap the names/contents of two files.
    * [`ftrace`](https://github.com/aspiers/shell-env/blob/master/bin/ftrace) - Shortcut for `strace -e trace=file`.
    * [`glob-to-re`](https://github.com/aspiers/shell-env/blob/master/bin/glob-to-re) - Filter to convert globs into regexps.
    * [`grep-shortcuts`](https://github.com/aspiers/shell-env/blob/master/bin/grep-shortcuts) - Provide handy egrep shortcuts, e.g. `gilr` is
      equivalent to `egrep -i -l -r`
    * [`gw-dev`](https://github.com/aspiers/shell-env/blob/master/bin/gw-dev) - Detect the default gateway's network interface.
    * [`gw-dev-IP`](https://github.com/aspiers/shell-env/blob/master/bin/gw-dev-IP) - Detect the IP of the default gateway's network interface.
    * [`harden-ln`](https://github.com/aspiers/shell-env/blob/master/bin/harden-ln) - Suspiciously similar to [`clip`](https://github.com/aspiers/shell-env/blob/master/bin/clip) (above).
    * [`hex`](https://github.com/aspiers/shell-env/blob/master/bin/hex) - Convert numbers to hexadecimal.
    * [`ifw`](https://github.com/aspiers/shell-env/blob/master/bin/ifw) - Show a concise summary of network interface information.
    * [`isup`](https://github.com/aspiers/shell-env/blob/master/bin/isup) - Check whether a machine is pingable.
    * [`keepalive`](https://github.com/aspiers/shell-env/blob/master/bin/keepalive) - Keep an ssh session alive (for port forwarding) via `Expect.pm`.
    * [`keymap-menu`](https://github.com/aspiers/shell-env/blob/master/bin/keymap-menu) - OOB mechanism for switching between keyboard layouts.
    * [`lesspipe.sh`](https://github.com/aspiers/shell-env/blob/master/bin/lesspipe.sh) - My personal `$LESSOPEN` filter.
    * [`lh`](https://github.com/aspiers/shell-env/blob/master/bin/lh) - View recent logins.
    * [`logseek`](https://github.com/aspiers/shell-env/blob/master/bin/logseek) - Jump to a date/time within a large log file.
    * [`lsofp`](https://github.com/aspiers/shell-env/blob/master/bin/lsofp) - Run `lsof` by pid or command.
    * [`md5`](https://github.com/aspiers/shell-env/blob/master/bin/md5) - `md5sum` wrapper.
    * [`mnt-image`](https://github.com/aspiers/shell-env/blob/master/bin/mnt-image) - Mount a file containing a filesystem via loopback.
    * [`mnt-initrd`](https://github.com/aspiers/shell-env/blob/master/bin/mnt-initrd) - Mount a Linux initial ram disk image via loopback.
    * [`mnt-isos`](https://github.com/aspiers/shell-env/blob/master/bin/mnt-isos) - Mount ISOs in `/mnt` via loopback.
    * [`mnx`](https://github.com/aspiers/shell-env/blob/master/bin/mnx) - Make file(s) non-executable.
    * [`mnp`](https://github.com/aspiers/shell-env/blob/master/bin/mnp) - Make file(s) non-public.
    * [`mp`](https://github.com/aspiers/shell-env/blob/master/bin/mp) - Make file(s) public.
    * [`multi-syphon`](https://github.com/aspiers/shell-env/blob/master/bin/multi-syphon) - 
      Wrapper around `[syphon](https://github.com/aspiers/shell-env/blob/master/bin/syphon) -i` (see below).
    * [`mv-merge`](https://github.com/aspiers/shell-env/blob/master/bin/mv-merge) - Moves the entire contents of one directory to another, even
      if some subdirectories are common to both source and destination directories.
      See [`cp-merge`](https://github.com/aspiers/shell-env/blob/master/bin/cp-merge) and [`rm-src-dups`](https://github.com/aspiers/shell-env/blob/master/bin/rm-src-dups).
    * [`mvi`](https://github.com/aspiers/shell-env/blob/master/bin/mvi) - `mv -i` shortcut.
    * [`mx`](https://github.com/aspiers/shell-env/blob/master/bin/mx) - Make file(s) executable.
    * [`newer`](https://github.com/aspiers/shell-env/blob/master/bin/newer) - Returns true if a file is newer than the given age.
    * [`nth`](https://github.com/aspiers/shell-env/blob/master/bin/nth) - Return the nth line of file(s).
    * [`ntrace`](https://github.com/aspiers/shell-env/blob/master/bin/ntrace) - Shortcut for `strace -e trace=network`.
    * [`ord`](https://github.com/aspiers/shell-env/blob/master/bin/ord) - Show decimal/octal/hex values of ASCII characters.
    * [`ox`](https://github.com/aspiers/shell-env/blob/master/bin/ox) - `objdump -x` shortcut.
    * [`pdf`](https://github.com/aspiers/shell-env/blob/master/bin/pdf) - Find a preferred PDF viewer and run it.
    * [`phup`](https://github.com/aspiers/shell-env/blob/master/bin/phup) - `pkill -HUP` shortcut.
    * [`bping`](https://github.com/aspiers/shell-env/blob/master/bin/bping) - Wrapper around ping to make it do a lot of beeping ;-)  Pitch of beeps represents latency: concert A (440Hz) for 10ms, going one octave up or down for every order of magnitude.
    * [`pinggw`](https://github.com/aspiers/shell-env/blob/master/bin/pinggw) - Ping the gateway.
    * [`pingns`](https://github.com/aspiers/shell-env/blob/master/bin/pingns) - Ping a nameserver.
    * [`pingwan`](https://github.com/aspiers/shell-env/blob/master/bin/pingwan) - Ping the WAN gateway found by [`find-wan-gateway`](https://github.com/aspiers/shell-env/blob/master/bin/find-wan-gateway).
    * [`protect`](https://github.com/aspiers/shell-env/blob/master/bin/protect) - UNFINISHED: make a process hard to kill
    * [`pst`](https://github.com/aspiers/shell-env/blob/master/bin/pst) - `pstree` wrapper.
    * [`pstt`](https://github.com/aspiers/shell-env/blob/master/bin/pstt) - Another `pstree` wrapper.
    * [`quietrun`](https://github.com/aspiers/shell-env/blob/master/bin/quietrun) - Run a command and only allow output if the exit code
      didn't reflect success.  Useful when writing crontab files, so that
      you only get e-mailed when something goes wrong.
    * [`ra`](https://github.com/aspiers/shell-env/blob/master/bin/ra) - List unusual processes.
    * [`ra.pats`](https://github.com/aspiers/shell-env/blob/master/bin/ra.pats) - Data file for `ra` containing patterns matching "usual" processes.
    * [`ran`](https://github.com/aspiers/shell-env/blob/master/bin/ran) - Advanced replacement for `seq`.
    * [`rcslocks`](https://github.com/aspiers/shell-env/blob/master/bin/rcslocks) - Check RCS-controlled files for locks, and optionally nag the
      lock owners via e-mail.
    * [`resolver-domain`](https://github.com/aspiers/shell-env/blob/master/bin/resolver-domain) - Extract the resolver domain name from `resolv.conf`.
    * [`rj`](https://github.com/aspiers/shell-env/blob/master/bin/rj) - `ps` wrapper which searches for specific processes.
      (Its etymology was forgotten long ago...)
    * [`rjd`](https://github.com/aspiers/shell-env/blob/master/bin/rjd) - Search for processes in `D` (non-interruptible) state (Linux-only).
    * [`rjr`](https://github.com/aspiers/shell-env/blob/master/bin/rjr) - Another `ps` wrapper.
    * [`rm-src-dups`](https://github.com/aspiers/shell-env/blob/master/bin/rm-src-dups) - Remove duplicate files from a mirrored directory hierarchy.
    * [`root-zsh`](https://github.com/aspiers/shell-env/blob/master/bin/root-zsh) - [OLD] `expect` script for logging in as root and then loading
      my shell config.
    * [`rot13`](https://github.com/aspiers/shell-env/blob/master/bin/rot13) - [ROT13](http://en.wikipedia.org/wiki/ROT13) filter
    * [`rotate`](https://github.com/aspiers/shell-env/blob/master/bin/rotate) - Losslessly rotate JPEGs.
    * [`rpath`](https://github.com/aspiers/shell-env/blob/master/bin/rpath) - Extract RPATH from object files.
    * [`safe-pipe`](https://github.com/aspiers/shell-env/blob/master/bin/safe-pipe) - Pipe through a command with fallback.
    * [`service-commands`](https://github.com/aspiers/shell-env/blob/master/bin/service-commands) - Shortcuts for starting/stopping/restarting Linux
      system services.
    * [`sfind`](https://github.com/aspiers/shell-env/blob/master/bin/sfind) - Find source files or links, using [`so`](https://github.com/aspiers/shell-env/blob/master/bin/so) (below).
    * [`show-colours`](https://github.com/aspiers/shell-env/blob/master/bin/show-colours) - Show all ANSI 3-bit console colours (foreground and background).
    * [`shuffle`](https://github.com/aspiers/shell-env/blob/master/bin/shuffle) - Fisher-Yates shuffle lines from STDIN.
    * [`so`](https://github.com/aspiers/shell-env/blob/master/bin/so) - Prune a list of files using `~/.cvsignore`.
    * [`sort-by-filename`](https://github.com/aspiers/shell-env/blob/master/bin/sort-by-filename) - Sort list of newline-separated paths by basename
      (filename ignoring path segments).
    * [`sparse`](https://github.com/aspiers/shell-env/blob/master/bin/sparse) - Show sparseness of files.
    * [`split-by-boot`](https://github.com/aspiers/shell-env/blob/master/bin/split-by-boot) - Split syslog messages from STDIN into a new file per system boot.
    * [`syphon`](https://github.com/aspiers/shell-env/blob/master/bin/syphon) - Removes lines from top of a file based on pattern matching.
    * [`tailfgrep`](https://github.com/aspiers/shell-env/blob/master/bin/tailfgrep) - Monitor a file à la `tail -f`, looking for a given regexp.
    * [`tf`](https://github.com/aspiers/shell-env/blob/master/bin/tf) - `tail -f` shortcut.  When only tailing a single file, uses
      `less +F` which is nicer.
    * [`tfs`](https://github.com/aspiers/shell-env/blob/master/bin/tfs) - Similar to [`tf`](https://github.com/aspiers/shell-env/blob/master/bin/tf) but truncates long lines.
    * [`timeout`](https://github.com/aspiers/shell-env/blob/master/bin/timeout) - Run a command with a timeout.
    * [`tre`](https://github.com/aspiers/shell-env/blob/master/bin/tre) - `tree -C` shortcut.
    * [`trim-lines`](https://github.com/aspiers/shell-env/blob/master/bin/trim-lines) - Truncate long lines of STDIN, taking non-printing escape
      sequences (e.g. colour) into account.
    * [`trim-whitespace`](https://github.com/aspiers/shell-env/blob/master/bin/trim-whitespace) - Trim leading/trailing whitespace from STDIN.
    * [`tty-colour-diff`](https://github.com/aspiers/shell-env/blob/master/bin/tty-colour-diff) - Filter for viewing diff output.  If connected to
      a tty, provides glorious technicolour and paging via [`diff-less`](https://github.com/aspiers/shell-env/blob/master/bin/diff-less).
    * [`udate`](https://github.com/aspiers/shell-env/blob/master/bin/udate) - Show human-readable version of UNIX epoch time.
    * [`uidle`](https://github.com/aspiers/shell-env/blob/master/bin/uidle) - Finds the session with the smallest idle time corresponding to
      the specified user and by default outputs the number of seconds idle.
    * [`umnt-initrd`](https://github.com/aspiers/shell-env/blob/master/bin/umnt-initrd) - Unmounts an initrd image mounted via [`mnt-initrd`](https://github.com/aspiers/shell-env/blob/master/bin/mnt-initrd),
      generating a new initrd file.
    * [`un`](https://github.com/aspiers/shell-env/blob/master/bin/un) - `uname -a` shortcut.
    * [`unpack`](https://github.com/aspiers/shell-env/blob/master/bin/unpack) - Safely unpack an archive file.  Supports multiple formats.
    * [`up-since`](https://github.com/aspiers/shell-env/blob/master/bin/up-since) - Show when the system was last booted.
    * [`url-handler`](https://github.com/aspiers/shell-env/blob/master/bin/url-handler) - Handler for opening various types of URLs
    * [`viz`](https://github.com/aspiers/shell-env/blob/master/bin/viz) - Customisable change-control wrapper around an editor - a bit like
      `vipw`, `vigr`, `visudo` etc. but with validation mechanism implemented
      by the user.
    * [`waitpid`](https://github.com/aspiers/shell-env/blob/master/bin/waitpid) - Wait for a PID to finish.
    * [`waitproc`](https://github.com/aspiers/shell-env/blob/master/bin/waitproc) - Wait for a command to finish (uses [`waitpid`](https://github.com/aspiers/shell-env/blob/master/bin/waitpid)).
    * [`watchdiff`](https://github.com/aspiers/shell-env/blob/master/bin/watchdiff) - Like `watch`, but output in diff format
    * [`wchan`](https://github.com/aspiers/shell-env/blob/master/bin/wchan) - `ps -O wchan` shortcut.
    * [`wget-monitor`](https://github.com/aspiers/shell-env/blob/master/bin/wget-monitor) - Simple URL monitor.
    * [`whenup`](https://github.com/aspiers/shell-env/blob/master/bin/whenup) - Wait for a host to become pingable and then alert or take some action.
    * [`wl`](https://github.com/aspiers/shell-env/blob/master/bin/wl) - Show the contents of an executable script on `$PATH`.
    * [`xauth-user`](https://github.com/aspiers/shell-env/blob/master/bin/xauth-user) - Give another user access to this `$DISPLAY` via `xauth`.
    * [`zipseqs`](https://github.com/aspiers/shell-env/blob/master/bin/zipseqs) - Take two or more sequences and 'zip' them together
      (in the functional programming sense).

## <a name="install">INSTALLATION</a>

This repository is designed to be [stowed](http://www.gnu.org/software/stow/)
directly into your home directory:

    git clone git://github.com/aspiers/shell-env.git
    stow -d . -t ~ shell-env

However if you only want to cherry-pick bits and pieces then you can
easily just copy or symlink them in manually.  Just be aware that some
of the files depend on other files, especially the shell configuration
files.

## LICENSE

The software in this repository is free software: except where noted
otherwise, you can redistribute it and/or modify it under the terms of
the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any
later version.

This software is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
