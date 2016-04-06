$(window).on('load',
	function() {

				//setup canvas for chart
				var width = $('#content').width();
				
				$('#content').append("<div class=\"checkbox\"><label><input id=\"error-bars-switch\" data-toggle=\"toggle\" type=\"checkbox\" data-on=\"Pokaż\" data-off=\"Ukryj\">Odchylenie standardowe</label></div><link href=\"https://gitcdn.github.io/bootstrap-toggle/2.2.0/css/bootstrap-toggle.min.css\" rel=\"stylesheet\"><script src=\"https://gitcdn.github.io/bootstrap-toggle/2.2.0/js/bootstrap-toggle.min.js\"></script>");
		
				width = width>512?512:width;
				var height = width/2+180;
				var margin = {top: 30, right: 30, bottom: 180, left: 50},
   				width = width - margin.left - margin.right,
    			height = height - margin.top - margin.bottom;




				d3.json($('div[product-id]').attr('product-id')+'.json',
					function(error,data){
						var i = 0;
						_.each(data.metrics,function(metric){
            
             //
							var div = '<svg class="chart chart-'+i+'"></svg>'
              $('#content').append('<button id="save-'+i+'" class="btn btn-default" type="button" >Pobierz jako *.png</button>');
              $('#content').append('<canvas id="canv-'+i+'"style="display:none" height="500" width="960"></canvas>');
							$('#content').append(div);
            

             d3.select("#save-"+i).on("click", button_handler);

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
				   		  .orient("left")
				   		  .outerTickSize(0);
							draw(metric.samples,chart,metric.name,x,y,xAxis,yAxis);
							i++;
						})	
						 $('#error-bars-switch').on('change',  function(e) {
							toggleErrorBars();
    						});

})
		

function draw(data,chart,title,x,y,xAxis,yAxis){
		_.each(data,type);
	  x.domain(data.map(function(d) { return d.name; }))
 	  y.domain([0, d3.max(data, function(d) { return d.value + d.deviation; })])
					

  chart.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis) 
      .selectAll("text")  
            .style("text-anchor", "end")
            .attr("dx", "-.8em")
            .attr("dy", ".15em")
            .attr("transform", "rotate(-65)" );;

  chart.append("g")
      .attr("class", "y axis")
      .call(yAxis).selectAll('path')
      .style("fill", "none")
      .style("stroke","#000")
      .style("shape-rendering", "crispEdges");
      
      chart.selectAll('line')
      .style("fill", "none")
      .style("stroke","#000")
      .style("shape-rendering", "crispEdges");

       chart.append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 0 - margin.left)
        .attr("x",0 - (height / 2))
        .attr("dy", "1em")
        .style("text-anchor", "middle")
        .text(title);
  var c20 = d3.scale.category20();
 var bar= chart.selectAll(".bar")
      .data(data)
    .enter().append("g")
      .attr("transform", function(d) { return "translate(" + x(d.name) + ",0)"; });
    bar.append("rect")
      .attr("class", "bar")
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .attr("width", x.rangeBand())
         .style('fill', 'steelblue');

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
      .attr("text-anchor", "middle")  
      .text(function(d) {
       return d.value.toFixed(2);
        });

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



});

function button_handler(){

              var html = d3.select("svg.chart-"+this.id.split('-')[1])
                    .attr("version", 1.1)
                    .attr("xmlns", "http://www.w3.org/2000/svg")
                    .node().outerHTML;

              //console.log(html);
              var imgsrc = 'data:image/svg+xml;base64,'+ btoa(unescape(encodeURIComponent(html)));

              var canvas = document.querySelector("#canv-"+this.id.split('-')[1]),
                context = canvas.getContext("2d");

              var image = new Image;
           image.addEventListener('load', function() {
                context.drawImage(image, 0, 0);

                var canvasdata = canvas.toDataURL("image/png");

                var a = document.createElement("a");
                a.download = "sample.png";
                a.href = canvasdata;
                document.body.appendChild(a);
                a.click();
                context.clearRect(0, 0, canvas.width, canvas.height);
              });
                image.src = imgsrc;
            
              }