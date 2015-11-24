competitors = []
var ready = function() {
  

$('.glyphicon-plus').on("click",function(){
	var rowData = $(this).attr('id').split("#")
	var id = parseInt(rowData[0]);
	if($.inArray(id, competitors) < 0){
		competitors.push(parseInt(rowData[0]));
		$('#sidebar-right').find('ul').append('<li>'+rowData[1]+'</li>');
		$('.competitors').children().append('<input type="hidden" value="'+JSON.stringify(competitors)+'" name="competitors_ids">')
	}
});
var dataElements = $('tr[data-link]').children(':nth-child(2),:nth-child(3),:nth-child(4),:nth-child(5),:nth-child(6)');
dataElements.on("click",function(){
	 window.location = $(this.parentElement).data('link');
});
var hoverHandler = function(){
	$(this.parentElement).children(':nth-child(2),:nth-child(3),:nth-child(4),:nth-child(5),:nth-child(6)').toggleClass('hover');
};
dataElements.hover(hoverHandler,hoverHandler);
};

$(document).ready(ready);
$(document).on('page:load', ready);