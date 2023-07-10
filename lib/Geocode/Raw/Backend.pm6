use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Geocode::Raw::Definitions;
use Geocode::Raw::Structs;

unit package Geocode::Raw::Backend;

### /usr/src/geocode-glib/geocode-glib/geocode-backend.h

sub geocode_backend_forward_search (
  GeocodeBackend          $backend,
  GHashTable              $params,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GList
  is      native(geocode)
  is      export
{ * }

sub geocode_backend_forward_search_async (
  GeocodeBackend      $backend,
  GHashTable          $params,
  GCancellable        $cancellable,
                      &callback (GeocodeBackend, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(geocode)
  is      export
{ * }

sub geocode_backend_forward_search_finish (
  GeocodeBackend          $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is      native(geocode)
  is      export
{ * }

sub geocode_backend_reverse_resolve (
  GeocodeBackend          $backend,
  GHashTable              $params,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GList
  is      native(geocode)
  is      export
{ * }

sub geocode_backend_reverse_resolve_async (
  GeocodeBackend      $backend,
  GHashTable          $params,
  GCancellable        $cancellable,
                      &callback (GeocodeBackend, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(geocode)
  is      export
{ * }

sub geocode_backend_reverse_resolve_finish (
  GeocodeBackend          $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is      native(geocode)
  is      export
{ * }
