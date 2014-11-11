createPopup = (data) ->
  html = '<div class="chart-popup"></div>'
  $em = $(html)
  title = data.title
  body = data.body
  $em.append($('<div class="title">' + title + '</div>')) if title?
  $em.append($('<div class="body">' + body + '</div>')) if body?
  $em

setPositionFromEvent = ($em, event) ->
  offset = {x: 10, y: 0}
  $em.css('left', event.clientX + offset.x)
  $em.css('top', event.clientY + offset.y)

calcValuesSum = (data) -> _.reduce data, ((memo, datum) -> memo + datum.value), 0

Template.pieExample.rendered = ->
  $chart = @$('.chart')
  Vega.getSpec('/vega/pie.json').then (spec) ->
    values = spec.data[0].values
    valueSum = calcValuesSum(values)
    Vega.render(spec, $chart).then (args) ->
      view = args.view
      popups = []
      view.on 'mouseover', (event, item) ->
        data = item.datum.data
        index = item.datum.index
        $popup = popups[index]
        unless $popup
          value = data.value
          percentage = value / valueSum
          body = data.value + ' (' + Strings.format.percentage(percentage) + ')'
          $popup = createPopup(title: data.label, body: body)
          popups[index] = $popup
          $('body').append($popup)
        $popup.show()
        setPositionFromEvent($popup, event)
        console.log('mouseover')
      view.on 'mousemove', (event, item) ->
        index = item.datum.index
        $popup = popups[index]
        setPositionFromEvent($popup, event)
      view.on 'mouseout', (event, item) ->
        index = item.datum.index
        $popup = popups[index]
        $popup.hide() if $popup
