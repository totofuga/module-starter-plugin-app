use 5.006;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'module-starter-plugin-app';
all_from 'lib/Module/Starter/Plugin/App.pm';
author   q{fujia.y <fujita.yoshihiko@gmail.com>};
license  'artistic2';

perl_version 5.006;

tests_recursive('t');

resources (
   #homepage   => 'http://yourwebsitehere.com',
   #IRC        => 'irc://irc.perl.org/#module-starter-plugin-app',
   license    => 'http://www.perlfoundation.org/artistic_license_2_0',
   #repository => 'git://github.com/fujia.y/module-starter-plugin-app.git',
   bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=module-starter-plugin-app',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
   #'ABC'              => 1.6,
   #'Foo::Bar::Module' => 5.0401,
);

install_as_cpan;
auto_install;
WriteAll;
