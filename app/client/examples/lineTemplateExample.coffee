Template.lineTemplateExample.helpers

  items: ->
    'MSFT': [
      {x: 'Jan 1 2000', y: 39.81}
      {x: 'Feb 1 2005', y: 36.35}
      {x: 'Mar 1 2010', y: 43.22}
    ]
    'AMZN': [
      {x: 'Jan 1 2000', y: 64.56}
      {x: 'Feb 1 2005', y: 68.87}
      {x: 'Mar 1 2010', y: 67}
    ]
    'IBM': [
      {x: 'Jan 1 2000', y: 100.52}
      {x: 'Feb 1 2005', y: 92.11}
      {x: 'Mar 1 2010', y: 106.11}
    ]

  settings: ->
    labels:
      x: 'Date'
      y: 'Price'
    width: 400
    height: 200
    resize: true
    title: 'Line Chart Test'
    format:
      x: 'date'
