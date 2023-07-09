use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use Geocode::Raw::Types;
use Geocode::Raw::Location;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GeocodeLocationAncestry is export of Mu
  where GeocodeLocation | GObject;

class Geocode::Location {
  also does GLib::Roles::Object;
  
  has GeocodeLocation $!gl is implementor;

  submethod BUILD ( :$geocode-location ) {
    self.setGeocodeLocation($geocode-location) if $geocode-location
  }

  method setGeocodeLocation (GeocodeLocationAncestry $_) {
    my $to-parent;

    $!gl = do {
      when GeocodeLocation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeocodeLocation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Geocode::Raw::Structs::GeocodeLocation
    is also<GeocodeLocation>
  { $!gl }

  multi method new (
     $geocode-location where * ~~ GeocodeLocationAncestry,

    :$ref = True
  ) {
    return unless $geocode-location;

    my $o = self.bless( :$geocode-location );
    $o.ref if $ref;
    $o;
  }
  multi method new (Num() $latitude, Num() $longitude, Num() $accuracy) {
    my gdouble ($lat, $long, $a) = ($latitude, $longitude, $accuracy);

    my $geocode-location = geocode_location_new($lat, $long, $a);

    $geocode-location ?? self.bless( :$geocode-location ) !! Nil;
  }

  method new_with_description (
    Num() $latitude,
    Num() $longitude,
    Num() $accuracy,
    Str() $description
  )
    is also<new-with-description>
  {
    my $geocode-location = geocode_location_new_with_description(
      $latitude,
      $longitude,
      $accuracy,
      $description
    );

    $geocode-location ?? self.bless( :$geocode-location ) !! Nil;
  }

  # Type: double
  method accuracy is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accuracy', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('accuracy', $gv);
      }
    );
  }

  # Type: double
  method altitude is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('altitude', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('altitude', $gv);
      }
    );
  }

  # Type: GeocodeLocationCrs
  method crs ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GeocodeLocationCRS) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('crs', $gv);
        my $c = $gv.enum;
        return $c unless $enum;
        GeocodeLocationCRSEnum($c);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GeocodeLocationCRS) = $val;
        self.prop_set('crs', $gv);
      }
    );
  }

  # Type: string
  method description is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('description', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('description', $gv);
      }
    );
  }

  # Type: double
  method latitude is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('latitude', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('latitude', $gv);
      }
    );
  }

  # Type: double
  method longitude is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('longitude', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('longitude', $gv);
      }
    );
  }

  # Type: uint64
  method timestamp is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT64 );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('timestamp', $gv);
        $gv.uint64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint64 = $val;
        self.prop_set('timestamp', $gv);
      }
    );
  }

  method equal (GeocodeLocation() $b) {
    geocode_location_equal($!gl, $b);
  }

  method get_accuracy is also<get-accuracy> {
    geocode_location_get_accuracy($!gl);
  }

  method get_altitude is also<get-altitude> {
    geocode_location_get_altitude($!gl);
  }

  method get_crs ( :$enum = True ) is also<get-crs> {
    my $c = geocode_location_get_crs($!gl);
    return $c unless $enum;
    GeocodeLocationCRSEnum($c);
  }

  method get_description is also<get-description> {
    geocode_location_get_description($!gl);
  }

  method get_distance_from (GeocodeLocation() $locb) is also<get-distance-from> {
    geocode_location_get_distance_from($!gl, $locb);
  }

  method get_latitude is also<get-latitude> {
    geocode_location_get_latitude($!gl);
  }

  method get_longitude is also<get-longitude> {
    geocode_location_get_longitude($!gl);
  }

  method get_timestamp ( :dt(:$datetime) = True ) is also<get-timestamp> {
    my $t = geocode_location_get_timestamp($!gl);
    return $t unless $datetime;
    DateTime.new($t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &geocode_location_get_type, $n, $t );
  }

  method set_description (Str() $description) is also<set-description> {
    geocode_location_set_description($!gl, $description);
  }

  method set_from_uri (Str() $uri, CArray[Pointer[GError]] $error = gerror) is also<set-from-uri> {
    clear_error;
    my $rv = so geocode_location_set_from_uri($!gl, $uri, $error);
    set_error($error);
    $rv;
  }

  method to_uri (GeocodeLocationURIScheme() $scheme) is also<to-uri> {
    geocode_location_to_uri($!gl, $scheme);
  }

}
