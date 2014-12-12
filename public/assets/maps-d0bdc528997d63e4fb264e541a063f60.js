(function() {
  var Marker;

  Marker = (function() {
    function Marker(lat, lng) {
      this.lat = lat;
      this.lng = lng;
      this.pos = new google.maps.LatLng(lat, lng);
      this.title = '';
    }

    return Marker;

  })();

  this.Map = (function() {
    function Map(id) {
      this.id = id;
      this.markers = new Array();
      this.markerBounds = new google.maps.LatLngBounds();
      this.geolocationSupported = false;
      this.map = "Uninitialized Map Object";
      this.styledMap = "Uninitialized Map Object";
      this.options = {
        center: {
          lat: 0,
          lng: 0
        },
        zoom: 1,
        disableDefaultUI: true
      };
      this.mapStyles = [
        {
          featureType: "administrative",
          elementType: "all",
          stylers: [
            {
              visibility: "on"
            }
          ]
        }, {
          featureType: "administrative",
          elementType: "geometry.fill",
          stylers: [
            {
              color: "#ecf0f1"
            }
          ]
        }, {
          featureType: "administrative",
          elementType: "labels.text.fill",
          stylers: [
            {
              color: "#444444"
            }
          ]
        }, {
          featureType: "landscape",
          elementType: "all",
          stylers: [
            {
              color: "#ecf0f1"
            }, {
              visibility: "on"
            }
          ]
        }, {
          featureType: "landscape",
          elementType: "labels.text.fill",
          stylers: [
            {
              color: "#444444"
            }
          ]
        }, {
          featureType: "landscape",
          elementType: "labels.text.stroke",
          stylers: [
            {
              color: "#f2f2f2"
            }
          ]
        }, {
          featureType: "poi",
          elementType: "all",
          stylers: [
            {
              visibility: "off"
            }
          ]
        }, {
          featureType: "road",
          elementType: "all",
          stylers: [
            {
              saturation: -100
            }, {
              lightness: 45
            }
          ]
        }, {
          featureType: "road",
          elementType: "labels.text.fill",
          stylers: [
            {
              lightness: "-30"
            }
          ]
        }, {
          featureType: "road.highway",
          elementType: "all",
          stylers: [
            {
              visibility: "simplified"
            }
          ]
        }, {
          featureType: "road.arterial",
          elementType: "labels.icon",
          stylers: [
            {
              visibility: "off"
            }
          ]
        }, {
          featureType: "transit",
          elementType: "all",
          stylers: [
            {
              visibility: "off"
            }
          ]
        }, {
          featureType: "water",
          elementType: "all",
          stylers: [
            {
              visibility: "on"
            }, {
              color: "#2980b9"
            }
          ]
        }, {
          featureType: "water",
          elementType: "labels.text",
          stylers: [
            {
              visibility: "on"
            }
          ]
        }, {
          featureType: "water",
          elementType: "labels.text.fill",
          stylers: [
            {
              saturation: "0"
            }, {
              lightness: "0"
            }, {
              color: "#222222"
            }, {
              visibility: "simplified"
            }
          ]
        }, {
          featureType: "water",
          elementType: "labels.text.stroke",
          stylers: [
            {
              weight: "1"
            }, {
              saturation: "0"
            }, {
              lightness: "0"
            }, {
              color: "#f2f2f2"
            }, {
              visibility: "simplified"
            }
          ]
        }
      ];
    }

    Map.prototype.addMarker = function(options) {
      var loc, marker, markerOptions;
      markerOptions = {
        map: this.map,
        icon: {
          path: MAP_PIN,
          fillColor: '#E74C3C',
          fillOpacity: 1,
          strokeColor: '',
          strokeWeight: 0,
          scale: 1 / 5
        },
        label: '<i class="map-icon-parking"></i>'
      };
      if (options.lat && options.lng) {
        loc = new google.maps.LatLng(options.lat, options.lng);
        this.markerBounds.extend(loc);
        markerOptions.position = loc;
      } else {
        console.error('ERROR Creating marker: Undefined latitude or longitude.');
        return;
      }
      if (options.title) {
        markerOptions.title = options.title;
      }
      if (options.url) {
        markerOptions.url = options.url;
      }
      if (options.info) {
        markerOptions.info = options.info;
      }
      if (options.icon != null) {
        if (options.icon.fillColor != null) {
          markerOptions.icon.fillColor = options.icon.fillColor;
        }
      }
      marker = new google.maps.Marker(markerOptions);
      marker.setMap(this.map);
      this.markers.push(marker);
      return this.setMarkerClickEvent(marker);
    };

    Map.prototype.removeMarker = function(index) {
      if (!index) {
        console.error('Cannot removeMarker without an index.');
      }
      if (index === -1) {
        this.markers[this.markers.length - 1].setMap(null);
        return this.markers = this.markers.splice(this.markers.length - 1, 1);
      } else {
        this.markers[index].setMap(null);
        return this.markers = this.markers.splice(index, 1);
      }
    };

    Map.prototype.setMarkerClickEvent = function(marker) {
      var infoWindow;
      if (marker.info && marker.url) {
        return console.error('ERROR: two onClick events are specified (infoWindow and Link)');
      } else {
        if (marker.info) {
          infoWindow = new google.maps.InfoWindow({
            content: marker.info,
            visible: false
          });
          return google.maps.event.addListener(marker, 'click', function() {
            if (infoWindow.visible === false) {
              infoWindow.open(this.map, this);
              return infoWindow.visible = true;
            } else {
              infoWindow.close();
              return infoWindow.visible = false;
            }
          });
        } else if (marker.url) {
          return google.maps.event.addListener(marker, 'click', function() {
            return window.location.href = this.url;
          });
        }
      }
    };

    Map.prototype.connectMarkers = function(pathOptions) {
      var coords, marker, _i, _len, _ref;
      if (!pathOptions) {
        pathOptions = {};
      }
      coords = [];
      _ref = this.markers;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        coords.push(marker.position);
      }
      pathOptions.path = coords;
      if (!pathOptions.geodesic) {
        pathOptions.geodesic = true;
      }
      if (!pathOptions.strokeColor) {
        pathOptions.strokeColor = '#E74C3C';
      }
      if (!pathOptions.strokeOpacity) {
        pathOptions.strokeOpacity = 1.0;
      }
      if (!pathOptions.strokeWeight) {
        pathOptions.strokeWeight = 2;
      }
      this.path = new google.maps.Polyline(pathOptions);
      return this.path.setMap(this.map);
    };

    Map.prototype.disconnectMarkers = function() {
      if (!this.path) {
        console.log('Cannot disconnectMarkers until markers are connected');
        return;
      }
      return this.path.setMap(null);
    };

    Map.prototype.enableSetLatLngByClick = function(delete_most_recent_marker) {
      var _this;
      _this = this;
      return google.maps.event.addListener(this.map, 'click', function(e) {
        if (delete_most_recent_marker) {
          _this.removeMarker(-1);
        }
        this.panTo(e.latLng);
        console.log(e);
        _this.addMarker({
          lat: e.latLng.k,
          lng: e.latLng.D
        });
        document.getElementById('entry_latitude').value = e.latLng.k;
        return document.getElementById('entry_longitude').value = e.latLng.D;
      });
    };

    Map.prototype.setupMap = function() {
      this.styledMap = new google.maps.StyledMapType(this.mapStyles, {
        name: "Styled Map"
      });
      this.options.mapTypeControlOptions = {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_styles']
      };
      this.map = new google.maps.Map(document.getElementById(this.id), this.options);
      this.map.mapTypes.set('map_style', this.styledMap);
      return this.map.setMapTypeId('map_style');
    };

    Map.prototype.initialize = function() {
      google.maps.event.addDomListener(window, 'load', this.setupMap());
      if (navigator.geolocation) {
        this.geolocationSupported = true;
        return this.addLocateMeButton(this.map);
      }
    };

    Map.prototype.setCenter = function(lat, lng) {
      var loc;
      this.options.center.lat = lat;
      this.options.center.lng = lng;
      loc = new google.maps.LatLng(lat, lng);
      return this.map.setCenter(loc);
    };

    Map.prototype.setZoom = function(zoomLevel) {
      return this.map.setZoom(zoomLevel);
    };

    Map.prototype.autoCenter = function() {
      if (this.markers.length > 0) {
        return this.map.fitBounds(this.markerBounds);
      } else {
        return console.error('Cannot autoCenter map. There are no markers to center on');
      }
    };

    Map.prototype.addLocateMeButton = function(map) {
      var LocateMeControl, centerOnUserLocation, lmc, lmcDiv;
      if (!navigator.geolocation) {
        console.error('Geolocation not supported: Cannot add locateMe button.');
      } else {
        centerOnUserLocation = function() {
          var geoError, geoOptions, geoSuccess;
          geoOptions = {
            enableHighAccuracy: true,
            timeout: 10 * 1000
          };
          geoSuccess = function(position) {
            var userLoc;
            userLoc = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            map.setCenter(userLoc);
            return map.setZoom(14);
          };
          geoError = function(position) {
            return console.log("Geolocation error. Error code: " + error.code);
          };
          return navigator.geolocation.getCurrentPosition(geoSuccess, geoError, geoOptions);
        };
        LocateMeControl = function(controlDiv, map) {
          var controlText, controlUI;
          controlDiv.style.padding = '5px';
          controlDiv.style.padding = '5px';
          controlUI = document.createElement('div');
          controlUI.style.backgroundColor = '#FFFFFF';
          controlUI.style.borderStyle = 'solid';
          controlUI.style.borderWidth = '1px';
          controlUI.style.cursor = 'pointer';
          controlUI.style.textAlign = 'center';
          controlUI.title = 'Click to center the map on your location.';
          controlDiv.appendChild(controlUI);
          controlText = document.createElement('div');
          controlText.style.fontSize = '28px';
          controlText.style.paddingLeft = '2px';
          controlText.style.paddingRight = '3px';
          controlText.innerHTML = '<i class="fa fa-location-arrow"></i>';
          controlUI.appendChild(controlText);
          return google.maps.event.addDomListener(controlUI, 'click', function() {
            return centerOnUserLocation();
          });
        };
        lmcDiv = document.createElement('div');
        lmc = new LocateMeControl(lmcDiv, this.map);
        lmcDiv.index = 1;
        return this.map.controls[google.maps.ControlPosition.TOP_RIGHT].push(lmcDiv);
      }
    };

    Map.prototype.setDimensions = function(width, height) {
      document.getElementById(this.id).style.width = width;
      return document.getElementById(this.id).style.height = height;
    };

    return Map;

  })();

  $(document).ready(function() {
    var m1;
    if (window.location.pathname.match(/^\/$/)) {
      m1 = new Map('map');
      m1.setCenter(37, -121);
      m1.initialize();
      m1.addMarker(37.2, -121, 'Marker 1');
      m1.addMarker(36.8, -121);
      return m1.showMarkers();
    }
  });

}).call(this);
