use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Geocode::Raw::Definitions;
use Geocode::Raw::Enums;
use Geocode::Raw::Structs;

unit package Geocode::Raw::Place;

### /usr/src/geocode-glib/geocode-glib/geocode-place.h

sub geocode_place_equal (GeocodePlace $a, GeocodePlace $b)
  returns uint32
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_administrative_area (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_area (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_bounding_box (GeocodePlace $place)
  returns GeocodeBoundingBox
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_building (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_continent (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_country (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_country_code (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_county (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_icon (GeocodePlace $place)
  returns GIcon
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_location (GeocodePlace $place)
  returns GeocodeLocation
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_name (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_osm_id (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_osm_type (GeocodePlace $place)
  returns GeocodePlaceOsmType
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_place_type (GeocodePlace $place)
  returns GeocodePlaceType
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_postal_code (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_state (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_street (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_street_address (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_town (GeocodePlace $place)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_place_get_type
  returns GType
  is      native(geocode)
  is      export
{ * }

sub geocode_place_new (
  Str              $name,
  GeocodePlaceType $place_type
)
  returns GeocodePlace
  is      native(geocode)
  is      export
{ * }

sub geocode_place_new_with_location (
  Str              $name,
  GeocodePlaceType $place_type,
  GeocodeLocation  $location
)
  returns GeocodePlace
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_administrative_area (
  GeocodePlace $place,
  Str          $admin_area
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_area (
  GeocodePlace $place,
  Str          $area
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_bounding_box (
  GeocodePlace       $place,
  GeocodeBoundingBox $bbox
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_building (
  GeocodePlace $place,
  Str          $building
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_continent (
  GeocodePlace $place,
  Str          $continent
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_country (
  GeocodePlace $place,
  Str          $country
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_country_code (
  GeocodePlace $place,
  Str          $country_code
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_county (
  GeocodePlace $place,
  Str          $county
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_location (
  GeocodePlace    $place,
  GeocodeLocation $location
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_name (
  GeocodePlace $place,
  Str          $name
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_postal_code (
  GeocodePlace $place,
  Str          $postal_code
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_state (
  GeocodePlace $place,
  Str          $state
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_street (
  GeocodePlace $place,
  Str          $street
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_street_address (
  GeocodePlace $place,
  Str          $street_address
)
  is      native(geocode)
  is      export
{ * }

sub geocode_place_set_town (
  GeocodePlace $place,
  Str          $town
)
  is      native(geocode)
  is      export
{ * }
