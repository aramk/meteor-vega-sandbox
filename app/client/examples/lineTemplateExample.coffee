Template.lineTemplateExample.helpers

  items: ->
    'MSFT':
      'Jan 1 2000': 39.81
      'Feb 1 2005': 36.35
      'Mar 1 2010': 43.22
    'AMZN':
      'Jan 1 2000': 64.56
      'Feb 1 2005': 68.87
      'Mar 1 2010': 67
    'IBM':
      'Jan 1 2000': 100.52
      'Feb 1 2005': 92.11
      'Mar 1 2010': 106.11

  settings: ->
    labels:
      x: 'Date'
      y: 'Price'
    width: 400
    height: 200
    format:
      x: 'date'
