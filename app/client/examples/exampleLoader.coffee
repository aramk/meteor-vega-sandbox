Template.exampleLoader.rendered = ->
  # Delay loading of examples so we can debug the code.
  _.delay(
    -> Blaze.render(Template.examples, @$('.container')[0])
    500
  )
