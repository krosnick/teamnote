// uses ajax to display preview of note's content
// upon hovering over the title of the note
// but you may need to refresh the page if you are
// coming from another page in the app; if you just
// enter the url it works fine; also the content
// does update without refreshing if the note is
// changed by another user
$(function(){
    $(".title").hover(function(){
         var s = $(this).attr('id')
         $.ajax({
           url: "/notes/" + s.substring(5) + "/view",
           dataType: 'json',
           type: 'GET'
         }).done(function(data){
         	var t = data.content
         	$("div#preview").text(t)
         });
    },function(){
       $("#preview").empty()
    });
});