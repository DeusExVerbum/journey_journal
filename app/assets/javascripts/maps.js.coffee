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
        lat: 0
        lng: 0
      zoom: 1

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
      return

    if options.title
      markerOptions.title = options.title

    if options.url
      markerOptions.url = options.url

    if options.info
      markerOptions.info = options.info

    marker = new google.maps.Marker(markerOptions)
    marker.setMap(@map)

    @markers.push(marker)
    @setMarkerClickEvent(marker)

  removeMarker: (index) ->
    if !index
      console.error 'Cannot removeMarker without an index.'

    # -1 indicates we should remove the last element
    if index == -1
      # Hide it from the map
      @markers[@markers.length - 1].setMap(null)
      # Remove it
      @markers = @markers.splice(@markers.length-1, 1)
    else
      # Hide it from the map
      @markers[index].setMap(null)
      # Remove it
      @markers = @markers.splice(index, 1)

  setMarkerClickEvent: (marker) ->
    if marker.info && marker.url
      console.error 'ERROR: two onClick events are specified (infoWindow and Link)'
    else
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
      else if marker.url
        # Set up on-click event
        google.maps.event.addListener(marker, 'click', () ->
          window.location.href = this.url
        )

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

    @path = new google.maps.Polyline pathOptions
    @path.setMap(@map)

  disconnectMarkers: () ->
    if !@path
      console.log 'Cannot disconnectMarkers until markers are connected'
      return

    @path.setMap(null)


  enableSetLatLngByClick: () ->
    _this = @
    newMarkerSet = false

    google.maps.event.addListener(@map, 'click', (e) ->
      if !newMarkerSet
        newMarkerSet = true
      else
        _this.removeMarker(-1)

      @panTo e.latLng

      _this.addMarker(
        lat: e.latLng.k
        lng: e.latLng.B
      )

      document.getElementById('entry_latitude').value = e.latLng.k
      document.getElementById('entry_longitude').value = e.latLng.B
    )









  setupMap: () ->
    @map = new google.maps.Map(document.getElementById(@id), @options)

  initialize: ->
    google.maps.event.addDomListener(window, 'load', @setupMap())

    if navigator.geolocation
      @geolocationSupported = true
      @addLocateMeButton(@map)

  setCenter: (lat, lng) ->
    @options.center.lat = lat
    @options.center.lng = lng

  autoCenter: () ->
    if @markers.length > 0 
      @map.fitBounds(@markerBounds)
    else
      console.error 'Cannot autoCenter map. There are no markers to center on'

  addLocateMeButton: (map) ->
    if !navigator.geolocation
      console.error 'Geolocation not supported: Cannot add locateMe button.'
      return
    else
      centerOnUserLocation = () ->
        geoOptions =
          enableHighAccuracy: true
          timeout: 10 * 1000

        geoSuccess = (position) ->
          userLoc = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
          map.setCenter(userLoc)
          map.setZoom(14)

        # Handle Geolocation errors
        geoError = (position) ->
          # error.code can be:
          #   0: unknown error
          #   1: permission denied
          #   2: position unavailable (error response from location provider)
          #   3: timed out
          console.log("Geolocation error. Error code: " + error.code)

        navigator.geolocation.getCurrentPosition(geoSuccess, geoError, geoOptions)

      LocateMeControl = (controlDiv, map) ->
        controlDiv.style.padding = '5px'

        # Set CSS styles for the DIV containing the control
        # Setting padding to 5 px will offset the control
        # from the edge of the map
        controlDiv.style.padding = '5px'

        # Set CSS for the control border
        controlUI = document.createElement 'div'
        controlUI.style.backgroundColor = 'white'
        controlUI.style.borderStyle = 'solid'
        controlUI.style.borderWidth = '2px'
        controlUI.style.cursor = 'pointer'
        controlUI.style.textAlign = 'center'
        controlUI.title = 'Click to set the map to Home'
        controlDiv.appendChild controlUI

        # Set CSS for the control interior
        controlText = document.createElement 'div'
        controlText.style.fontFamily = 'Arial,sans-serif'
        controlText.style.fontSize = '12px'
        controlText.style.paddingLeft = '4px'
        controlText.style.paddingRight = '4px'
        controlText.innerHTML = '<strong>Find Me</strong>'
        controlUI.appendChild controlText

        # Setup the click event listeners: simply set the map to
        # Chicago
        google.maps.event.addDomListener(controlUI, 'click', () ->
          centerOnUserLocation()
        )

      # Create the DIV to hold the control and
      # call the HomeControl() constructor passing
      # in this DIV.
      lmcDiv = document.createElement 'div'
      lmc = new LocateMeControl lmcDiv, @map

      lmcDiv.index = 1
      @map.controls[google.maps.ControlPosition.TOP_RIGHT].push lmcDiv

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
