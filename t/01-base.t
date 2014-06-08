use strict;
use warnings;

use Test::More;
use File::Temp qw( tempdir );
use Path::Class;
use File::Spec;

BEGIN {
    use_ok("Module::Starter::Plugin::App");
}
use Module::Starter::Simple;


no strict "refs";
push @{"Module::Starter::Plugin::App::ISA"}, 'Module::Starter::Simple';

my $dir = tempdir();
my $target = new_ok("Module::Starter::Plugin::App", [
    'basedir' => $dir,
    'main_module' => 'Test::App',
    'distro' => 'test-app',
]);


$target->create_script();

my $script_file = file(File::Spec->catfile($dir, 'script', 'test-app.pl'));

my $cmp_file_data = do { local $/; <DATA> };
is($script_file->slurp(), $cmp_file_data);
print $dir;


done_testing();
__DATA__
use strict;
use warnings;
use Test::App;

use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);

# set default value
my %opt = ();

GetOptions(
    \%opt,
#    foo=i,
) or pod2usage(1);

# required options
my @required_options = ();
pod2usage(2) if grep { ! exists $opt{$_} } @required_options;

Test::App->run(%opt);
