# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

callFxnOnPageLoad = (fxn) ->
  $(document).ready(fxn)
  $(document).on('page:load', fxn)

getEntries = ->
  $('.entry')

initJourneyMap = ->
  if window.location.pathname.match(/.*journeys\/[0-9]+$/)
    map = new Map('map')
    map.initialize()

    entries = getEntries()
    entries.each( ->
      loc = $(this).find('.location').text().split(',')
      title = $(this).find('.title').text()
      #url = $(this).find('.url').text()
      options =
        lat: loc[0]
        lng: loc[1]
        title: title
        #url: url
        info: '<p>Extra special information about \'' + title + '\'</p>'
      map.addMarker(options)
    )

    map.connectMarkers()
    map.autoCenter()

callFxnOnPageLoad(initJourneyMap)
