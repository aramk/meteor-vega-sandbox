Template.pieExample3.rendered = ->
  items = {
    'January': 12
    'February': 23
    'March': 47
    'April': 6
    'May': 52
    'June': 19
  }
  $container = @$('.chart-container')
  chart = new PieChart({
    items: items, width: $container.width(), height: $container.height(), labels: false})
  $container.append(chart.getElement())
