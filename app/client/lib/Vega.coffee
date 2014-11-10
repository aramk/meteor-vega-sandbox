# TODO(aramk) Include this in aramk:vega.

@Vega =

  # Renders the given spec in the given element.
  # @param {Object|String} spec - The Vega spec in JSON format or a URL.
  # @param {jQuery|HTMLElement} el - The HTML element to render the chart in.
  # @param {Object} [options]
  # @param {Boolean} [options.resize] - Whether to resize the chart based on the dimensions of the
  # given HTML element.
  # @returns {$.Deferred}
  render: (spec, el, options) ->
    options = _.extend({
      resize: false
    }, options)
    df = $.Deferred()
    $el = $(el)
    @getSpec(spec).then(
      (spec) ->
        if options.resize
          padding = _.extend({top: 0, bottom: left: 0, right: 0}, spec.padding)
          spec.width = $el.width() - padding.left - padding.right
          spec.height = $el.height() - padding.top - padding.bottom
        vg.parse.spec spec, (chart) ->
          view = chart(el: $el[0]).update()
          df.resolve(chart: chart, view: view)
      df.reject
    )
    df

  # @param {Object|String} spec - The Vega spec in JSON format or a URL.
  # @returns {$.Deferred} A promise containing the Vega spec in JSON format.
  getSpec: (spec) ->
    if Types.isString(spec)
      specDf = @requestSpec(spec)
    else
      specDf = $.Deferred()
      specDf.resolve(spec)
    specDf

  # @param {String} url - The URL to the Vega spec.
  # @returns {$.Deferred} A promise containing the Vega spec in JSON format.
  requestSpec: (url) -> $.getJSON(url)
