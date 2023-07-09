use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Geocode::Raw::Types;
use Geocode::Raw::BoundingBox;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GeocodeBoundingBoxAncestry is export of Mu
  where GeocodeBoundingBox | GObject;

class Geocode::BoundingBox {
  also does GLib::Roles::Object;

  has GeocodeBoundingBox $!gbb is implementor;

  submethod BUILD ( :$geocode-box ) {
    self.setGeocodeBoundingBox($geocode-box) if $geocode-box
  }

  method setGeocodeBoundingBox (GeocodeBoundingBoxAncestry $_) {
    my $to-parent;

    $!gbb = do {
      when GeocodeBoundingBox {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeocodeBoundingBox, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Geocode::Raw::Structs::GeocodeBoundingBox
    is also<GeocodeBoundingBox>
  { $!gbb }

  multi method new (
     $geocode-box where * ~~ GeocodeBoundingBoxAncestry,

    :$ref = True
  ) {
    return unless $geocode-box;

    my $o = self.bless( :$geocode-box );
    $o.ref if $ref;
    $o;
  }

  proto method new (|)
  { * }

  multi method new (
    Num() :$top    = 0e0,
    Num() :$bottom = 0e0,
    Num() :$left   = 0e0,
    Num() :$right  = 0e0,
  ) {
    samewith($top, $bottom, $left, $right);
  }
  multi method new (
    Num() $top,
    Num() $bottom,
    Num() $left,
    Num() $right
  ) {
    my gdouble ($t, $b, $l, $r) = ($top, $bottom, $left, $right);

    my $geocode-box = geocode_bounding_box_new($t, $b, $l, $r);

    $geocode-box ?? self.bless( :$geocode-box ) !! Nil;
  }

  # Type: double
  method bottom is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('bottom', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('bottom', $gv);
      }
    );
  }

  # Type: double
  method left is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('left', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('left', $gv);
      }
    );
  }

  # Type: double
  method right is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('right', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('right', $gv);
      }
    );
  }

  # Type: double
  method top is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('top', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('top', $gv);
      }
    );
  }

  method equal (GeocodeBoundingBox() $b) {
    geocode_bounding_box_equal($!gbb, $b);
  }

  method get_bottom is also<get-bottom> {
    geocode_bounding_box_get_bottom($!gbb);
  }

  method get_left is also<get-left> {
    geocode_bounding_box_get_left($!gbb);
  }

  method get_right is also<get-right> {
    geocode_bounding_box_get_right($!gbb);
  }

  method get_top is also<get-top> {
    geocode_bounding_box_get_top($!gbb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &geocode_bounding_box_get_type, $n, $t );
  }

}
