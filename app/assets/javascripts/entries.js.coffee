# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

callFxnOnPageLoad = (fxn) ->
  $(document).ready(fxn)
  $(document).on('page:load', fxn)

if navigator.geolocation
  console.log("Geolocation is supported")
else
  console.log("Geolocation is NOT supported")
  if window.location.pathname.match(/.*entries\/new$/)
    $('#find_me').hide()

fill_lat_long_fields = ->
    geoOptions =
      enableHighAccuracy: true
      timeout: 10 * 1000

    geoSuccess = (position) ->
      startPos = position
      lat = document.getElementById('entry_latitude').value = startPos.coords.latitude
      long = document.getElementById('entry_longitude').value = startPos.coords.longitude

    # Handle Geolocation errors
    geoError = (position) ->
      console.log("Geolocation error. Error code: " + error.code)
      # error.code can be:
      #   0: unknown error
      #   1: permission denied
      #   2: position unavailable (error response from location provider)
      #   3: timed out

    navigator.geolocation.getCurrentPosition(geoSuccess, geoError, geoOptions)

getEntries = ->
  $('.entry')

initLocationMap = ->
  if window.location.pathname.match(/.*entries\/new$/)
    map = new Map('map')
    map.initialize()

    entries = getEntries()
    entries.each( ->
      loc = $(this).find('.location').text().split(',')
      title = $(this).find('.title').text()
      options =
        lat: loc[0]
        lng: loc[1]
        title: title
      map.addMarker(options)
    )
    map.connectMarkers()
    map.autoCenter()
    map.enableSetLatLngByClick()

initFindMeButton = ->
  if window.location.pathname.match(/.*entries\/new$/)
    $('#findMe').click (event) ->
      fill_lat_long_fields()
      event.preventDefault()

callFxnOnPageLoad(initLocationMap)
callFxnOnPageLoad(initFindMeButton)
