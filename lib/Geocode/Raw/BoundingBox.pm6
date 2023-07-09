use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Geocode::Raw::Definitions;
use Geocode::Raw::Structs;

unit package Geocode::Raw::BoundingBox;

### /usr/src/geocode-glib/geocode-glib/geocode-bounding-box.h

sub geocode_bounding_box_equal (GeocodeBoundingBox $a, GeocodeBoundingBox $b)
  returns uint32
  is      native(geocode)
  is      export
{ * }

sub geocode_bounding_box_get_bottom (GeocodeBoundingBox $bbox)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_bounding_box_get_left (GeocodeBoundingBox $bbox)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_bounding_box_get_right (GeocodeBoundingBox $bbox)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_bounding_box_get_top (GeocodeBoundingBox $bbox)
  returns gdouble
  is      native(geocode)
  is      export
{ * }

sub geocode_bounding_box_get_type
  returns GType
  is      native(geocode)
  is      export
{ * }

sub geocode_bounding_box_new (
  gdouble $top,
  gdouble $bottom,
  gdouble $left,
  gdouble $right
)
  returns GeocodeBoundingBox
  is      native(geocode)
  is      export
{ * }
