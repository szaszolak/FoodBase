competitors = []
var ready = function() {
  

$('.glyphicon-plus').on("click",function(){
	var rowData = $(this).attr('id').split("#")
	competitors.push(rowData[0]);
	$('#sidebar-right').find('ul').append('<li>'+rowData[1]+'</li>');
});

};
$(document).ready(ready);
$(document).on('page:load', ready);