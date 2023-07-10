use v6.c;

use Test;

use Geocode::Raw::Types;

use Geocode::Location;

# Uri, Is-Valid
my @uris = (
  [ 'geo:13.37,42.42',                                  True  ],
  [ 'geo:13.37373737,42.42424242',                      True  ],
  [ 'geo:13.37,42.42,12.12',                            True  ],
  [ 'geo:1,2,3',                                        True  ],
  [ 'geo:-13.37,42.42',                                 True  ],
  [ 'geo:13.37,-42.42',                                 True  ],
  [ 'geo:13.37,42.42;u=-45.5',                          True  ],
  [ 'geo:13.37,42.42;u=45.5',                           True  ],
  [ 'geo:13.37,42.42,12.12;u=45.5',                     True  ],
  [ 'geo:13.37,42.42,12.12;crs=wgs84;u=45.5',           True  ],
  [ 'geo:13.37,42.42,12.12;crs=wgs84;u=45.5;u=10',      False ],
  [ 'geo:13.37,42.42,12.12;crs=wgs84;u=45.5;crs=wgs84', False ],
  [ 'geo:13.37,42.42,12.12;crs=wgs84;u=45.5;z=18',      True  ],
  [ 'geo:0.0,0,0',                                      True  ],
  [ 'geo :0.0,0,0',                                     False ],
  [ 'geo:0.0 ,0,0',                                     False ],
  [ 'geo:0.0,0 ,0',                                     False ],
  [ 'geo: 0.0,0,0',                                     False ],
  [ 'geo:13.37,42.42,12.12;crs=newcrs;u=45.5',          False ],
  [ 'geo:13.37,42.42,12.12;u=45.5;crs=hej',             False ],
  [ 'geo:13.37,42.42,12.12;u=45.5;u=22',                False ],
  [ 'geo:13.37,42.42,12.12;u=alpha',                    False ],
  [ 'gel:13.37,42.42,12.12',                            False ],
  [ 'geo:13.37alpha,42.42',                             False ],
  [ 'geo:13.37,alpha42.42',                             False ],
  [ 'geo:13.37,42.42,12.alpha',                         False ],
  [ 'geo:,13.37,42.42',                                 False ],
  [ 'geo:0,0?q=13.36,4242(description)',                True  ],
  [ 'geo:0,0?q=-13.36,4242(description)',               True  ],
  [ 'geo:0,0?q=13.36,-4242(description)',               True  ],
  [ 'geo:1,2?q=13.36,4242(description)',                False ],
  [ 'geo:0,0?q=13.36,4242(description',                 False ],
  [ 'geo:0,0?q=13.36,4242()',                           False ]
);

sub test-parse-uri {
  constant URI = 'geo:1.2,2.3,4.5;crs=wgs84;u=67';

  my $loc = Geocode::Location.new(0, 0, 0);
  $loc.set-from-uri(URI);

  nok $ERROR,              "No error occurred when setting uri '{ URI }'";
  is  $loc.latitude,  1.2, 'Retrieved latitude is the proper value';
  is  $loc.longitude, 2.3, 'Retrieved longitude is the proper value';
  is  $loc.altitude,  4.5, 'Retrieved altitude is the proper value';
  is  $loc.accuracy,  67,  'Retrieved accuracy is the proper value';

  #$loc.unref
}

sub test-valid-uri {
  for @uris {
    my $loc = Geocode::Location.new(0, 0, 0);
    my $ok  = $loc.set-from-uri( .head );
    if .tail {
      ok  $ok,    "Proper URI '{ .head }' tests as valid";
      nok $ERROR, 'No other error was found';
    } else {
      nok $ok,    "Invalid URI '{ .head }' tests as invalid";
      ok  $ERROR, 'Global ERROR is not an empty value';
    }
  }
}

sub test-escape-uri {
  constant URI = 'geo:0,0?q=57.038,12.3982(Parkvägen%202,%20Tvååker)';

  my $loc = Geocode::Location.new(0, 0, 0);
  my $ok  = $loc.set-from-uri(URI);

  ok $ok,                    "URI was set to '{ URI }' without error";
  is $loc.description,
     'Parkvägen 2, Tvååker', 'The Location description is the proper value';

  #$loc.unref;
}

sub test-convert-from-to-location {
  constant LATITUDE  = 48.198634;
  constant LONGITUDE = 16.371648;
  constant ALTITUDE  = 5.0;
  constant ACCURACY  = 40.0;
  # Karlskirche (from RFC)
  constant URI       = 'geo:48.198634,16.371648,5;crs=wgs84;u=40';

  my $loc = Geocode::Location.new(0, 0, 0);
  my $ok  = $loc.set-from-uri(URI);

  ok  $ok,            "URI was set to '{ URI }' without error";
  nok $ERROR,         'Global ERROR is not set';
  is  $loc.latitude,
      LATITUDE,       'Location latitude is the proper value';
  is  $loc.longitude,
      LONGITUDE,      'Location longitude is the proper value';
  is  $loc.altitude,
      ALTITUDE,       'Location altitude is the proper value';
  is  $loc.accuracy,
      ACCURACY,       'Location accuracy is the proper value';

  my $ret-uri = $loc.to_uri(GEOCODE_LOCATION_URI_SCHEME_GEO);
  $loc        = Geocode::Location.new(0, 0, 0);
  $ok         = $loc.set-from-uri($ret-uri);

  ok  $ok,            "URI was set to '{ $ret-uri }' without error";
  nok $ERROR,         'Global ERROR is not set';
  is  $loc.latitude,
      LATITUDE,       'Location latitude is the proper value';
  is  $loc.longitude,
      LONGITUDE,      'Location longitude is the proper value';
  is  $loc.altitude,
      ALTITUDE,       'Location altitude is the proper value';
  is  $loc.accuracy,
      ACCURACY,       'Location accuracy is the proper value';

  #$loc.unref
}

subtest '/geouri/parse-uri',   &test-parse-uri;
subtest '/geouri/valid-uri',   &test-valid-uri;
subtest '/geouri/escape-uri',  &test-escape-uri;
subtest '/geouri/convert-uri', &test-convert-from-to-location;
