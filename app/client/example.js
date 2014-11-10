Template.example.rendered = function() {
  console.log('Dependencies', d3, vg);
  // parse a spec and create a visualization view
  function parse(spec) {
    vg.parse.spec(spec, function(chart) {
      chart({
        el: "#vis"
      }).update();
    });
  }
  parse('/vega/bar.json');
}
