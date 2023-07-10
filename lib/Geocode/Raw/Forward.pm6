use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Geocode::Raw::Definitions;
use Geocode::Raw::Structs;

unit package Geocode::Raw::Forward;

### /usr/src/geocode-glib/geocode-glib/geocode-forward.h

sub geocode_forward_get_answer_count (GeocodeForward $forward)
  returns guint
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_get_bounded (GeocodeForward $forward)
  returns uint32
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_get_search_area (GeocodeForward $forward)
  returns GeocodeBoundingBox
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_get_type
  returns GType
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_new_for_params (GHashTable $params)
  returns GeocodeForward
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_new_for_string (Str $str)
  returns GeocodeForward
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_search (
  GeocodeForward          $forward,
  CArray[Pointer[GError]] $error
)
  returns GList
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_search_async (
  GeocodeForward      $forward,
  GCancellable        $cancellable,
                      &callback (GeocodeForward, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_search_finish (
  GeocodeForward          $forward,
  GAsyncResult            $res,
  CArray[Pointer[GError]] $error
)
  returns GList
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_set_answer_count (
  GeocodeForward $forward,
  guint          $count
)
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_set_backend (
  GeocodeForward $forward,
  GeocodeBackend $backend
)
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_set_bounded (
  GeocodeForward $forward,
  gboolean       $bounded
)
  is      native(geocode)
  is      export
{ * }

sub geocode_forward_set_search_area (
  GeocodeForward     $forward,
  GeocodeBoundingBox $box
)
  is      native(geocode)
  is      export
{ * }
