# Adam's UNIX shell environment

This is my collection of UNIX shell configuration files and utilities.
These days I only use them with zsh and bash on Linux, but in the
past I also used them on various Solaris and FreeBSD machines, and
for the most part they should work on any POSIX-oriented UNIX.

## Contents

* Configuration files for zsh
    * `.zshrc` - config for interactive instances only
    * `.zshenv` - config for non-interactive *and* interactive instances
    * `.zsh/` hierarchy, including:
        * `.zsh/functions/` - various handy interactive and completion functions
        * `.zsh/accounts.d/` - for configuring completion of (user, host) pairs
        * `.zsh/users.d/` - for configuring completion of users

* Configuration files for bash
    * `.bashrc` - config for interactive instances only
    * `.bash_profile` - config for interactive "login shell" instances only
    * `.bashenv` - config for non-interactive *and* interactive instances

* Configuration files to be shared by any Bourne-compatible shell
    * `.shared_env` - config for non-interactive *and* interactive instances
    * `.shared_rc` - config for interactive instances only

* Mechanism for automatically switching between shells. <br/>
  Useful for when you do not have root privileges and want to run a
  locally compiled version of `zsh` rather than a system-wide shell.
  See:
    * `.switch_shell`
    * `.ns`

* Perl library `lib/perl5/Sh.pm` providing some handy native Perl
  replacements for shell-like operations.

* Hook-runner mechanism for building composite configuration out of
  multiple files in a `foo.d/` hierarchy.  For more information see:
    * `doc/ConfigHooks.org`
    * `.zsh/functions/find_hooks` - find applicable hook files 
      underneath `foo.d/` hierarchy
    * `.zsh/functions/run_hooks` - run hook files found by `find_hooks`, 
      assuming that they contain shell code
    * `lib/libhooks.sh` - concatenate hook files found by `find_hooks` into 
      a single configuration file which can then be consumed by an external
      program such as `ssh`, `mutt`, `crontab` etc.

* Configuration files for various commonly used UNIX utilities and libraries:
    * `less`
    * `rsync`
    * `ls`
    * `readline`

