Template.lineTemplateExample.helpers

  items: ->
    'MSFTWEFEWFEWFWEFWEFEWFEWEWFWFWFWEFEWFWEFEW': {
      values: [
        {x: 'Jan 1 2000', y: 39000000.81}
        {x: 'Feb 1 2005', y: 36000000.35}
        {x: 'Mar 1 2010', y: 43000000.22}
      ]
    }
    'AMZN': {
      color: 'yellow'
      values: [
        {x: 'Jan 1 2000', y: 64000000.56}
        {x: 'Feb 1 2005', y: 68000000.87}
        {x: 'Mar 1 2010', y: 67000000}
      ]
    }
    'IBM': {
      color: 'blue'
      values: [
        {x: 'Jan 1 2000', y: 100000000.52}
        {x: 'Feb 1 2005', y: 92000000.11}
        {x: 'Mar 1 2010', y: 106000000.11}
      ]
    }

  settings: ->
    labels:
      x: 'Date'
      y: 'Price'
    width: 400
    height: 200
    resize: false
    title: 'Line Chart Test'
    format:
      x: 'date'
    # axes:
    #   x:
    #     format: '04,'
