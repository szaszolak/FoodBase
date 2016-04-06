// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$('.compare.index').ready(function(){
function handlerIn () {
	$('[metric="'+$( this ).attr('metric')+'"]').css('background-color', '#b3ffb3');
}

function handlerOut () {
	$('[metric="'+$( this ).attr('metric')+'"]').css('background-color', 'white');
}

function reset(){
	$('th[metric]').off()
}

$('th[metric]').hover( handlerIn, handlerOut )
$('th[metric]').on('click',
	function(){ $('#charts').children().remove();
	bar_chart($( this ).attr('data_url'));
	$('#save').show('quick');
	 });



//$(document).on('page:load', ready);



d3.select("#save").on("click", function(){
  var html = d3.select("svg")
        .attr("version", 1.1)
        .attr("xmlns", "http://www.w3.org/2000/svg")
        .node().outerHTML;

  //console.log(html);
  var imgsrc = 'data:image/svg+xml;base64,'+ btoa(unescape(encodeURIComponent(html)));

  var canvas = document.querySelector("canvas"),
	  context = canvas.getContext("2d");

  var image = new Image;
  image.src = imgsrc;
  image.onload = function() {
	  context.drawImage(image, 0, 0);

	  var canvasdata = canvas.toDataURL("image/png");

	  var a = document.createElement("a");
	  a.download = "sample.png";
	  a.href = canvasdata;
	  document.body.appendChild(a);
	  a.click();
	  context.clearRect(0, 0, canvas.width, canvas.height);
  };

});
});

