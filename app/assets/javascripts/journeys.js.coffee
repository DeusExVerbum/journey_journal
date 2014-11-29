# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = ''
centerLoc =
  lat: 1
  lng: 1
markers = new Array()
markerBounds = new google.maps.LatLngBounds()

initialize = (centerLat, centerLng) ->
  mapOptions =
    center: 
      lat: centerLat
      lng: centerLng
    zoom: 10
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

populate_journey_map = ->
  if window.location.pathname.match(/.*journeys\/[0-9]+$/)
    centerLat = centerLoc.lat
    centerLng = centerLoc.lng
    google.maps.event.addDomListener(window, 'load', initialize(centerLat, centerLng));
    map.fitBounds(markerBounds)
    showMarkers()


@addMarker = (lat, lng, title) ->
  markers.push(Array(lat, lng, title))

showMarkers = ->
  for marker, i in markers
    loc = new google.maps.LatLng(marker[0], marker[1])
    # Grow the map's boundaries to include each marker
    markerBounds.extend(loc)
    marker = new google.maps.Marker(
      position: loc
      map: map
      title: i+1 + " | " + marker[2]
    )
    marker.setMap(map)

@setCenter = (lat, lng) ->
  centerLoc.lat = lat
  centerLoc.lng = lng

callFxnOnPageLoad = (fxn) ->
  $(document).ready(fxn)
  $(document).on('page:load', fxn)

callFxnOnPageLoad(populate_journey_map)
