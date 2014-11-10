TemplateClass = Template.pieChart
TemplateClass.rendered = ->
  $chart = @$('.chart')
  items = generateItems(@data.items)
  addColors(items, @data.colors ? DEFAULT_COLORS)
  spec = generateSpec(_.extend(@data, {values: items}))
  valueSum = Maths.sum items, (item) -> item.value
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
    view.on 'mousemove', (event, item) ->
      index = item.datum.index
      $popup = popups[index]
      setPositionFromEvent($popup, event)
    view.on 'mouseout', (event, item) ->
      index = item.datum.index
      $popup = popups[index]
      $popup.hide() if $popup

generateSpec = (args) ->
  args = _.extend({
    width: 400
    height: 400
    paddingForText: 16
    titles: true
  }, args)
  values = args.values
  width = args.width
  height = args.height
  paddingForText = args.paddingForText
  radius = args.radius ? Math.min(height, width) / 2 - paddingForText
  spec = _.extend({
    width: width,
    height: height,
    data: [
      {
        name: 'table',
        values: values,
        transform: [
          {type: 'pie', value: 'data.value'}
        ]
      }
    ],
    marks: [
      {
        type: 'arc',
        from: {data: 'table'},
        properties: {
          enter: {
            x: {group: 'width', mult: 0.5},
            y: {group: 'height', mult: 0.5},
            startAngle: {field: 'startAngle'},
            endAngle: {field: 'endAngle'},
            innerRadius: {value: 0},
            outerRadius: {value: radius},
            stroke: {value: '#fff'}
          },
          update: {
            fill: {field: 'data.color'},
            fillOpacity: {value: 1}
          },
          hover: {
            fillOpacity: {value: 0.6}
          }
        }
      }
    ]
  }, args)
  if args.titles
    spec.marks.push({
      type: 'text',
      from: {data: 'table'},
      properties: {
        enter: {
          x: {group: 'width', mult: 0.5},
          y: {group: 'height', mult: 0.5},
          radius: {value: radius, offset: paddingForText / 2},
          theta: {field: 'midAngle'},
          fill: {value: '#000'},
          align: {value: 'center'},
          baseline: {value: 'middle'},
          text: {field: 'data.label'}
        },
        hover: {
          text: {field: 'data.value'}
        }
      }
    })
  spec

generateItems = (values) ->
  if Types.isObject(values)
    items = []
    _.each values, (value, label) ->
      item = if Types.isObject(value) then value else {value: value}
      item.label = label
      items.push(item)
  else if Types.isArray(values)
    items = values
  else
    throw new Error('Invalid arguments')
  items

addColors = (values, colors) ->
  itemColors = generateUniqueColors(colors, values.length)
  _.each values, (item, i) ->
    item.color = itemColors[i]

generateUniqueColors = (colors, size) ->
  colors = _.shuffle(colors)
  results = []
  colorsLen = colors.length
  _.times size, (i) ->
    if i < colorsLen
      results.push(colors[i])
    else
      color = results[i - colorsLen]
      results.push(tinycolor(color).darken(0.1).toHexString())
  results

DEFAULT_COLORS = [
  '#ff1414'
  '#ff9314'
  '#ffba14'
  '#f9ec15'
  '#75b313'
  '#0095ca'
  '#3676ff'
  '#7c3dff'
  '#7f0894'
  '#b6095b'
]

createPopup = (data) ->
  $em = $('<div class="chart-popup"></div>')
  title = data.title
  body = data.body
  $em.append($('<div class="title">' + title + '</div>')) if title?
  $em.append($('<div class="body">' + body + '</div>')) if body?
  $em

setPositionFromEvent = ($em, event) ->
  offset = {x: 10, y: 0}
  $em.css('left', event.clientX + offset.x)
  $em.css('top', event.clientY + offset.y)
