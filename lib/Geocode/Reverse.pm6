use v6.c;

use Method::Also;

use NativeCall;

use Geocode::Raw::Types;
use Geocode::Raw::Reverse;

use Geocode::Place;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GeocodeReverseAncestry is export of Mu
  where GeocodeReverse | GObject;

class Geocode::Reverse {
  also does GLib::Roles::Object;

  has GeocodeReverse $!gr is implementor;

  submethod BUILD ( :$geocode-reverse ) {
    self.setGeocodeReverse($geocode-reverse) if $geocode-reverse
  }

  method setGeocodeReverse (GeocodeReverseAncestry $_) {
    my $to-parent;

    $!gr = do {
      when GeocodeReverse {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeocodeReverse, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Geocode::Raw::Definitions::GeocodeReverse
    is also<GeocodeReverse>
  { $!gr }

  multi method new (
     $geocode-reverse where * ~~ GeocodeReverseAncestry,

    :$ref = True
  ) {
    return unless $geocode-reverse;

    my $o = self.bless( :$geocode-reverse );
    $o.ref if $ref;
    $o;
  }

  multi method new (Num() $lat, Num() $long, Num() $accuracy = 2) {
    my $loc = Geocode::Location.new($lat, $long, $accuracy);
    say "location = { $loc}";
    self.new_for_location($loc);
  }

  method new_for_location (GeocodeLocation() $loc)
    is also<new-for-location>
  {
    my $geocode-reverse = geocode_reverse_new_for_location($loc);

    $geocode-reverse ?? self.bless( :$geocode-reverse ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &geocode_reverse_get_type, $n, $t );
  }


  method resolve (CArray[Pointer[GError]] $error = gerror, :$raw = False) {
    propReturnObject(
      geocode_reverse_resolve($!gr, $error),
      $raw,
      |Geocode::Place.getTypePair
    );
  }

  proto method resolve_async (|)
    is also<resolve-async>
  { * }

  multi method resolve_async (
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method resolve_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    geocode_reverse_resolve_async($!gr, $cancellable, &callback, $user_data);
  }

  method resolve_finish (
    GAsyncResult()           $res,
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<resolve-finish>
  {
    clear_error;
    my $p = geocode_reverse_resolve_finish($!gr, $res, $error);
    set_error($error);

    propReturnObject($p, $raw, |Geocode::Place.getTypePair);
  }

  method backend is rw {
    Proxy.new:
      FETCH => -> $ {
        $*ERR.say: 'Geocode::Reverse does not support reading of backend!';
        Nil
      },
      STORE => -> $, \v { self.set_backend(v) }
  }

  method set_backend (GeocodeBackend() $backend) is also<set-backend> {
    geocode_reverse_set_backend($!gr, $backend);
  }

}
