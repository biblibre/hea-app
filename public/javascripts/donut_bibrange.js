var width = 350,
height = 400,
radius = Math.min(width, height) / 2;

var color = d3.scale.ordinal()
.range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

var arc2 = d3.svg.arc()
.outerRadius(radius - 10)
.innerRadius(radius - 70);

var pie2 = d3.layout.pie()
.sort(null)
.value(function(d2) { return d2.number; });

var svg2 = d3.select("#donut_bibrange").append("svg")
.attr("width", width)
.attr("height", height)
.append("g")
.attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

d3.csv("../data/donut_bibrange.csv", function(error2, data2) {

data2.forEach(function(d2) {
d2.number = +d2.number;
});

var g2 = svg2.selectAll(".arc2")
  .data(pie2(data2))
.enter().append("g")
  .attr("class", "arc2");

g2.append("path")
  .attr("d", arc2)
  .style("fill", function(d2) { return color(d2.data.bibrange); });

g2.append("text")
  .attr("transform", function(d2) { return "translate(" + arc2.centroid(d2) + ")"; })
  .attr("dy", ".35em")
  .style("text-anchor", "middle")
  .text(function(d2) { return d2.data.bibrange + "(" + d2.data.number + ")"; });
});

