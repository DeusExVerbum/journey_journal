(function() {
  var callFxnOnPageLoad, getEntries, initLocationMap;

  callFxnOnPageLoad = function(fxn) {
    $(document).ready(fxn);
    return $(document).on('page:load', fxn);
  };

  getEntries = function() {
    return $('.entry');
  };

  initLocationMap = function() {
    var entries, map;
    if (window.location.pathname.match(/.*entries\/new$/)) {
      map = new Map('map');
      map.setDimensions('100%', '300px');
      map.initialize();
      console.log("adding entries");
      entries = getEntries();
      entries.each(function() {
        var loc, options, title;
        loc = $(this).find('.location').text().split(',');
        title = $(this).find('.title').text();
        options = {
          lat: loc[0],
          lng: loc[1],
          title: title
        };
        return map.addMarker(options);
      });
      map.connectMarkers();
      map.autoCenter();
      map.enableSetLatLngByClick(false);
    }
    if (window.location.pathname.match(/.*entries\/[0-9]+\/edit$/)) {
      console.log('edit.html.erb map');
      map = new Map('map');
      map.setDimensions('100%', '300px');
      map.initialize();
      entries = getEntries();
      entries.each(function() {
        var loc, options, title;
        loc = $(this).find('.location').text().split(',');
        title = $(this).find('.title').text();
        options = {
          lat: loc[0],
          lng: loc[1],
          title: title
        };
        map.addMarker(options);
        map.setCenter(loc[0], loc[1]);
        return map.setZoom(10);
      });
      map.connectMarkers();
      map.enableSetLatLngByClick(true);
    }
    if (window.location.pathname.match(/.*journeys\/[0-9]+\/entries\/[0-9]+$/)) {
      map = new Map('map');
      map.setDimensions('100%', '200px');
      map.initialize();
      entries = getEntries();
      entries.each(function() {
        var loc, options, title;
        loc = $(this).find('.location').text().split(',');
        title = $(this).find('.title').text();
        options = {
          lat: loc[0],
          lng: loc[1],
          title: title,
          icon: {
            fillColor: '#2C3E50'
          }
        };
        if ($(this).hasClass('focus')) {
          options.icon.fillColor = '#E74C3C';
          map.setCenter(options.lat, options.lng);
          map.setZoom(16);
        }
        return map.addMarker(options);
      });
      return map.connectMarkers({
        strokeColor: '#2C3E50'
      });
    }
  };

  callFxnOnPageLoad(initLocationMap);

}).call(this);
