(function() {
  var fill_lat_long_fields;

  if (navigator.geolocation) {
    console.log("Geolocation is supported");
  } else {
    console.log("Geolocation is NOT supported");
    if (window.location.pathname.match(/.*entries\/new$/)) {
      $('#find_me').hide();
    }
  }

  fill_lat_long_fields = function() {
    var geoError, geoOptions, geoSuccess;
    if (window.location.pathname.match(/.*entries\/new$/)) {
      geoOptions = {
        enableHighAccuracy: true,
        timeout: 10 * 1000
      };
      geoSuccess = function(position) {
        var lat, long, startPos;
        startPos = position;
        lat = document.getElementById('entry_latitude').value = startPos.coords.latitude;
        return long = document.getElementById('entry_longitude').value = startPos.coords.longitude;
      };
      geoError = function(position) {
        return console.log("Geolocation error. Error code: " + error.code);
      };
      return navigator.geolocation.getCurrentPosition(geoSuccess, geoError, geoOptions);
    }
  };

  $(document).ready(function() {
    return $('#findMe').click(function(event) {
      fill_lat_long_fields();
      return event.preventDefault();
    });
  });

}).call(this);
