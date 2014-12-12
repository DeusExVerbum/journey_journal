# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

callFxnOnPageLoad = (fxn) ->
  $(document).ready(fxn)
  $(document).on('page:load', fxn)

initJourneyMap = ->
  if window.location.pathname.match(/.*journeys\/[0-9]+$/)
    map = new Map('map')
    map.setDimensions('100%', '500px')
    map.initialize()

    $('#entry_list .entry').each( ->
      loc = $(this).find('.location').text().split(',')
      title = $(this).find('.title').text()
      url = $(this).find('.url').text()
      index = $(this).find('.index').text()
      options =
        lat: loc[0]
        lng: loc[1]
        title: title
        #url: url
        info: '<h3>' + index + '. <a href="' + url + '">' + title + '</a></h3>'
      map.addMarker(options)
    )

    map.connectMarkers()
    map.autoCenter()
  if window.location.pathname.match(/^\/$/)
    console.log 'app'
    map = new Map('map')
    map.setDimensions('100%', '100%')
    map.initialize()

    $('.entry').each( ->
      loc = $(this).find('.location').text().split(',')
      title = $(this).find('.title').text()
      url = $(this).find('.url').text()
      author = $(this).find('.author').text()
      author_url = $(this).find('.author_url').text()
      journey_url = $(this).find('.journey_url').text()
      options =
        lat: loc[0]
        lng: loc[1]
        title: title
        #url: url
        info: ''
      options.info = '<h3><a href="' + url + '">' + title + '</a></h3>'
      options.info += '<p>Read the whole <a href="' + journey_url + '">Journey</a></p>'
      options.info += '<br>'
      options.info += '<p><span class="fa fa-user"></span> <a href="' + author_url + '">' + author + '</a></h3>'
      map.addMarker(options)
    )

    #map.setZoom(2)
    map.autoCenter()
    #map.setCenter(32, -6)

callFxnOnPageLoad(initJourneyMap)
