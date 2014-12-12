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
    @styledMap = "Uninitialized Map Object"
    @options = 
      center:
        lat: 0
        lng: 0
      zoom: 1
      disableDefaultUI: true
    @mapStyles =
      [
        {
          featureType: "administrative"
          elementType: "all"
          stylers: [visibility: "on"]
        }
        {
          featureType: "administrative"
          elementType: "geometry.fill"
          stylers: [color: "#ecf0f1"]
        }
        {
          featureType: "administrative"
          elementType: "labels.text.fill"
          stylers: [color: "#444444"]
        }
        {
          featureType: "landscape"
          elementType: "all"
          stylers: [
            {
              color: "#ecf0f1"
            }
            {
              visibility: "on"
            }
          ]
        }
        {
          featureType: "landscape"
          elementType: "labels.text.fill"
          stylers: [color: "#444444"]
        }
        {
          featureType: "landscape"
          elementType: "labels.text.stroke"
          stylers: [color: "#f2f2f2"]
        }
        {
          featureType: "poi"
          elementType: "all"
          stylers: [visibility: "off"]
        }
        {
          featureType: "road"
          elementType: "all"
          stylers: [
            {
              saturation: -100
            }
            {
              lightness: 45
            }
          ]
        }
        {
          featureType: "road"
          elementType: "labels.text.fill"
          stylers: [lightness: "-30"]
        }
        {
          featureType: "road.highway"
          elementType: "all"
          stylers: [visibility: "simplified"]
        }
        {
          featureType: "road.arterial"
          elementType: "labels.icon"
          stylers: [visibility: "off"]
        }
        {
          featureType: "transit"
          elementType: "all"
          stylers: [visibility: "off"]
        }
        {
          featureType: "water"
          elementType: "all"
          stylers: [
            {
              visibility: "on"
            }
            {
              color: "#2980b9"
            }
          ]
        }
        {
          featureType: "water"
          elementType: "labels.text"
          stylers: [visibility: "on"]
        }
        {
          featureType: "water"
          elementType: "labels.text.fill"
          stylers: [
            {
              saturation: "0"
            }
            {
              lightness: "0"
            }
            {
              color: "#222222"
            }
            {
              visibility: "simplified"
            }
          ]
        }
        {
          featureType: "water"
          elementType: "labels.text.stroke"
          stylers: [
            {
              weight: "1"
            }
            {
              saturation: "0"
            }
            {
              lightness: "0"
            }
            {
              color: "#f2f2f2"
            }
            {
              visibility: "simplified"
            }
          ]
        }
      ]


    # Set default dimensions
    #@setDimensions('100%', '300px')

  # Map methods
  # ---------------------------------------------------------------------------
  addMarker: (options) ->
    markerOptions =
      map: @map
      icon:
        path: MAP_PIN
        fillColor: '#E74C3C'
        fillOpacity: 1
        strokeColor: '#000'
        strokeWeight: 1
        scale: 1/4
      label: '<i class="map-icon-parking"></i>'

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

    # Icon options
    if options.icon?
      if options.icon.fillColor?
        markerOptions.icon.fillColor = options.icon.fillColor

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
    if !pathOptions.strokeColor then pathOptions.strokeColor = '#E74C3C'
    if !pathOptions.strokeOpacity then pathOptions.strokeOpacity = 1.0
    if !pathOptions.strokeWeight then pathOptions.strokeWeight = 2

    @path = new google.maps.Polyline pathOptions
    @path.setMap(@map)

  disconnectMarkers: () ->
    if !@path
      console.log 'Cannot disconnectMarkers until markers are connected'
      return

    @path.setMap(null)


  enableSetLatLngByClick: (delete_most_recent_marker) ->
    _this = @

    google.maps.event.addListener(@map, 'click', (e) ->
      if delete_most_recent_marker
        _this.removeMarker(-1)

      @panTo e.latLng

      console.log e
      _this.addMarker(
        lat: e.latLng.k
        lng: e.latLng.D
      )

      document.getElementById('entry_latitude').value = e.latLng.k
      document.getElementById('entry_longitude').value = e.latLng.D
    )









  setupMap: () ->
    @styledMap = new google.maps.StyledMapType(@mapStyles, {name: "Styled Map"})
    @options.mapTypeControlOptions = {
      mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_styles']
    }
    @map = new google.maps.Map(document.getElementById(@id), @options)

    @map.mapTypes.set('map_style', @styledMap)
    @map.setMapTypeId('map_style')

    
  initialize: ->
    google.maps.event.addDomListener(window, 'load', @setupMap())

    if navigator.geolocation
      @geolocationSupported = true
      @addLocateMeButton(@map)

  setCenter: (lat, lng) ->
    @options.center.lat = lat
    @options.center.lng = lng
    loc = new google.maps.LatLng(lat, lng)
    @map.setCenter(loc)

  setZoom: (zoomLevel) ->
    @map.setZoom(zoomLevel)

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
        controlUI.style.backgroundColor = '#FFFFFF'
        controlUI.style.borderStyle = 'solid'
        controlUI.style.borderWidth = '1px'
        controlUI.style.cursor = 'pointer'
        controlUI.style.textAlign = 'center'
        controlUI.title = 'Click to center the map on your location.'
        controlDiv.appendChild controlUI

        # Set CSS for the control interior
        controlText = document.createElement 'div'
        controlText.style.fontSize = '28px'
        controlText.style.paddingLeft = '2px'
        controlText.style.paddingRight = '3px'
        controlText.innerHTML = '<i class="fa fa-location-arrow"></i>'
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
