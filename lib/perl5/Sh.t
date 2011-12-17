#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 9;

BEGIN { use_ok('Sh', qw(abs_path_by_chdir abs_path_by_chasing)) }

diag("Sh loaded from $INC{'Sh.pm'}");

my @expected = (
  '/'                        => '/',
  '//'                       => '/',
  '/tmp'                     => '/tmp',
  '/nonexistent'             => '/nonexistent',
  '/tmp/..'                  => '/',
  '/var/adm'                 => '/var/adm',
  '/var/log/messages'        => '/var/log/messages',
  '/var/tmp/../log/messages' => '/var/log/messages',
  '/var/../tmp'              => '/tmp',
);

while (@expected) {
  my $input    = shift @expected;
  my $expected = shift @expected;

  is(abs_path_by_chdir($input),   $expected, "abs_path_by_chdir($input)");
  is(abs_path_by_chasing($input), $expected, "abs_path_by_chasing($input)");
}
