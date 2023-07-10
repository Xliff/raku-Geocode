use v6.c;

use NativeCall;
use Method::Also;

use Geocode::Raw::Types;
use Geocode::Raw::Backend;

use GLib::GList;
use GLib::HashTable;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role Geocode::Roles::Backend {
  also does GLib::Roles::Object;

  has GeocodeBackend $!gb is implementor;

  method roleInit_GeocodeBackend {
    self.roleInit-GeocodeBackend;
  }
  method roleInit-GeocodeBackend {
    return Nil if $!gb;

    my \i = findProperImplementor(self.^attributes);
    $!gb = cast( GeocodeBackend, i.get_value(self) )
  }

  method Geocode::Raw::Definitions::GeocodeBackend
  { $!gb }
  method GeocodeBackend
  { $!gb }

  proto method forward_search (|)
    is also<forward-search>
  { * }

  multi method forward_search (
                             %params,
    CArray[Pointer[GError]]  $error          = gerror,
    GCancellable()          :$cancellable    = GCancellable,
                            :$raw            = False,
                            :gslist(:$glist) = False
  ) {
    samewith(
       GLib::HashTable.new(%params),
       $cancellable,
       $error,
      :$raw,
      :$glist
    );
  }
  multi method forward_search (
    GHashTable()             $params,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :gslist(:$glist) = False
  ) {
    clear_error;
    my $pl = geocode_backend_forward_search(
      $!gb,
      $params,
      $cancellable,
      $error
    );
    set_error($error);

    propReturnObject($pl, $raw, $glist, |Geocode::Place.getTypePair);
  }

  proto method forward_search_async (|)
    is also<forward-search-async>
  { * }

  multi method forward_search_async (
                         %params,
                         &callback,
    gpointer             $user_data      = gpointer,
    GCancellable()      :$cancellable    = GCancellable,
                        :$raw            = False,
                        :gslist(:$glist) = False
  ) {
    samewith(
       GLib::HashTable.new(%params),
       $cancellable,
      :$raw,
      :$glist
    );
  }
  multi method forward_search_async (
    GHashTable()        $params,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data      = gpointer,
                       :$raw            = False,
                       :gslist(:$glist) = False
  ) {
    geocode_backend_forward_search_async(
      $!gb,
      $params,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method forward_search_finish (
    GAsyncResult             $result,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :gslist(:$glist) = False
  )
    is also<forward-search-finish>
  {
    clear_error;
    my $pl = geocode_backend_forward_search_finish($!gb, $result, $error);
    set_error($error);

    propReturnObject($pl, $raw, $glist, |Geocode::Place.getTypePair);
  }

  proto method reverse_resolve (|)
    is also<reverse-resolve>
  { * }

  multi method reverse_resolve (
                             %params,
    CArray[Pointer[GError]]  $error          = gerror,
    GCancellable()          :$cancellable    = GCancellable,
                            :$raw            = False,
                            :gslist(:$glist) = False
  ) {
    samewith(
       GLib::HashTable.new(%params),
       $cancellable,
       $error,
      :$raw,
      :$glist
    );
  }
  multi method reverse_resolve (
    GHashTable()             $params,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error,
                            :$raw            = False,
                            :gslist(:$glist) = False
  ) {
    clear_error;
    my $pl = geocode_backend_reverse_resolve(
      $!gb,
      $params,
      $cancellable,
      $error
    );
    set_error($error);

    propReturnObject($pl, $raw, $glist, |Geocode::Place.getTypePair);
  }

  proto method reverse_resolve_async (|)
    is also<reverse-resolve-async>
  { * }

  multi method reverse_resolve_async (
                         %params,
                         &callback,
    gpointer             $user_data      = gpointer,
    GCancellable()      :$cancellable    = GCancellable,
                        :$raw            = False,
                        :gslist(:$glist) = False
  ) {
    samewith(
       GLib::HashTable.new(%params),
       $cancellable,
      :$raw,
      :$glist
    );
  }
  multi method reverse_resolve_async (
    GHashTable()         $params,
    GCancellable()       $cancellable,
                         &callback,
    gpointer             $user_data      = gpointer,
                        :$raw            = False,
                        :gslist(:$glist) = False
  ) {
    geocode_backend_reverse_resolve_async(
      $!gb,
      $params,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method reverse_resolve_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :gslist(:$glist) = False
  )
    is also<reverse-resolve-finish>
  {
    clear_error;
    my $pl = geocode_backend_reverse_resolve_finish($!gb, $result, $error);
    set_error($error);

    propReturnObject($pl, $raw, $glist, |Geocode::Place.getTypePair);
  }

}


our subset GeocodeBackendAncestry is export of Mu
  where GeocodeBackend | GObject;

class Geocode::Backend {
  also does GLib::Roles::Object;
  also does Geocode::Roles::Backend;

  submethod BUILD ( :$geocode-backend ) {
    self.setGeocodeBackend($geocode-backend) if $geocode-backend
  }

  method setGeocodeBackend (GeocodeBackendAncestry $_) {
    my $to-parent;

    $!gb = do {
      when GeocodeBackend {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeocodeBackend, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
     $geocode-backend where * ~~ GeocodeBackendAncestry,

    :$ref = True
  ) {
    return unless $geocode-backend;

    my $o = self.bless( :$geocode-backend );
    $o.ref if $ref;
    $o;
  }

}
