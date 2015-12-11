$(window).on('load',
	function() {
				//setup canvas for chart
				var width = $('#content').width();
				width = width>512?512:width;
				var height = width/2;
				var margin = {top: 20, right: 30, bottom: 30, left: 40},
   				width = width - margin.left - margin.right,
    			height = height - margin.top - margin.bottom;




				d3.json($('div[product-id]').attr('product-id')+'.json',
					function(error,data){
						var i = 0;
						_.each(data.metrics,function(metric){
						
							var div = '<svg class="chart chart-'+i+'"></svg>'
							$('#content').append(div);

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
						    .orient("bottom");

						var yAxis = d3.svg.axis()
				  		  .scale(y)
				   		  .orient("left");
							draw(metric.samples,chart,metric.name,x,y,xAxis,yAxis);
							i++;
						})	
					
})
		

function draw(data,chart,title,x,y,xAxis,yAxis){
		_.each(data,type);
	  x.domain(data.map(function(d) { return d.name; }))
 	  y.domain([0, d3.max(data, function(d) { return d.value; })])
					

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
      .attr("transform", function(d) { return "translate(" + x(d.name) + ",0)"; });
    bar.append("rect")
      .attr("class", "bar")
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .attr("width", x.rangeBand());

      chart.append("text")
        .attr("x", (width / 2))             
        .attr("y", 0 - (margin.top / 2))
        .attr("text-anchor", "middle")  
        .style("font-size", "16px") 
        .style("text-decoration", "underline")  
        .text(title);

  bar.append("text")
      .attr("x", x.rangeBand() / 2)
      .attr("y", function(d) { return y(d.value) + 6; })
      .attr("dy", ".75em")
      .text(function(d) { return d.value; });
}



function calculateOuterPadding(barsCount,width,padding){
	return (width - (barsCount+padding)*barsCount-padding)/2; 
}


function type(d) {
  d.value =0+d.value; // coerce to number
}
});
