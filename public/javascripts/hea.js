function build_svg (params) {
  var wrapper_id = params.wrapper_id;
  var data = params.data;
  if (!wrapper_id) return;
  if (!data) return;
  var type = params.type || 'barchart';
  if ( type == 'barchart' ) {
    build_barchart(params);
  }
}

function build_barchart (params) {
  var wrapper_id = params.wrapper_id;
  var data = params.data;
  var chart_title = params.title;
  var width = params.width || 400;
  var bar_padding = 1;
  var bar_height = 20;

  var max_variable_name_length = 20;
  var values = [], variables = [];
  $(data).each(function(){
    values.push(Number(this.value));
    variables.push(this.name);
  });

  var height = bar_height * variables.length;

  var left_width = 135;

  var yRangeBand = bar_height + 2;
  y = function(i) { return yRangeBand * i; };

  var max = d3.max(values);
  var x = d3.scale.linear()
    .domain([0, max])
    .range([0, width]);
 
  var chart = d3.select("#charts")
    .append('svg')
    .attr('class', 'chart')
    .attr('width', left_width + width + 40)
    .attr('height', (bar_height) * variables.length + 30)
    .append("g")
    .attr("transform", "translate(-10, 20)");
 
  chart.selectAll("rect")
    .data(values)
    .enter().append("rect")
    .attr("x", left_width)
    .attr("y", function(d, i) { return y(i) })
    .attr("width", x)
    .attr("height", bar_height);
 
  chart
    .append("text")
    .attr("class", "title")
    .attr("x", width /2 )
    .attr("y", 0)
    .attr("dy", -6)
    .attr("text-anchor", "middle")
    .attr("font-size", 14)
    .text(chart_title);

  chart.selectAll("text.value")
    .data(values)
    .enter().append("text")
    .attr("x", function(d) { var xx = x(d); if ( xx < 11 ) xx = 11; return xx + left_width - 1;  })
    .attr("y", function(d, i) { return y(i) + yRangeBand/2;})
    .attr("dx", -5)
    .attr("dy", ".36em")
    .attr("text-anchor", "end")
    .attr('class', 'value')
    .text(String);
 
  chart.selectAll("text.variable")
    .data(variables)
    .enter().append("text")
    .attr("x", left_width / 2)
    .attr("y", function(d, i){ return y(i) + yRangeBand/2; } )
    .attr("dy", ".36em")
    .attr("text-anchor", "middle")
    .attr('class', 'variable')
    .text(function(s) { if ( s == null ) s = 'NULL'; if ( s.length > max_variable_name_length ) { return jQuery.trim(s).substring(0,max_variable_name_length).trim(this) + '...'; } else { return s; } });
}

// FIXME The following needs to be fixed!
// Do we want donut ??
function build_donut (params) {
  var data = params.data;
  var wrapper_id = params.wrapper_id;
  if (!wrapper_id) return;
  if (!data) return;
  var width = params.width || 400;
  var height = params.height || 400;
  var radius = Math.min(width, height) / 2;
  var color_range = params.color_range || ["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"];
  var outerRadius = params.outerRadius || radius - 10;
  var innerRadius = params.innerRadius || radius - 70;

  var color = d3.scale.ordinal()
    .range(color_range);

  var arc = d3.svg.arc()
    .outerRadius(outerRadius)
    .innerRadius(innerRadius);

  var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.value; });

  var svg = d3.select('#' + wrapper_id).append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g")
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

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
      .text(function(d) { return d.data.name + " (" + d.data.value + ")"; });

}

