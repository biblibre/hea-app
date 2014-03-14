var Hea = {};
Hea.donutFromCsv = function(params) {
  var wrapper_id = params.wrapper_id,
      csv_file = params.csv_file,
      width = params.width || 400,
      height = params.height || 400,
      radius = Math.min(width, height) / 2,
      color_range = params.color_range || ["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"],
      outerRadius = params.outerRadius || radius - 10,
      innerRadius = params.innerRadius || radius - 70;


  var color = d3.scale.ordinal()
    .range(color_range);

  var arc = d3.svg.arc()
    .outerRadius(outerRadius)
    .innerRadius(innerRadius);

  var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.count; });

  var svg = d3.select('#' + wrapper_id).append("svg")
      .attr("width", width)
      .attr("height", height)
    .append("g")
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

  d3.csv(csv_file, function(error, data) {
    data.forEach(function(d) {
      d.count = +d.count;
    });

    var g = svg.selectAll(".arc")
        .data(pie(data))
      .enter().append("g")
        .attr("class", "arc");

    g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.value); });

    g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.data.value + " (" + d.data.count + ")"; });
  });
};
