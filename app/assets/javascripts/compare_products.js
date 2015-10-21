

var hide_recipes = function(){
	$('.recipe').css('display','none');
	$('#recipe_toggler').removeClass("glyphicon-chevron-up");
	$('#recipe_toggler').addClass("glyphicon-chevron-down");
}

var show_recipes = function(){
		$('.recipe').css('display','');
	$('#recipe_toggler').addClass("glyphicon-chevron-up");
	$('#recipe_toggler').removeClass("glyphicon-chevron-down");
}

var toggle_recipes_visibility = function(){
	if($('#recipe_toggler').hasClass('glyphicon-chevron-down')){
		show_recipes();
	}else
	{
		hide_recipes();
	}
}

$(document).on("click",'#recipe_toggler',toggle_recipes_visibility);