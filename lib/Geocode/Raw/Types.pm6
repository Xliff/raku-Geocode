use v6;

use GLib::Raw::Exports;
use GIO::Raw::Exports;
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
need GIO::Raw::Definitions;
need GIO::Raw::Enums;
need GIO::Raw::Structs;
need GIO::Raw::Subs;
need GIO::Raw::Quarks;
need GIO::DBus::Raw::Types;
need Geocode::Raw::Definitions;
need Geocode::Raw::Enums;
need Geocode::Raw::Structs;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@gio-exports,
                         |@geocode-exports;
}
