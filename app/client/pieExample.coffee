createPopup = (data) ->
  html = '<div class="chart-popup"></div>'
  $em = $(html)
  title = data.title
  body = data.title
  $em.append($('<div class="title">' + title + '</div>')) if title?
  $em.append($('<div class="body">' + body + '</div>')) if body?
  $em

setPositionFromEvent = ($em, event) ->
  $em.css('left', event.clientX)
  $em.css('top', event.clientY)

Template.pieExample.rendered = ->
  Vega.render('/vega/pie.json', @$('.chart-container')).then (args) ->
    console.log('pie', args)
    view = args.view
    popups = []
    view.on 'mouseover', (event, item) ->
      data = item.datum.data
      index = item.datum.index
      $popup = popups[index]
      unless $popup
        $popup = createPopup(title: data.label, body: data.value)
        popups[index] = $popup
        $('body').append($popup)
      $popup.show()
      setPositionFromEvent($popup, event)
      console.log('mouseover')
    view.on 'mousemove', (event, item) ->
      console.log('mousemouse')
      index = item.datum.index
      $popup = popups[index]
      setPositionFromEvent($popup, event)
    view.on 'mouseout', (event, item) ->
      console.log('mouseout')
      index = item.datum.index
      $popup = popups[index]
      $popup.hide() if $popup
