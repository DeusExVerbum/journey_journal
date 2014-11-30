(function() {
  var callFxnOnPageLoad, centerLoc, initialize, map, markerBounds, markers, populate_journey_map, showMarkers;

  map = '';

  centerLoc = {
    lat: 1,
    lng: 1
  };

  markers = new Array();

  markerBounds = new google.maps.LatLngBounds();

  initialize = function(centerLat, centerLng) {
    var mapOptions;
    mapOptions = {
      center: {
        lat: centerLat,
        lng: centerLng
      },
      zoom: 10
    };
    return map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  };

  populate_journey_map = function() {
    var centerLat, centerLng;
    if (window.location.pathname.match(/.*journeys\/[0-9]+$/)) {
      centerLat = centerLoc.lat;
      centerLng = centerLoc.lng;
      google.maps.event.addDomListener(window, 'load', initialize(centerLat, centerLng));
      map.fitBounds(markerBounds);
      return showMarkers();
    }
  };

  this.addMarker = function(lat, lng, title) {
    return markers.push(Array(lat, lng, title));
  };

  showMarkers = function() {
    var i, loc, marker, _i, _len, _results;
    _results = [];
    for (i = _i = 0, _len = markers.length; _i < _len; i = ++_i) {
      marker = markers[i];
      loc = new google.maps.LatLng(marker[0], marker[1]);
      markerBounds.extend(loc);
      marker = new google.maps.Marker({
        position: loc,
        map: map,
        title: i + 1 + " | " + marker[2]
      });
      _results.push(marker.setMap(map));
    }
    return _results;
  };

  this.setCenter = function(lat, lng) {
    centerLoc.lat = lat;
    return centerLoc.lng = lng;
  };

  callFxnOnPageLoad = function(fxn) {
    $(document).ready(fxn);
    return $(document).on('page:load', fxn);
  };

  callFxnOnPageLoad(populate_journey_map);

}).call(this);
