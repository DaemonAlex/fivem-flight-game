var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
});


window.addEventListener('message', function(event) {
    if (event.data.type == "enableui") {
        document.body.style.display = event.data.enable ? "block" : "none";
    }
});

document.onkeyup = function (data) {
    if (data.which == 27) {
        $.post('https://flight-radio/hidenui', JSON.stringify({}));
    }
};

$("#login-form").submit(function(e) {
    e.preventDefault();
    $.post('https://flight-radio/joinRadio', JSON.stringify({
        channel: $("#channel").val()
    }), function() {
        $("#lowing-circle").removeClass("leave-glow").addClass("join-glow").css("background-color", "#00ff00");
    });
});

$('#onoff').click(function (event, ui) {
    event.preventDefault();
    $.post('https://flight-radio/leaveRadio', JSON.stringify({}), function() {
        $("#lowing-circle").removeClass("join-glow").addClass("leave-glow").css("background-color", "#ff0000");
    });
});


$('#lower').click(function (event, ui) {
    event.preventDefault();
    $.post('https://flight-radio/volumedown', JSON.stringify({}));
    tooltipHover()
});

$('#raise').click(function (event, ui) {
    event.preventDefault();
    $.post('https://flight-radio/volumeup', JSON.stringify({}));
    tooltipHover()
});

function tooltipHover() {
    $("[data-toggle='tooltip']").tooltip('hide');
};
