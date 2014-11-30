# You can use CoffeeScript in this file: http://coffeescript.org/

class Marker
  constructor: (@lat, @lng) ->
    @pos = new google.maps.LatLng(lat, lng)
    @title = ''

class @Map
  constructor: (@id) ->
    # Initialize class attributes
    @markers = new Array()
    @markerBounds = new google.maps.LatLngBounds()
    @geolocationSupported = false
    @map = "Uninitialized Map Object"
    @options = 
      center:
        lat: 1
        lng: 1
      zoom: 8

    if navigator.geolocation
      @geolocationSupported = true

    # Set default dimensions
    @setDimensions('100%', '300px')

  # Map methods
  # ---------------------------------------------------------------------------
  addMarker: (options) ->
    markerOptions =
      map: @map
    if options.lat && options.lng
      loc = new google.maps.LatLng(options.lat, options.lng)
      @markerBounds.extend(loc)
      markerOptions.position = loc
    else
      console.error 'ERROR Creating marker: Undefined latitude or longitude.'

    if options.title
      markerOptions.title = options.title
    else
      console.error 'ERROR Creating marker: Undefined title.'

    if options.url
      markerOptions.url = options.url
    else
      console.error 'ERROR Creating marker: Undefined url.'

    if options.info
      markerOptions.info = options.info

    marker = new google.maps.Marker(markerOptions)
    marker.setMap(@map)

    @markers.push(marker)
    @addInfoWindow(marker)


  addInfoWindow: (marker) ->
    if marker.info
      infoWindow = new google.maps.InfoWindow(
        content: marker.info
        visible: false
      )

      # Set up info window
      google.maps.event.addListener(marker, 'click', () ->
        if infoWindow.visible == false
          infoWindow.open(@map, this)
          infoWindow.visible = true
        else
          infoWindow.close()
          infoWindow.visible = false
      )
    else
      console.error 'ERROR creaing infoWindow: marker object has no property \'info\''

  connectMarkers: (pathOptions) ->
    if !pathOptions then pathOptions = {}
    coords = []
    for marker in @markers
      coords.push marker.position

    # Set default pathOptions if not overridden
    pathOptions.path = coords
    if !pathOptions.geodesic then pathOptions.geodesic = true
    if !pathOptions.strokeColor then pathOptions.strokeColor = '#FF0000'
    if !pathOptions.strokeOpacity then pathOptions.strokeOpacity = 1.0
    if !pathOptions.strokeWeight then pathOptions.strokeWeight = 2

    path = new google.maps.Polyline pathOptions
    path.setMap(@map)












  setupMap: () ->
    @map = new google.maps.Map(document.getElementById(@id), @options)

  initialize: ->
    google.maps.event.addDomListener(window, 'load', @setupMap())

  setCenter: (lat, lng) ->
    @options.center.lat = lat
    @options.center.lng = lng

  autoCenter: () ->
      @map.fitBounds(@markerBounds)

  ###
  showMarkers: () ->
    coords = new Array()

    for m, i in @markers
      loc = new google.maps.LatLng(m.lat, m.lng)
      coords.push loc

      # Grow the map's boundaries to include each marker
      @markerBounds.extend(loc)

      markerOptions =
        position: loc
        map: @map
      if m.title
        markerOptions.title = i+1 + " | " + m.title
      if m.url
        markerOptions.url = m.url

      marker = new google.maps.Marker(markerOptions)
      marker.setMap(@map)

      # Set up on-click event
      #google.maps.event.addListener(marker, 'click', () ->
        #window.location.href = this.url
      #)

      info = '<h1>' + m.title + '</h1>'
      
      infoWindow = new google.maps.InfoWindow(
        content: info
      )
      
      # Set up info window
      google.maps.event.addListener(marker, 'click', () ->
        infoWindow.open(@map, this)
      )

    path = new google.maps.Polyline(
      path: coords
      geodesic: true
      strokeColor: '#FF0000'
      strokeOpacity: 1.0
      strokeWeight: 2
    )

    path.setMap(@map)
  ###

  # DOM methods
  # ---------------------------------------------------------------------------
  setDimensions: (width, height) ->
    document.getElementById(@id).style.width = width
    document.getElementById(@id).style.height = height


$(document).ready( ->
  if window.location.pathname.match(/^\/$/)
    m1 = new Map('map')
    m1.setCenter(37, -121)
    m1.initialize()
    m1.addMarker(37.2, -121, 'Marker 1')
    m1.addMarker(36.8, -121)
    m1.showMarkers()
)
