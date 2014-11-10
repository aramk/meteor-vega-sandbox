Template.barExample.rendered = ->
  Vega.render('/vega/bar.json', @$('.chart-container'), {resize: true})
