# Adam's .bashrc
# for those shitty times when zsh isn't to hand
#
# $Id$

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# no crappy RedHat inputrcs, thankyouverymuch.  Which fucking *idiot*
# set convert-meta to off?
unset INPUTRC

function cvst {
    perl -MGetopt::Std -wl -- - $* <<'End_of_Perl'
        $dir = '';
#       print "args: @ARGV";
        getopts('av', \%opts);
#       print "showing all" if $opts{'a'};
#       print "showing revisions" if $opts{'v'};
        open(CVS, "cvs status @ARGV 2>&1 |") or die "cvs status failed: $!\n";
        open(STDERR, ">&STDOUT") or die "Can't dup stdout";
        while (<CVS>) {
          chomp;
          if (/cvs status: Examining (.*)/) {
            $dir = "$1/";
          } elsif (/^File:\s+(.*)\s+Status:\s+(.*)/) {
            ($file, $status) = ($1, $2);
            next if ($status eq 'Up-to-date' && ! $opts{'a'});
            $str = "File: $dir$file";
            print $str, ' ' x (45 - length($str)), "Status: $status";
          } elsif (/revision/ && $opts{'v'}) {
            next if ($status eq 'Up-to-date' && ! $opts{'a'});
            print;
          } elsif (/^cvs status:/) {
            print;
          }
        }
        close(CVS);
End_of_Perl
}

. ~/.switch_shell
