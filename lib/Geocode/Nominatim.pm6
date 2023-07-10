use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use Geocode::Raw::Types;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use Geocode::Roles::Backend;

our subset GeocodeNominatimAncestry is export of Mu
  where GeocodeNominatim | GeocodeBackend | GObject;

class Geocode::Nominatim {
  also does Geocode::Roles::Backend;

  has GeocodeNominatim $!gn is implementor;

  submethod BUILD ( :$geocode-nominatim ) {
    self.setGeocodeNominatim($geocode-nominatim)
      if $geocode-nominatim
  }

  method setGeocodeNominatim (GeocodeNominatimAncestry $_) {
    my $to-parent;

    $!gn = do {
      when GeocodeNominatim {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GeocodeBackend {
        $to-parent = cast(GObject, $_);
        $!gb       = $_;
        cast(GeocodeNominatim, $_);
      }

      default {
        $to-parent = $_;
        cast(GeocodeNominatim, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GeocodeBackend;
  }

  method Geocode::Raw::Definitions::GeocodeNominatim
    is also<GeocodeNominatim>
  { $!gn }

  multi method new (
     $geocode-nominatim where * ~~ GeocodeNominatimAncestry,

    :$ref = True
  ) {
    return unless $geocode-nominatim;

    my $o = self.bless( :$geocode-nominatim );
    $o.ref if $ref;
    $o;
  }

  multi method new (Str() $base_url, Str() $maintainer_email_address) {
    my $geocode-nominatim = geocode_nominatim_new(
      $base_url,
      $maintainer_email_address
    );

    $geocode-nominatim ?? self.bless( :$geocode-nominatim ) !! Nil;
  }

  method get_gnome
    is also<
      get-gnome
      get_default
      get-default
      gnome
      default
    >
  {
    my $geocode-nominatim = geocode_nominatim_get_gnome();

    $geocode-nominatim ?? self.bless( :$geocode-nominatim ) !! Nil;
  }

  # Type: string
  method base-url is rw  is g-property is also<base_url> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('base-url', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('base-url', $gv);
      }
    );
  }

  # Type: string
  method maintainer-email-address
    is rw
    is g-property
    is also<maintainer_email_address>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('maintainer-email-address', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('maintainer-email-address', $gv);
      }
    );
  }

  # Type: string
  method user-agent is rw  is g-property is also<user_agent> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('user-agent', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('user-agent', $gv);
      }
    );
  }

}


### /usr/src/geocode-glib/geocode-glib/geocode-nominatim.h

sub geocode_nominatim_get_gnome
  returns GeocodeNominatim
  is      native(geocode)
  is      export
{ * }

sub geocode_nominatim_new (
  Str $base_url,
  Str $maintainer_email_address
)
  returns GeocodeNominatim
  is      native(geocode)
  is      export
{ * }
