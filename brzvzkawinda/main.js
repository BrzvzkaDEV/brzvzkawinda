window.addEventListener('message', function (event) {
    if(event.data.type === "ui"){
        $("#stagelevel").html("<span>"+event.data.stage+"</span>");
        $("#elepanel").slideDown();
    }
 })
 
 $("#buttons").on("click",".claude",function(){
    let stage = ($(this).data('stage'))
    $.post('http://yn-policelevator/choose', JSON.stringify({
        stagetogo:stage
    }));
    $("#elepanel").slideUp();
 })
document.onkeyup = function(data){
    if(data.which == 27){
        $("#elepanel").slideUp();
        $.post('http://yn-policelevator/exit2', JSON.stringify({}));
    }
}