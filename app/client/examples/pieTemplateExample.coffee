Template.pieTemplateExample.helpers

  items: ->
    {
      'January': 12
      'February': 23
      'March': 47
      'April': 6
      'May': 52
      'June': 19
    }

  formatter: ->
    df = Q.defer()
    df.resolve((value) -> '[' + value + ']')
    df.promise