* Useful utility and wrapper scripts under `bin/`:
    * `AC-online` - Determine if we are running off battery.
    * `AC-state` - Determine AC power adapter state.
    * `abs` - Convert a relative path to absolute path(s) with 
      all symlinks resolved.
    * `active-since` - Determine whether I've touched the keyboard
      since a given time.
    * `age-of` - Show the age in seconds of a running or completed
      command run under the `age-track` wrapper.
    * `age-track` - Track the start and end times of a command, ensuring
      against concurrent invocations.  Useful as a helper for asynchronous
      process invocations.
    * `alertme` - Poor man's attention grabber.
    * `beep` - Make some kind of noise reliably.
    * `bsplit` - Split a file or STDIN into buckets.
    * `c3` - Show 3 months of the calendar.
    * `cg` - Shortcut for `chgrp`.
    * `clip` - Copy a symLink In Place - converts a symlink to a real file.
      Suspiciously similar to `harden-ln` (below).
    * `cm` - Shortcut for `cm` which allows you to omit `chmod` from
      typical `chmod 775 foo` command lines.
    * `colour-diff-output` - Colour-codes `diff` output (see `dl` below)
    * `count-dirents` - Count the number of files in a bunch of directories.
    * `cp-merge` - Copies the entire contents of one directory to another,
      even if some subdirectories are common to both source and destination
      directories.  See also `mv-merge`.
    * `crypt` - Generate a hashed password.
    * `cy` - Show a whole calendar year.
    * [`dbm` - Simple DBM file reader/writer](http://adamspiers.org/computing/dbm/)
    * `dfh` - `df -h` wrapper
    * `dfl` - alternative `df` wrapper
    * `dfll` - to `dfl` what `ls -l` is to `ls -lh`
    * `diff-inodes` - Compares output of `dump-inodes` (below) with
      inode details in another tree.
    * `diff-less` - Wrapper around `less` for viewing output from
      `colour-diff-output`.  Used by `tty-colour-diff`.
    * `div` - Echo a highly visible divider.
    * `dl` - `diff` wrapper.
    * `dts` - Runs a command, date/time-stamping each line of STDOUT.
    * `du1` - Run `du` with maximum depth 1
    * `du2` - Run `du` with maximum depth 2
    * `dump-inodes` - Dump machine-readable inode meta-data via `find` for
      use with `diff-inodes`.
    * `dutree` - Print sorted indented rendition of du output.
    * `dwatch` - Simple monitor to watch for when things change.
    * `edate` - Show seconds since UNIX epoch.
    * `fbig` - Find big files.
    * `fds` - Shortcut to `file-datestamp` (below).
    * `feed` - Feed keystrokes to a command then interact with it as normal.
      Requires Perl's `Expect` module.
    * `file-datestamp` - Produce a date-stamp suitable for use within filenames.
    * `find-wan-gateway` - Find upstream WAN's gateway.  See also `pingwan`.
    * `fs-monitor` - Poll a filesystem via `df`.
    * `fswap` - Swap the names/contents of two files.
    * `ftrace` - Shortcut for `strace -e trace=file`.
    * `glob-to-re` - Filter to convert globs into regexps.
    * `grep-shortcuts` - Provide handy egrep shortcuts, e.g. `gilr` is
      equivalent to `egrep -i -l -r`
    * `gw-dev` - Detect the default gateway's network interface.
    * `gw-dev-IP` - Detect the IP of the default gateway's network interface.
    * `harden-ln` - Suspiciously similar to `clip` (above).
    * `hex` - Convert numbers to hexadecimal.
    * `ifw` - Show a concise summary of network interface information.
    * `isup` - Check whether a machine is pingable.
    * `keepalive` - Keep an ssh session alive (for port forwarding) via `Expect.pm`.
    * `keymap-menu` - OOB mechanism for switching between keyboard layouts.
    * `lesspipe.sh` - My personal `$LESSOPEN` filter.
    * `lh` - View recent logins.
    * `logseek` - Jump to a date/time within a large log file.
    * `lsofp` - Run `lsof` by pid or command.
    * `md5` - `md5sum` wrapper.
    * `mnt-image` - Mount a file containing a filesystem via loopback.
    * `mnt-initrd` - Mount a Linux initial ram disk image via loopback.
    * `mnt-isos` - Mount ISOs in `/mnt` via loopback.
    * `mnx` - Make file(s) non-executable.
    * `mnp` - Make file(s) non-public.
    * `mp` - Make file(s) public.
    * `multi-syphon` - Wrapper around `syphon -i` (see below).
    * `mv-merge` - Moves the entire contents of one directory to another, even
      if some subdirectories are common to both source and destination directories.
      See `cp-merge` and `rm-src-dups`.
    * `mvi` - `mv -i` shortcut.
    * `mx` - Make file(s) executable.
    * `newer` - Returns true if a file is newer than the given age.
    * `nth` - Return the nth line of file(s).
    * `ntrace` - Shortcut for `strace -e trace=network`.
    * `ord` - Show decimal/octal/hex values of ASCII characters.
    * `ox` - `objdump -x` shortcut.
    * `pdf` - Find a preferred PDF viewer and run it.
    * `phup` - `pkill -HUP` shortcut.
    * `pinggw` - Ping the gateway.
    * `pingns` - Ping a nameserver.
    * `pingwan` - Ping the WAN gateway found by `find-wan-gateway`.
    * `protect` - UNFINISHED: make a process hard to kill
    * `pst` - `pstree` wrapper.
    * `pstt` - Another `pstree` wrapper.
    * `quietrun` - Run a command and only allow output if the exit code
      didn't reflect success.  Useful when writing crontab files, so that
      you only get e-mailed when something goes wrong.
    * `ra` - List unusual processes.
    * `ra.pats` - Data file for `ra` containing patterns matching "usual" processes.
    * `ran` - Advanced replacement for `seq`.
    * `rcslocks` - Check RCS-controlled files for locks, and optionally nag the
      lock owners via e-mail.
    * `resolver-domain` - Extract the resolver domain name from `resolv.conf`.
    * `rj` - `ps` wrapper which searches for specific processes.
      (Its etymology was forgotten long ago...)
    * `rjd` - Search for processes in `D` (non-interruptible) state (Linux-only).
    * `rjr` - Another `ps` wrapper.
    * `rm-src-dups` - Remove duplicate files from a mirrored directory hierarchy.
    * `root-zsh` - [OLD] `expect` script for logging in as root and then loading
      my shell config.
    * `rot13` - [ROT13](http://en.wikipedia.org/wiki/ROT13) filter
    * `rotate` - Losslessly rotate JPEGs.
    * `rpath` - Extract RPATH from object files.
    * `safe-pipe` - Pipe through a command with fallback.
    * `service-commands` - Shortcuts for starting/stopping/restarting Linux
      system services.
    * `sfind` - Find source files or links, using `so` (below).
    * `show-colours` - Show all ANSI 3-bit console colours (foreground and background).
    * `shuffle` - Fisher-Yates shuffle lines from STDIN.
    * `so` - Prune a list of files using `~/.cvsignore`.
    * `sort-by-filename` - Sort list of newline-separated paths by basename
      (filename ignoring path segments).
    * `sparse` - Show sparseness of files.
    * `split-by-boot` - Split syslog messages from STDIN into a new file per system boot.
    * `syphon` - Removes lines from top of a file based on pattern matching.
    * `tailfgrep` - Monitor a file à la `tail -f`, looking for a given regexp.
    * `tf` - `tail -f` shortcut.  When only tailing a single file, uses
      `less +F` which is nicer.
    * `tfs` - Similar to `tf` but truncates long lines.
    * `timeout` - Run a command with a timeout.
    * `tre` - `tree -C` shortcut.
    * `trim-lines` - Truncate long lines of STDIN, taking non-printing escape
      sequences (e.g. colour) into account.
    * `trim-whitespace` - Trim leading/trailing whitespace from STDIN.
    * `tty-colour-diff` - Filter for viewing diff output.  If connected to
      a tty, provides glorious technicolour and paging via `diff-less`.
    * `udate` - Show human-readable version of UNIX epoch time.
    * `uidle` - Finds the session with the smallest idle time corresponding to
      the specified user and by default outputs the number of seconds idle.
    * `umnt-initrd` - Unmounts an initrd image mounted via `mnt-initrd`,
      generating a new initrd file.
    * `un` - `uname -a` shortcut.
    * `up` - Safely unpack an archive file.  Supports multiple formats.
    * `up-since` - Show when the system was last booted.
    * `viz` - Customisable change-control wrapper around an editor - a bit like
      `vipw`, `vigr`, `visudo` etc. but with validation mechanism implemented
      by the user.
    * `waitpid` - Wait for a PID to finish.
    * `waitproc` - Wait for a command to finish (uses `waitpid`).
    * `watchdiff` - Like `watch`, but output in diff format
    * `wc-lots` - Apparently pointless rewrite of `wc -`
    * `wchan` - `ps -O wchan` shortcut.
    * `wget-monitor` - Simple URL monitor.
    * `whenup` - Wait for a host to become pingable and then alert or take some action.
    * `wl` - Show the contents of an executable script on `$PATH`.
    * `xauth-user` - Give another user access to this `$DISPLAY` via `xauth`.
    * `zipseqs` - Take two or more sequences and 'zip' them together
      (in the functional programming sense).
