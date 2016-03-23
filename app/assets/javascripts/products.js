$('.products.index').ready(function(){
competitors = []
products_ready();
 
});

function products_ready(){


$('input[type="checkbox"]').on("click",function(){
	var id = parseInt($(this).attr('id'));
	if($.inArray(id, competitors) < 0){
		competitors.push(id);
	}else{
	
		competitors.splice(competitors.indexOf(id),1);
	}
	$('.competitors').children('[name="competitors_ids"]').remove()
	$('.competitors').append('<input type="hidden" value="'+JSON.stringify(competitors)+'" name="competitors_ids">')
	if(competitors.length > 0)
		$('.btn_competitiors').prop("disabled",false);
	else
		$('.btn_competitiors').prop("disabled",true);
});
var dataElements = $('tr[data-link]').children(':nth-child(2),:nth-child(3),:nth-child(4),:nth-child(5)');
dataElements.on("click",function(){
	 window.location = $(this.parentElement).data('link');
});
var hoverHandler = function(){
	$(this.parentElement).children(':nth-child(2),:nth-child(3),:nth-child(4),:nth-child(5)').toggleClass('hover');
};
dataElements.hover(hoverHandler,hoverHandler);
$('.btn_competitiors').prop("disabled",true);
};



function product_reset(){
	competitors = []
	$('tr[data-link]').children(':nth-child(2),:nth-child(3),:nth-child(4),:nth-child(5)').off();
	$('input[type="checkbox"]').off();
	
}

