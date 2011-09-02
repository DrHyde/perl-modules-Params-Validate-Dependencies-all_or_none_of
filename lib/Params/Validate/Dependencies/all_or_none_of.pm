package Params::Validate::Dependencies::all_or_none_of;

use strict;
use warnings;

use base qw(Exporter Params::Validate::Dependencies::Documenter);

use vars qw($VERSION @EXPORT @EXPORT_OK);

$VERSION = '1.0';
@EXPORT_OK = @EXPORT = ('all_or_none_of');

=head1 NAME

Params::Validate::Dependencies::all_or_none_of

=head1 DESCRIPTION

An extension for Params::Validate::Dependencies to validate that either
all of or none of a list of params are present.

=head1 SYNOPSIS

In this example, the 'foo' function takes named arguments, of which
the 'day', 'month', and 'year' args must either all be present or
none of them be present.

  use Params::Validate::Dependencies qw(:all);
  use Params::Validate::Dependencies::all_or_none_of;

  sub foo {
    validate(@_,
      { ... normal Params::Validate stuff ...},
      all_or_none_of(qw(day month year))
    );
  }

=head1 SUBROUTINES and EXPORTS

=head2 all_or_none_of

This is exported by default.  It takes a list of scalars and code-refs
and returns a code-ref which checks that the hashref it receives matches
either all or none of the options given.

=cut

sub all_or_none_of {
  my @options = @_;
  return bless sub {
    my $hashref = shift;
    if($Params::Validate::Dependencies::DOC) {
      return $Params::Validate::Dependencies::DOC->_doc_me(list => \@options);
    }
    my $count = 0;
    foreach my $option (@options) {
      $count++ if(
        !ref($option && exists($hashref->{$option})) ||
        (ref($option) && $option->($hashref))
      );
    }
    return ($count == 0 || $count == $#options + 1);
  }, __PACKAGE__;
}

sub join_with { return 'or'; }
sub name      { return 'all_or_none_of'; }
