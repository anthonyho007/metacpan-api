package MetaCPAN::Plack::Dependency;
use base 'MetaCPAN::Plack::Base';
use strict;
use warnings;
use MetaCPAN::Util;

sub index { 'dependency' }

sub get_source {
    my ( $self, $env ) = @_;
    my ( $index, @args ) = split( "/", $env->{PATH_INFO} );
    my $digest;
    if ( $args[0] =~ /^[A-Za-z0-9-_]{27}$/ ) {
        $digest = $args[0];
    } else {
        $digest = MetaCPAN::Util::digest( @args );
    }
    $env->{PATH_INFO} = join("/", $index, $digest );
    $self->next::method($env);
}

sub handle {
    my ( $self, $env ) = @_;
    $self->get_source($env);
}

1;