# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

callFxnOnPageLoad = (fxn) ->
  $(document).ready(fxn)
  $(document).on('page:load', fxn)

getEntries = ->
  $('.entry')

initLocationMap = ->
  if window.location.pathname.match(/.*entries\/new$/)
    map = new Map('map')
    map.setDimensions('100%', '300px')
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

  if window.location.pathname.match(/.*entries\/[0-9]+\/edit$/)
    console.log 'edit.html.erb map'
    map = new Map('map')
    map.setDimensions('100%', '300px')
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

  if window.location.pathname.match(/.*journeys\/[0-9]+\/entries\/[0-9]+$/)
    map = new Map('map')
    map.setDimensions('100%', '200px')
    map.initialize()

    entries = getEntries()
    entries.each( ->
      loc = $(this).find('.location').text().split(',')
      title = $(this).find('.title').text()
      options =
        lat: loc[0]
        lng: loc[1]
        title: title
        icon:
          fillColor: '#2C3E50'

      if $(this).hasClass('focus')
        options.icon.fillColor = '#E74C3C'
        map.setCenter(options.lat, options.lng)
        map.setZoom(16)

      map.addMarker(options)
    )

    map.connectMarkers({strokeColor: '#2C3E50'})

callFxnOnPageLoad(initLocationMap)
