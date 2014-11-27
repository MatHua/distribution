/**
 * Created by Mr on 2014/11/25.
 */
$(document).ready(function () {
    $("#buy").click(function () {
        $(".customer_mess").animate({"height":"500px"},500);
        setTimeout(function () {
            $(".form-group").fadeIn();
        },500);
    })
})