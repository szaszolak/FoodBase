//$(window).on('load',
	//function() {
function bar_chart(url){
				//setup canvas for chart

				var width = $('#charts').width();
				$('#charts').css('display','none');
      //  $('#charts').append("<a class='btn btn-default' role='button' href='"+url.replace("show", "chart")+"'>Pobierz</a>" );
		//		$('#charts').append("<div class=\"checkbox\"><label><input id=\"error-bars-switch\" data-toggle=\"toggle\" type=\"checkbox\" data-on=\"Pokaż\" data-off=\"Ukryj\">Odchylenie standardowe</label></div><link href=\"https://gitcdn.github.io/bootstrap-toggle/2.2.0/css/bootstrap-toggle.min.css\" rel=\"stylesheet\"><script src=\"https://gitcdn.github.io/bootstrap-toggle/2.2.0/js/bootstrap-toggle.min.js\"></script>");
				
				width = width>720?720:width;
				var height = width/2;
				var margin = {top: 30, right: 150, bottom: 30, left: 40},
   				width = width - margin.left - margin.right,
    			height = height - margin.top - margin.bottom;




				d3.json(url)
        .header("Content-Type", "application/json")
        .header("Accept", "application/json")
        .get(function(error,data){
						var i = 0;
					//	_.each(data.metrics,function(metric){
						
							var div = '<svg class="chart chart-'+i+'"></svg>'
							$('#charts').append(div);

							var chart = d3.select(".chart-"+i)
						   		 .attr("width", width + margin.left + margin.right)
						   		 .attr("height", height + margin.top + margin.bottom)
						 		 .append("g")
						   		 .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		    			var x = d3.scale.ordinal()
		  				  .rangeRoundBands([0, width],.2,1);//,calculateOuterPadding(metric.samples.length,width,100));

						var y = d3.scale.linear()
						    .range([height, 0]);

						var xAxis = d3.svg.axis()
						    .scale(x)
						    .orient("bottom")
                 .tickFormat(function (d) {
                      return d.split('#')[1];
                    });

						var yAxis = d3.svg.axis()
				  		  .scale(y)
				   		  .orient("left")
				   		  .outerTickSize(0);
               

							draw(data.experiments,chart,data.name,x,y,xAxis,yAxis,data.competitors);
							i++;
						//})	
						 $('#error-bars-switch').on('change',  function(e) {
							toggleErrorBars();
    						});

$('#charts').show('quick');
})


function draw(data,chart,title,x,y,xAxis,yAxis){
		_.each(data,type);

    var prodIds = _.uniq(_.map(data,function(c){return c.prod_id}));
    var prods = []
     _.each(prodIds,function(c){prods.push({id: c, name:_.find(data,function(x){return x.prod_id == c}).prod_name})});

	  x.domain(data.map(function(d) { return d.prod_id+'#'+d.name; }))
 	  y.domain([0, d3.max(data, function(d) { return d.value + d.deviation; })])
		var c20 = d3.scale.category20();			

  chart.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  chart.append("g")
      .attr("class", "y axis")
      .call(yAxis);

 var bar= chart.selectAll(".bar")
      .data(data)
    .enter().append("g")
      .attr("transform", function(d,i) { return "translate(" + x(d.prod_id+'#'+d.name) + ",0)"; });
    bar.append("rect")
      .attr("class", "bar")
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .attr("width", x.rangeBand())
      .attr("fill", function(d){ 
        return c20(prodIds.indexOf(d.prod_id));
       });

var lineFunction = d3.svg.line()
                        .x(function(ele) { return ele.x; })
                         .y(function(ele) { return ele.y; })
                         .interpolate("linear");

    var errorBar = bar.data(data).append("path")
    							.attr("d",function(d){return lineFunction([{"x": 2*x.rangeBand()/6,"y":y(d.value - d.deviation)},{"x": 4*x.rangeBand()/6,"y":y(d.value - d.deviation)},
    							{"x": x.rangeBand()/2,"y":y(d.value - d.deviation)},{"x": x.rangeBand()/2,"y":y(d.value + d.deviation)}		
    							,{"x": 2*x.rangeBand()/6,"y":y(d.value + d.deviation)},{"x": 4*x.rangeBand()/6,"y":y(d.value + d.deviation)}]
    						)})
    					 .attr("stroke-width", 2)
                         .attr("stroke", "red")
                         .attr("fill", "none")
                         //.attr("display","none")
                         .attr("class","error-bar");
                         /*.append("line")
                          .attr("x1", x.rangeBand()/2)
                          .attr("y1", function(d) { return y(d.value - d.deviation); } )
                         .attr("x2",  x.rangeBand()/2)
                         .attr("y2",  function(d) { return y(d.value + d.deviation); })  
                         .attr("stroke-width", 2)
                         .attr("stroke", "red");
*/
      chart.append("text")
        .attr("x", (width / 2))             
        .attr("y", 5 - (margin.top / 2))
        .attr("text-anchor", "middle")  
        .style("font-size", "16px") 
        .style("text-decoration", "underline")  
        .text(title);

  bar.append("text")
      .attr("x", x.rangeBand() / 2)
      .attr("y", function(d) { return y(d.value) + 6; })
      .attr("dy", ".75em")
      .attr("fill","white")
      .attr("font-weight","bold")
      .attr("text-anchor","middle")
      .text(function(d) {
       return d.value.toFixed(2);
        });

  var legend = chart.selectAll('.g')
        .data(prods)
        .enter()
      .append('g')
        .attr('class', 'legend');

    legend.append('rect')
        .attr('x', width - 20)
        .attr('y', function(d, i){ return i *  20;})
        .attr('width', 10)
        .attr('height', 10)
        .style('fill', function(d) { 
          return c20(prodIds.indexOf(d.id));
        });

    legend.append('text')
        .attr('x', width - 8)
        .attr('y', function(d, i){ return (i *  20) + 9;})
        .text(function(d){ return d.name; });

  if(data.length<=0)
  {
    chart.append("text")
        .attr("x", (width / 2))             
        .attr("y", height/2)
        .attr("text-anchor", "middle")  
        .style("font-size", "16px") 
        .text("Brak danych!");
  }
}

function calculateOuterPadding(barsCount,width,padding){
	return (width - (barsCount+padding)*barsCount-padding)/2; 
}


function type(d) {
  d.value =parseFloat(d.value); // coerce to number
  d.deviation = parseFloat(d.deviation);
}

function toggleErrorBars(){
	if($('.error-bar').css('display') != 'none')
		$('.error-bar').css('display','none');
	else
		$('.error-bar').css('display','inline');
}


}
//});
