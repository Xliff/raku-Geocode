use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use Geocode::Raw::Types;
use Geocode::Raw::Forward;

use GLib::GList;
use GLib::HashTable;
use Geocode::Place;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GeocodeForwardAncestry is export of Mu
  where GeocodeForward | GObject;

class Geocode::Forward {
  also does GLib::Roles::Object;

  has GeocodeForward $!gf is implementor;

  submethod BUILD ( :$geocode-forward ) {
    self.setGeocodeForward($geocode-forward) if $geocode-forward
  }

  method setGeocodeForward (GeocodeForwardAncestry $_) {
    my $to-parent;

    $!gf = do {
      when GeocodeForward {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeocodeForward, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Geocode::Raw::Structs::GeocodeForward
    is also<GeocodeForward>
  { $!gf }

  multi method new (
     $geocode-forward where * ~~ GeocodeForwardAncestry,

    :$ref = True
  ) {
    return unless $geocode-forward;

    my $o = self.bless( :$geocode-forward );
    $o.ref if $ref;
    $o;
  }

  proto method new_for_params (|)
    is also<new-for-params>
  { * }

  multi method new_for_params (%params) {
    samewith( GLib::HashTable.new(%params) );
  }
  multi method new_for_params (GHashTable() $params) {
    my $geocode-forward = geocode_forward_new_for_params($params);

    $geocode-forward ?? self.bless( :$geocode-forward ) !! Nil;
  }

  method new_for_string (Str() $str) is also<new-for-string> {
    my $geocode-forward = geocode_forward_new_for_string($str);

    $geocode-forward ?? self.bless( :$geocode-forward ) !! Nil;
  }

  # Type: uint
  method answer-count is rw  is g-property is also<answer_count> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('answer-count', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('answer-count', $gv);
      }
    );
  }

  # Type: boolean
  method bounded is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('bounded', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('bounded', $gv);
      }
    );
  }

  # Type: GeocodeBoundingBox
  method search-area ( :$raw = False )
    is rw
    is g-property
    is also<search_area>
  {
    my $gv = GLib::Value.new( Geocode::BoundingBox.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-area', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Geocode::BoundingBox.getTypePair
        );
      },
      STORE => -> $, GeocodeBoundingBox() $val is copy {
        $gv.object = $val;
        self.prop_set('search-area', $gv);
      }
    );
  }

  method get_answer_count is also<get-answer-count> {
    geocode_forward_get_answer_count($!gf);
  }

  method get_bounded is also<get-bounded> {
    so geocode_forward_get_bounded($!gf);
  }

  method get_search_area ( :$raw = False ) is also<get-search-area> {
    propReturnObject(
      geocode_forward_get_search_area($!gf),
      $raw,
      |Geocode::BoundingBox.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &geocode_forward_get_type, $n, $t );
  }

  method search (
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :gslist(:$glist) = False
  ) {
    clear_error;
    my $pl = geocode_forward_search($!gf, $error);
    set_error($error);

    returnGList($pl, $raw, $glist, |Geocode::Place.getTypePair);
  }

  proto method search_async (|)
    is also<search-async>
  { * }

  multi method search_async (
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method search_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    geocode_forward_search_async($!gf, $cancellable, &callback, $user_data);
  }

  method search_finish (
    GAsyncResult()           $res,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :gslist(:$glist) = False
  )
    is also<search-finish>
  {
    clear_error;
    my $pl = geocode_forward_search_finish($!gf, $res, $error);
    set_error($error);

    returnGList($pl, $raw, $glist, |Geocode::Place.getTypePair)
  }

  method set_answer_count (guint $count) is also<set-answer-count> {
    my guint $c = $count;

    geocode_forward_set_answer_count($!gf, $c);
  }

  method set_backend (GeocodeBackend() $backend) is also<set-backend> {
    geocode_forward_set_backend($!gf, $backend);
  }

  method set_bounded (Int() $bounded) is also<set-bounded> {
    my gboolean $b = $bounded.so.Int;

    geocode_forward_set_bounded($!gf, $b);
  }

  method set_search_area (GeocodeBoundingBox() $box) is also<set-search-area> {
    geocode_forward_set_search_area($!gf, $box);
  }

}
