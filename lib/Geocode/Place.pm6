use v6.c;

use GLib::Raw::Traits;

use Geocode::Raw::Types;
use Geocode::Raw::Place;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class Geocode::Place {
  also does GLib::Roles::Object;

  has GeocodePlace $!gp is implementor;

  method new (Str() $name, Int() $place_type) {
    my GeocodePlaceType $p = $place_type;

    my $geocode-place = geocode_place_new($name, $place_type);

    $geocode-place ?? self.bless( :$geocode-place ) !! Nil;
  }

  method new_with_location (
    Str()             $name,
    Int()             $place_type,
    GeocodeLocation() $location
  ) {
    my GeocodePlaceType $p = $place_type;

    my $geocode-place = geocode_place_new_with_location($name, $p, $location);

    $geocode-place ?? self.bless( :$geocode-place ) !! Nil;
  }

  # Type: string
  method administrative-area is rw  is g-property {
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
  method bounding-box is rw  is g-property {
    my $gv = GLib::Value.new( GeocodeBoundingBox );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('bounding-box', $gv);
        $gv.GeocodeBoundingBox;
      },
      STORE => -> $,  $val is copy {
        $gv.GeocodeBoundingBox = $val;
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
  method country-code is rw  is g-property {
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
  method icon is rw  is g-property {
    my $gv = GLib::Value.new( GeocodeIcon );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon', $gv);
        $gv.GeocodeIcon;
      },
      STORE => -> $,  $val is copy {
        warn 'icon does not allow writing'
      }
    );
  }

  # Type: GeocodeLocation
  method location is rw  is g-property {
    my $gv = GLib::Value.new( GeocodeLocation );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('location', $gv);
        $gv.GeocodeLocation;
      },
      STORE => -> $,  $val is copy {
        $gv.GeocodeLocation = $val;
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
  method osm-id is rw  is g-property {
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
  method osm-type is rw  is g-property {
    my $gv = GLib::Value.new( GeocodePlaceOsmType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('osm-type', $gv);
        $gv.GeocodePlaceOsmType;
      },
      STORE => -> $,  $val is copy {
        $gv.GeocodePlaceOsmType = $val;
        self.prop_set('osm-type', $gv);
      }
    );
  }

  # Type: GeocodePlaceType
  method place-type is rw  is g-property {
    my $gv = GLib::Value.new( GeocodePlaceType );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('place-type', $gv);
        $gv.GeocodePlaceType;
      },
      STORE => -> $,  $val is copy {
        $gv.GeocodePlaceType = $val;
        self.prop_set('place-type', $gv);
      }
    );
  }

  # Type: string
  method postal-code is rw  is g-property {
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
  method street-address is rw  is g-property {
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

  method get_administrative_area {
    geocode_place_get_administrative_area($!gp);
  }

  method get_area {
    geocode_place_get_area($!gp);
  }

  method get_bounding_box {
    geocode_place_get_bounding_box($!gp);
  }

  method get_building {
    geocode_place_get_building($!gp);
  }

  method get_continent {
    geocode_place_get_continent($!gp);
  }

  method get_country {
    geocode_place_get_country($!gp);
  }

  method get_country_code {
    geocode_place_get_country_code($!gp);
  }

  method get_county {
    geocode_place_get_county($!gp);
  }

  method get_icon {
    geocode_place_get_icon($!gp);
  }

  method get_location {
    geocode_place_get_location($!gp);
  }

  method get_name {
    geocode_place_get_name($!gp);
  }

  method get_osm_id {
    geocode_place_get_osm_id($!gp);
  }

  method get_osm_type {
    geocode_place_get_osm_type($!gp);
  }

  method get_place_type {
    geocode_place_get_place_type($!gp);
  }

  method get_postal_code {
    geocode_place_get_postal_code($!gp);
  }

  method get_state {
    geocode_place_get_state($!gp);
  }

  method get_street {
    geocode_place_get_street($!gp);
  }

  method get_street_address {
    geocode_place_get_street_address($!gp);
  }

  method get_town {
    geocode_place_get_town($!gp);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &geocode_place_get_type, $n, $t );
  }

  method set_administrative_area (Str() $admin_area) {
    geocode_place_set_administrative_area($!gp, $admin_area);
  }

  method set_area (Str() $area) {
    geocode_place_set_area($!gp, $area);
  }

  method set_bounding_box (GeocodeBoundingBox() $bbox) {
    geocode_place_set_bounding_box($!gp, $bbox);
  }

  method set_building (Str() $building) {
    geocode_place_set_building($!gp, $building);
  }

  method set_continent (Str() $continent) {
    geocode_place_set_continent($!gp, $continent);
  }

  method set_country (Str() $country) {
    geocode_place_set_country($!gp, $country);
  }

  method set_country_code (Str() $country_code) {
    geocode_place_set_country_code($!gp, $country_code);
  }

  method set_county (Str() $county) {
    geocode_place_set_county($!gp, $county);
  }

  method set_location (GeocodeLocation() $location) {
    geocode_place_set_location($!gp, $location);
  }

  method set_name (Str() $name) {
    geocode_place_set_name($!gp, $name);
  }

  method set_postal_code (Str() $postal_code) {
    geocode_place_set_postal_code($!gp, $postal_code);
  }

  method set_state (Str() $state) {
    geocode_place_set_state($!gp, $state);
  }

  method set_street (Str() $street) {
    geocode_place_set_street($!gp, $street);
  }

  method set_street_address (Str() $street_address) {
    geocode_place_set_street_address($!gp, $street_address);
  }

  method set_town (Str() $town) {
    geocode_place_set_town($!gp, $town);
  }

}
