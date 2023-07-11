use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Geocode::Raw::Definitions;
use Geocode::Raw::Structs;

unit package Geocode::Raw::Reverse;

### /usr/src/geocode-glib/geocode-glib/geocode-reverse.h

sub geocode_reverse_get_type
  returns GType
  is      native(geocode)
  is      export
{ * }

sub geocode_reverse_new_for_location (GeocodeLocation $location)
  returns GeocodeReverse
  is      native(geocode)
  is      export
{ * }

sub geocode_reverse_resolve (
  GeocodeReverse          $object,
  CArray[Pointer[GError]] $error
)
  returns GeocodePlace
  is      native(geocode)
  is      export
{ * }

sub geocode_reverse_resolve_async (
  GeocodeReverse      $object,
  GCancellable        $cancellable,
                      &callback (GeocodeReverse, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(geocode)
  is      export
{ * }

sub geocode_reverse_resolve_finish (
  GeocodeReverse          $object,
  GAsyncResult            $res,
  CArray[Pointer[GError]] $error
)
  returns GeocodePlace
  is      native(geocode)
  is      export
{ * }

sub geocode_reverse_set_backend (
  GeocodeReverse $object,
  GeocodeBackend $backend
)
  is      native(geocode)
  is      export
{ * }
