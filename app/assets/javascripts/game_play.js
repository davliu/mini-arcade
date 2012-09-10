// References:
// Ajax loader gif comes from ajaxload.info and logos belong to their respective companies
// I don't own ANY of these images!

var position = 0;

function move_spinner() {
    $('.logo').show();
    $("#order_" + position + " > .logo").hide();
    $('#score_points').val($("#order_" + position + " > .logo").attr('value'));

    $('#spinner').appendTo("#order_" + position);
    position++;
    if (position > 15) {
        position = 0;
        $('#score_rounds').val(parseInt($('#score_rounds').val()) + 1);
    }
}

$(function() {
    setInterval(move_spinner, 200);
});