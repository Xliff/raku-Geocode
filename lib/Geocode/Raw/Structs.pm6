use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Object;

unit package Geocode::Raw::Structs;

class GeocodeBoundingBox is repr<CStruct> is export {
	has GObject             $!parent_instance;
	has Pointer             $!priv           ;
}

class GeocodeForward is repr<CStruct> is export {
	has GObject             $!parent_instance;
	has Pointer             $!priv           ;
}

class GeocodeLocation is repr<CStruct> is export {
	has GObject             $!parent_instance;
	has Pointer             $!priv           ;
}

class GeocodeMockBackendQuery is repr<CStruct> is export {
	has GHashTable          $!params    ;
	has gboolean            $!is_forward;
	has GList               $!results   ;
	has GError              $!error     ;
}

class GeocodePlace is repr<CStruct> is export {
	has GObject             $!parent_instance;
	has Pointer             $!priv           ;
}

class GeocodeReverse is repr<CStruct> is export {
	has GObject             $!parent_instance;
	has Pointer             $!priv           ;
}
