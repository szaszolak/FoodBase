// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function ready(){
	reset();
function handlerIn () {
	$('[metric="'+$( this ).attr('metric')+'"]').css('background-color', '#b3ffb3');
}

function handlerOut () {
	$('[metric="'+$( this ).attr('metric')+'"]').css('background-color', 'white');
}

$('th[metric]').hover( handlerIn, handlerOut )
$('th[metric]').on('click',
	function(){ $('#charts').children().remove();
	bar_chart($( this ).attr('data_url'));
	 });
}


$(document).ready(ready)
$(document).on('page:load', ready);

function reset(){
	$('th[metric]').off()
}