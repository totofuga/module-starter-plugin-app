#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Module::Starter::Plugin::App' ) || print "Bail out!\n";
}

diag( "Testing Module::Starter::Plugin::App $Module::Starter::Plugin::App::VERSION, Perl $], $^X" );
