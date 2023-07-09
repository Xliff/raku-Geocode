use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Geocode::Raw::Definitions;
use Geocode::Raw::Enums;
use Geocode::Raw::Structs;

unit package Geocode::Raw::Location;

### /usr/src/geocode-glib/geocode-glib/geocode-location.h

sub geocode_location_equal (GeocodeLocation $a, GeocodeLocation $b)
  returns uint32
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_accuracy (GeocodeLocation $loc)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_altitude (GeocodeLocation $loc)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_crs (GeocodeLocation $loc)
  returns GeocodeLocationCRS
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_description (GeocodeLocation $loc)
  returns Str
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_distance_from (
  GeocodeLocation $loca,
  GeocodeLocation $locb
)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_latitude (GeocodeLocation $loc)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_longitude (GeocodeLocation $loc)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_timestamp (GeocodeLocation $loc)
  returns guint64
  is      native(geocode)
  is      export
{ * }

sub geocode_location_get_type
  returns GType
  is      native(geocode)
  is      export
{ * }

sub geocode_location_new (
  gdouble $latitude,
  gdouble $longitude,
  gdouble $accuracy
)
  returns GeocodeLocation
  is      native(geocode)
  is      export
{ * }

sub geocode_location_new_with_description (
  gdouble $latitude,
  gdouble $longitude,
  gdouble $accuracy,
  Str     $description
)
  returns GeocodeLocation
  is      native(geocode)
  is      export
{ * }

sub geocode_location_set_description (
  GeocodeLocation $loc,
  Str             $description
)
  is      native(geocode)
  is      export
{ * }

sub geocode_location_set_from_uri (
  GeocodeLocation         $loc,
  Str                     $uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(geocode)
  is      export
{ * }

sub geocode_location_to_uri (
  GeocodeLocation          $loc,
  GeocodeLocationURIScheme $scheme
)
  returns Str
  is      native(geocode)
  is      export
{ * }
