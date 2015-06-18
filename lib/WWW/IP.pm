use strict;
use warnings;
package WWW::IP;

use HTTP::Tiny;
use 5.008;
use WWW::hmaip ();
use WWW::PerlTricksIP ();
use WWW::ipinfo ();
use Try::Tiny;

# ABSTRACT: Returns your ip address with failsafe mechanism

=head1 SYNOPSIS

    use WWW::IP;

    my $ip = get_ip(); # 54.123.84.6

=head1 EXPORTS

Exports the C<get_ip> function.

=cut

BEGIN {
    require Exporter;
    use base 'Exporter';
    our @EXPORT = 'get_ip';
    our @EXPORT_OK = ();
}

=head1 FUNCTIONS

=head2 get_ip

Returns your ip address. Will try a number of services in succession should the 

    use WWW::IP;

    my $ip = get_ip();

=cut

sub get_ip {
  try {
    WWW::hmaip::get_ip();
  } catch {
    try {
      WWW::ipinfo::get_ipinfo->{ip};
    } catch {
      try {
        WWW::PerlTricksIP::get_ip();
      }
      catch {
        die $_;
      }
    }
  };
}

=head1 SEE ALSO

These modules are used by WWW::IP:

=over

=item *

L<WWW::ipinfo> - a module that returns ip address and geolocation data

=item *

L<WWW::hmaip> - another module that returns your ip address

=item *

L<WWW::PerlTricksIP> - another module that returns your ip address

=back

=cut

1;
