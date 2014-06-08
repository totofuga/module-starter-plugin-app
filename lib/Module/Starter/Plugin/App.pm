package Module::Starter::Plugin::App;

use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::Command qw( rm_rf mkpath touch );

=head1 NAME

Module::Starter::Plugin::App - The great new Module::Starter::Plugin::App!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Module::Starter::Plugin::App;

    my $foo = Module::Starter::Plugin::App->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 create_basedir

=cut

sub create_basedir {
    my $either = shift;

    $either->SUPER::create_basedir(@_);

    $either->create_script();
}

=head2 create_script

=cut

sub create_script {
    my $self = shift;

    my %script_files = $self->script_guts();

    while ( my ($file_name, $content) = each %script_files ) {
        $self->_create_script($file_name, $content);
    }
}

sub _create_script {
    my $self = shift;
    my $filename = shift;
    my $content = shift;

    my @dirparts= ( $self->{basedir}, 'script' );
    my $scriptdir = File::Spec->catdir(@dirparts);

    if ( not -d $scriptdir ) {
        local @ARGV = $scriptdir;
        mkpath();
        $self->progress( "Create $scriptdir" );
    }

    my $fname = File::Spec->catfile( @dirparts, $filename );
    $self->SUPER::create_file( $fname, $content );
    $self->SUPER::progress( "Created $fname" );

    return "script/$filename";

}

sub script_guts {
    my $self = shift;

    my $file_name = $self->{distro}. '.pl';
    my $content = <<"HERE";
use strict;
use warnings;
use $self->{main_module};

use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);

# set default value
my \%opt = ();

GetOptions(
    \\\%opt,
#    foo=i,
) or pod2usage(1);

# required options
my \@required_options = ();
pod2usage(2) if grep { ! exists \$opt{\$_} } \@required_options;

$self->{main_module}\->run(\%opt);
HERE

    return ( $file_name => $content );

}

=head1 AUTHOR

fujia.y, C<< <fujita.yoshihiko at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-module-starter-plugin-app at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=module-starter-plugin-app>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Module::Starter::Plugin::App


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=module-starter-plugin-app>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/module-starter-plugin-app>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/module-starter-plugin-app>

=item * Search CPAN

L<http://search.cpan.org/dist/module-starter-plugin-app/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 fujia.y.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Module::Starter::Plugin::App
