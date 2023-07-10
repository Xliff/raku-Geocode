

### /usr/src/geocode-glib/geocode-glib/geocode-nominatim.h

sub geocode_nominatim_get_gnome  
  returns GeocodeNominatim
  is      native(geocode)
  is      export
{ * }

sub geocode_nominatim_new (
  Str $base_url,
  Str $maintainer_email_address
) 
  returns GeocodeNominatim
  is      native(geocode)
  is      export
{ * }

