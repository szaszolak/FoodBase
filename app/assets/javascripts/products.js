competitors = []
var ready = function() {
  

$('.glyphicon-plus').on("click",function(){
	var rowData = $(this).attr('id').split("#")
	competitors.push(parseInt(rowData[0]));
	$('#sidebar-right').find('ul').append('<li>'+rowData[1]+'</li>');
	$('.competitors').children().append('<input type="hidden" value="'+JSON.stringify(competitors)+'" name="competitors_ids">')
});

};
$(document).ready(ready);
$(document).on('page:load', ready);