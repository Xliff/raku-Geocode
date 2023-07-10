use v6.c;

use Method::Also;

use GLib::Raw::Traits;

use Geocode::Raw::Types;
use Geocode::Raw::Place;

use Geocode::BoundingBox;
use Geocode::Location;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GeocodePlaceAncestry is export of Mu
  where GeocodePlace | GObject;

class Geocode::Place {
  also does GLib::Roles::Object;

  has GeocodePlace $!gp is implementor;

  submethod BUILD ( :$geocode-place ) {
    self.setGeocodePlace($geocode-place) if $geocode-place
  }

  method setGeocodePlace (GeocodePlaceAncestry $_) {
    my $to-parent;

    $!gp = do {
      when GeocodePlace {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeocodePlace, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Geocode::Raw::Definitions::GeocodePlace
    is also<GeocodePlace>
  { $!gp }

  multi method new (
     $geocode-place where * ~~ GeocodePlaceAncestry,

    :$ref = True
  ) {
    return unless $geocode-place;

    my $o = self.bless( :$geocode-place );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name, Int() $place_type) {
    my GeocodePlaceType $p = $place_type;

    my $geocode-place = geocode_place_new($name, $place_type);

    $geocode-place ?? self.bless( :$geocode-place ) !! Nil;
  }

  method new_with_location (
    Str()             $name,
    Int()             $place_type,
    GeocodeLocation() $location
  )
    is also<new-with-location>
  {
    my GeocodePlaceType $p = $place_type;

    my $geocode-place = geocode_place_new_with_location($name, $p, $location);

    $geocode-place ?? self.bless( :$geocode-place ) !! Nil;
  }

  # Type: string
  method administrative-area is rw  is g-property is also<administrative_area> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('administrative-area', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('administrative-area', $gv);
      }
    );
  }

  # Type: string
  method area is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('area', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('area', $gv);
      }
    );
  }

  # Type: GeocodeBoundingBox
  method bounding-box ( :$raw = False )
    is rw
    is g-property
    is also<bounding_box>
  {
    my $gv = GLib::Value.new( Geocode::BoundingBox.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('bounding-box', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Geocode::BoundingBox.getTypePair
        );
      },
      STORE => -> $, GeocodeBoundingBox() $val is copy {
        $gv.object = $val;
        self.prop_set('bounding-box', $gv);
      }
    );
  }

  # Type: string
  method building is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('building', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('building', $gv);
      }
    );
  }

  # Type: string
  method continent is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('continent', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('continent', $gv);
      }
    );
  }

  # Type: string
  method country is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('country', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('country', $gv);
      }
    );
  }

  # Type: string
  method country-code is rw  is g-property is also<country_code> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('country-code', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('country-code', $gv);
      }
    );
  }

  # Type: string
  method county is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('county', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('county', $gv);
      }
    );
  }

  # Type: GeocodeIcon
  method icon ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Geocode::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Geocode::Icon.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'icon does not allow writing'
      }
    );
  }

  # Type: GeocodeLocation
  method location ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Geocode::Location.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('location', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Geocode::Location.getTypePair
        );
      },
      STORE => -> $, GeocodeLocation() $val is copy {
        $gv.object = $val;
        self.prop_set('location', $gv);
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: string
  method osm-id is rw  is g-property is also<osm_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('osm-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('osm-id', $gv);
      }
    );
  }

  # Type: GeocodePlaceOsmType
  method osm-type ( :$enum = True ) is rw  is g-property is also<osm_type> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GeocodePlaceOsmType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('osm-type', $gv);
        my $ot = $gv.enum;
        return $ot unless $enum;
        GeocodePlaceOsmTypeEnum($ot);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GeocodePlaceOsmType) = $val;
        self.prop_set('osm-type', $gv);
      }
    );
  }

  # Type: GeocodePlaceType
  method place-type ( :$enum = True )
    is rw
    is g-property
    is also<place_type>
  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GeocodePlaceType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('place-type', $gv);
        my $pt = $gv.enum;
        return $pt unless $enum;
        GeocodePlaceTypeEnum($pt);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GeocodePlaceType) = $val;
        self.prop_set('place-type', $gv);
      }
    );
  }

  # Type: string
  method postal-code is rw  is g-property is also<postal_code> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('postal-code', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('postal-code', $gv);
      }
    );
  }

  # Type: string
  method state is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('state', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('state', $gv);
      }
    );
  }

  # Type: string
  method street is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('street', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('street', $gv);
      }
    );
  }

  # Type: string
  method street-address is rw  is g-property is also<street_address> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('street-address', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('street-address', $gv);
      }
    );
  }

  # Type: string
  method town is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('town', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('town', $gv);
      }
    );
  }

  method equal (GeocodePlace() $b) {
    geocode_place_equal($!gp, $b);
  }

  method get_administrative_area is also<get-administrative-area> {
    geocode_place_get_administrative_area($!gp);
  }

  method get_area is also<get-area> {
    geocode_place_get_area($!gp);
  }

  method get_bounding_box is also<get-bounding-box> {
    geocode_place_get_bounding_box($!gp);
  }

  method get_building is also<get-building> {
    geocode_place_get_building($!gp);
  }

  method get_continent is also<get-continent> {
    geocode_place_get_continent($!gp);
  }

  method get_country is also<get-country> {
    geocode_place_get_country($!gp);
  }

  method get_country_code is also<get-country-code> {
    geocode_place_get_country_code($!gp);
  }

  method get_county is also<get-county> {
    geocode_place_get_county($!gp);
  }

  method get_icon is also<get-icon> {
    geocode_place_get_icon($!gp);
  }

  method get_location is also<get-location> {
    geocode_place_get_location($!gp);
  }

  method get_name is also<get-name> {
    geocode_place_get_name($!gp);
  }

  method get_osm_id is also<get-osm-id> {
    geocode_place_get_osm_id($!gp);
  }

  method get_osm_type is also<get-osm-type> {
    geocode_place_get_osm_type($!gp);
  }

  method get_place_type is also<get-place-type> {
    geocode_place_get_place_type($!gp);
  }

  method get_postal_code is also<get-postal-code> {
    geocode_place_get_postal_code($!gp);
  }

  method get_state is also<get-state> {
    geocode_place_get_state($!gp);
  }

  method get_street is also<get-street> {
    geocode_place_get_street($!gp);
  }

  method get_street_address is also<get-street-address> {
    geocode_place_get_street_address($!gp);
  }

  method get_town is also<get-town> {
    geocode_place_get_town($!gp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &geocode_place_get_type, $n, $t );
  }

  method set_administrative_area (Str() $admin_area)
    is also<set-administrative-area>
  {
    geocode_place_set_administrative_area($!gp, $admin_area);
  }

  method set_area (Str() $area) is also<set-area> {
    geocode_place_set_area($!gp, $area);
  }

  method set_bounding_box (GeocodeBoundingBox() $bbox)
    is also<set-bounding-box>
  {
    geocode_place_set_bounding_box($!gp, $bbox);
  }

  method set_building (Str() $building) is also<set-building> {
    geocode_place_set_building($!gp, $building);
  }

  method set_continent (Str() $continent) is also<set-continent> {
    geocode_place_set_continent($!gp, $continent);
  }

  method set_country (Str() $country) is also<set-country> {
    geocode_place_set_country($!gp, $country);
  }

  method set_country_code (Str() $country_code) is also<set-country-code> {
    geocode_place_set_country_code($!gp, $country_code);
  }

  method set_county (Str() $county) is also<set-county> {
    geocode_place_set_county($!gp, $county);
  }

  method set_location (GeocodeLocation() $location) is also<set-location> {
    geocode_place_set_location($!gp, $location);
  }

  method set_name (Str() $name) is also<set-name> {
    geocode_place_set_name($!gp, $name);
  }

  method set_postal_code (Str() $postal_code) is also<set-postal-code> {
    geocode_place_set_postal_code($!gp, $postal_code);
  }

  method set_state (Str() $state) is also<set-state> {
    geocode_place_set_state($!gp, $state);
  }

  method set_street (Str() $street) is also<set-street> {
    geocode_place_set_street($!gp, $street);
  }

  method set_street_address (Str() $street_address)
    is also<set-street-address>
  {
    geocode_place_set_street_address($!gp, $street_address);
  }

  method set_town (Str() $town) is also<set-town> {
    geocode_place_set_town($!gp, $town);
  }

}
