use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Roles::Pointers;

constant forced = 0;

use GLib::Roles::Pointers;

unit package Geocode::Raw::Definitions;

constant geocode is export = 'geocode-glib-0.8',v0;

class GeocodeIcon is repr<CPointer> does GLib::Roles::Pointers is export {}
