package Sh;

=head1 NAME

Sh - Utility routines for common shell operations

=cut

use strict;
use warnings;

use Carp qw(carp cluck croak confess);
use Cwd;
use Digest::MD5;
use File::Basename;
use File::Path;
use File::Spec;

use base qw(Exporter);
our @EXPORT_OK = qw(
  get_absolute_path abs_path abs_path_by_chdir abs_path_by_chasing
  cat safe_cat read_lines_from_file write_to_file append_to_file remove_from_file
  grep_quiet line_count
  md5hex_file md5b64_file
  move_with_subpath move_with_common_subpath
  glob_to_unanchored_re glob_to_anchored_re glob_to_re
  safe_sys sys_or_warn sys_or_die
  ensure_correct_symlink qqexpand
  hostname
);

sub get_absolute_path {
  my ($file) = @_;

  # Strategy:
  # Use dirname/basename to split up $file into $dir and $file.
  # chdir to $dir.  If $file is a dir, chdir to that too.
  # Use getcwd() to determine where we are, and return result accordingly.

  my $dir = dirname($file);
  my $olddir = getcwd();
  chdir $dir or die "chdir($dir) failed: $!\n";
  $dir = getcwd();
  $file = basename($file);
  if (-d $file) {
    chdir $file or die "chdir($file) failed: $!\n";
    $dir = getcwd();
    return ($dir);
  }
  chdir $olddir or die "chdir($olddir) failed: $!\n";

  return ($dir, $file);
}

sub abs_path {
  &abs_path_by_chdir;
}

sub abs_path_by_chdir {
  return File::Spec->join(get_absolute_path(@_));
}

sub abs_path_by_chasing {
  my $path = shift;
  
  -d $path and return Cwd::abs_path($path);

  # If the path doesn't exist, or the EUID can't see it (e.g. parent
  # directory isn't executable for EUID) we can still try to resolve
  # symlinks in the path.

  my ($vol, $dir, $file) = File::Spec->splitpath($path);
  # Don't know how to handle volumes.
  die "$0: splitpath returned vol '$vol'\n" if $vol;

  my $abs = Cwd::abs_path($dir);
  unless (defined $abs) { 
    warn "Cwd::abs_path($dir) returned undef; does $dir exist?\n";
    return $dir;
  }

  # keep chasing links until we arrive at a non-link
  while (-l $path) {
    $path = File::Spec->rel2abs(readlink $path, $abs);
    $path = File::Spec->canonpath($path);
    1 while $path =~ s!/[^/]+/\.\./!/!g; # can't believe canonpath doesn't do this
    ($abs, $file) = $path =~ m!(.+)/(.+)!;
    $abs = Cwd::abs_path($abs);
  }

  return "$abs/$file";
}

sub cat {
  my ($file) = @_;
  my $text;
  open(FILE, "$file") or die "open($file) failed: $!\n";
  $text .= $_ while <FILE>;
  close(FILE);
  return $text;
}

sub safe_cat {
  my ($file) = @_;
  return '' unless -r $file;
  return cat($file);
}

sub read_lines_from_file {
  my ($file) = @_;
  open(FILE, "$file") or die "open($file) failed: $!\n";
  my @lines;
  while (<FILE>) {
    chomp;
    push @lines, $_;
  }
  close(FILE);
  return @lines;
}

sub write_to_file {
  my ($file, $text) = @_;
  open(FILE, ">$file") or die "open(>$file) failed: $!\n";
  print FILE $text;
  close(FILE);
}

sub append_to_file {
  my ($file, $text) = @_;
  open(FILE, ">>$file") or die "open(>>$file) failed: $!\n";
  print FILE $text;
  close(FILE);
}

sub remove_from_file {
  my ($file, $match) = @_;
  my $new = '';
  open(FILE, "+<$file") or die "open(+<$file) failed: $!\n";
  if (ref($match) eq 'Regexp') {
    while (<FILE>) {
      chomp;
      $new .= "$_\n" unless /$match/;
    }
  }
  else {
    while (<FILE>) {
      chomp;
      $new .= "$_\n" unless $_ eq $match;
    }
  }
  seek FILE, 0, 0;
  truncate FILE, 0;
  print FILE $new;
  close(FILE);
}

sub grep_quiet {
  my ($file, $line) = @_;
  
  return 0 unless -f $file;
  
  open(FILE, $file) or die "open($file) failed: $!\n";
  while (<FILE>) {
    chomp;
    if ($_ eq $line) {
      close(FILE);
      return 1;
    }
  }
  close(FILE);
  return 0;
}

sub line_count {
  my ($file) = @_;
  open(FILE, $file) or die "open(+<$file) failed: $!\n";
  my $count = 0;
  $count++ while <FILE>;
  close(FILE);
  return $count;
}

sub md5b64_file {
  my ($file) = @_;
  open(FILE, $file) or die "open($file) failed: $!\n";
  my $md5 = Digest::MD5->new->addfile(*FILE)->b64digest;
  close(FILE);
  return $md5;
}

sub md5hex_file {
  my ($file) = @_;
  open(FILE, $file) or die "open($file) failed: $!\n";
  my $md5 = Digest::MD5->new->addfile(*FILE)->hexdigest;
  close(FILE);
  return $md5;
}

=head2 move_with_subpath

e.g. moves foo/bar/src/1/2/3 to foo/bar/dst/1/2/3 even if
foo/bar/dst/1/2 didn't previously exist

=cut

