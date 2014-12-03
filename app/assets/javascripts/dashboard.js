$( ".taken" ).click(function(e) {
    clickAction(this);

    var counter_text = $(this).parents(".example").children(".counter").children("span");
    var section = $(this).parents(".example").data("section");
    var progress_div = $(".menu-side div[data-progress='" + section + "']");

    var num_array = counter_text.html().split("/");
    var progress_text_array = progress_div.children("a").text().split(" - ");

    counter_text.text("" + (parseInt(num_array[0])+1) + " / " + parseInt(num_array[1]) + "");

    progress_div.children("a").html("<i class='fa fa-circle-o-notch fa-2x'></i>&nbsp;&nbsp;" + parseInt(((parseInt(num_array[0])+1)*100 / parseInt(num_array[1])).toString()) + "% - " + progress_text_array[1] + "");
    progress_div.children(".progress").css("width", "" + 3.2 * (parseInt(num_array[0])+1)*100 / parseInt(num_array[1]) + "px");

});

$( ".enrolled" ).click(function(e) {
    clickAction(this);

    var text = $(this).parents(".example").children(".counter").children("span");
    var num_array = text.html().split("/");

    text.text("" + (parseInt(num_array[0])+1) + " / " + parseInt(num_array[1]) + "");
});

function clickAction(e){

    var course_taken_array = $(".content").find("[data-taken='true']");
    var course_enrolled_array = $(".content").find("[data-enrolled='true']");
    var taken_array = new Array();
    var enrolled_array = new Array();

    course_taken_array.each(function(){
        taken_array.push($(this).data('course'));
    });

    course_enrolled_array.each(function(){
        enrolled_array.push($(this).data('course'));
    });

    jQuery.ajax({
        type: "POST",
        datatype: "html",
        url: "/dashboard",
        data: { act: $(e).data('action'), course: $(e).data('dept') + $(e).data('number'), taken: taken_array, enrolled: enrolled_array},
        success: function(result, status, x) {

            var core_count = null;
            var tech_count = null;
            var math_count = null;

            $.each(result, function(k, v) {

                var current = $(".content").find("[data-course='" + k + "']");
                var parent = current.parents(".example");
                var available_color = null;
                var taken_color = null;

                if(parent.hasClass("core")){
                    available_color = "bg-lime";
                    taken_color = "bg-emerald";
                }
                else if(parent.hasClass("tech")){
                    available_color = "bg-cyan";
                    taken_color = "bg-darkBlue"
                }
                else
                {
                    available_color = "bg-amber";
                    taken_color = "bg-darkOrange";
                }

                if (v == "available"){

                    current.removeClass("not-available").addClass("available");
                    current.children(".list-content").removeClass("bg-gray").addClass(available_color);
                    current.find(".overlay-fluid").removeClass("hide");
                }
                else if(v == "taken"){
                    current.attr("data-taken", "true");
                    current.attr("data-enrolled", "false");
                    current.children(".list-content").removeClass(available_color).addClass(taken_color);
                    current.find(".overlay-fluid").removeClass("overlay").addClass("completed");
                }
                else{
                    current.attr("data-enrolled", "true");
                    current.attr("data-taken", "false");
                    current.find(".overlay-fluid").removeClass("overlay").addClass("currently-enrolled");
                }
            });

        },
        error: function(result, status, x) {

            alert("Ajax - Error");
        }
    });
}