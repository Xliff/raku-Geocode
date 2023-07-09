use v6;

use GLib::Raw::Exports;
use Geocode::Raw::Exports;

unit package Geocode::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GLib::Raw::Struct_Subs;
need GLib::Raw::Traits;
need GLib::Roles::Pointers;
need GLib::Roles::Implementor;
need Geocode::Raw::Definitions;
need Geocode::Raw::Enums;
need Geocode::Raw::Structs;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@geocode-exports;
}