sub move_with_subpath {
  my ($src_root, $dst_root, $subpath) = @_;

  my $src = File::Spec->join($src_root, $subpath);
  -e $src      or die "tried to move non-existent file $src!\n";
  -e $dst_root or die "tried to move $src to subdir of non-existent dir $dst_root!\n";
  my $dst = File::Spec->join($dst_root, $subpath);

  # Figure out directory which will contain $dst and ensure it exists.
  my @dirs = File::Spec->splitdir($subpath);
  my $file = pop @dirs;
  my $dir = File::Spec->join($dst_root, @dirs);
  unless (-d $dir) {
    mkpath $dir or die "mkdir($dir) failed: $!\n";
  }

  rename($src, $dst) or die "rename($src, $dst) failed: $!\n";
}

=head2 move_with_common_subpath

Same as C<move_with_subpath> but auto-figures out C<$subpath>.

=cut

sub move_with_common_subpath {
  my ($src, $dst) = @_;

  -e $src or die "tried to move non-existent file $src!\n";
  my @src = File::Spec->splitdir($src);
  my @dst = File::Spec->splitdir($dst);
  my ($suffix, $src_root, $dst_root) = _find_common_tail_elements(\@src, \@dst);
  
  # Figure out directory which will contain $dst and ensure it exists.
  my $file = pop @$suffix;
  my $dir = File::Spec->join(@$dst_root, @$suffix);
  unless (-d $dir) {
    mkpath $dir or die "mkdir($dir) failed: $!\n";
  }

  rename($src, $dst) or die "rename($src, $dst) failed: $!\n";
}

sub _find_common_tail_elements {
  my ($a, $b) = @_;
  my @a = @$a;
  my @b = @$b;
  my @common;
  while (@a and @b) {
    last if $a[-1] ne $b[-1];
    unshift @common, pop @a;
    pop @b;
  }
  return (\@common, \@a, \@b);
}

sub glob_to_unanchored_re {
  local $_ = shift;
  s/([.+{}^\$])/\\$1/g;
  s/\*/.*/g;
  s/\?/./g;
  return $_;
}

sub glob_to_anchored_re {
  local $_ = glob_to_unanchored_re(shift);
  s/^\.\*// or s/^/^/;
  s/\.\*$// or s/$/\$/;
  return $_;
}

# For backwards compatability
*glob_to_re = \&glob_to_anchored_re;

=head2 safe_sys

  safe_sys(
    cmd => 'date',
    # or an array ref
    cmd => [ 'date', '-d', 'tomorrow' ],

    msg => 'failure message', 

    # above message gets passed to failure call-back:
    fail => sub {
      my $msg = shift;
      # handle failure here
    }
  );

=cut

sub safe_sys {
  my %p = @_;
  my @cmd = ref($p{cmd}) eq 'ARRAY' ? @{ $p{cmd} } : ($p{cmd});
  confess "_safe_sys called without 'fail' coderef"
    unless ref($p{fail}) eq 'CODE';
  $p{msg} ||= "command @cmd failed; aborting.\n";
  system @cmd;
  my $exit = $? >> 8;
  $p{fail}->($p{msg}) if $exit != 0;
}

sub sys_or_warn {
  my ($cmd, $msg) = @_;
  confess "sys_or_warn API changed: 2nd argument needs to be a scalar"
    if ref $msg;
  safe_sys(
    cmd  => $cmd,
    msg  => $msg || undef,
    fail => sub { warn $_[0] },
  );
}

sub sys_or_die {
  my ($cmd, $msg) = @_;
  confess "sys_or_die API changed: 2nd argument needs to be a scalar"
    if ref $msg;
  safe_sys(
    cmd  => $cmd,
    msg  => $msg || undef,
    fail => sub { die $_[0] },
  );
}

sub ensure_correct_symlink {
  my %p = @_;
  confess "ensure_correct_symlink was not passed a symlink" unless $p{symlink};
  my $symlink = delete $p{symlink};
  confess "ensure_correct_symlink was not passed a required_target" unless $p{required_target};
  my $required_target = delete $p{required_target};
  confess "Superfluous parameters to ensure_correct_symlink: ", join(",", keys %p), "\n" if %p;
  
  if (! lstat $symlink) {
    symlink $required_target, $symlink
      or die "symlink($required_target, $symlink) failed: $!\n";
    return;
  }

  if (! -l $symlink) {
    die "$symlink already exists but is not a symlink; aborting!\n";
  }

  my $actual_target = readlink($symlink)
    or die "readlink($symlink) failed: $!";

  my ($a_dev, $a_ino) = stat($symlink); # stat automatically follows symlinks
  if (! $a_dev) {
    die "stat($symlink) failed ($!); dangling symlink? pointing to $actual_target\n";
  }

  my ($r_dev, $r_ino) = stat($required_target)
    or confess "stat($required_target) failed: $!";
  if ($a_dev != $r_dev or $a_ino != $r_ino) {
    die "$symlink already exists and points to $actual_target not $required_target; aborting!\n";
  }
}

=head2 qqexpand($text_with_escapes)

Replaces all escape codes (C<\n>, C<\e>, C<\x012> etc.) with the
characters they actually represent.

=cut

sub qqexpand {
  my ($text_with_escapes) = @_;
  $text_with_escapes =~ s!\\([efnrt]|x\d\d?|0\d{2,3})!qq["$&"]!gee;
  return $text_with_escapes;
}

=head2 hostname

Uses C<Net::Hostname> or C<Sys::Hostname> or C<hostname(1)> to get the
hostname.

=cut

sub hostname {
  eval { require Net::Hostname; };
  return Net::Hostname::hostname() if ! $@;

  eval { require Sys::Hostname; };
  return Sys::Hostname::hostname() if ! $@;

  return `hostname`;
}

=head1 BUGS

C<grep_quiet> doesn't take regexps.

=cut

1;
