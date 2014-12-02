$( ".taken" ).click(function(e) {
    clickAction(this);
});

$( ".enrolled" ).click(function(e) {
    clickAction(this);
});

function clickAction(e){

    var course_array = $(".content").find("[data-taken='true']").find('.taken');
    var taken_array = new Array();

    course_array.each(function(){
        taken_array.push($(this).data('dept') + $(this).data('number'));
    });

    jQuery.ajax({
        type: "POST",
        datatype: "html",
        url: "/dashboard",
        data: { act: $(e).data('action'), dept: $(e).data('dept'), number: $(e).data('number'), taken: taken_array},
        success: function(result, status, x) {

            $.each(result, function(k, v) {

                var current = $(".content").find("[data-course='" + k + "']");
                var parent = current.parents(".example");
                var color = null;

                if(parent.hasClass("core")){
                    color = "bg-lime";
                }
                else if(parent.hasClass("tech")){
                    color = "bg-cyan";
                }
                else
                {
                    color = "bg-amber";
                }

                if (v == "available"){

                    current.removeClass("not-available").addClass("available");
                    current.children(".list-content").removeClass("bg-gray").addClass(color);
                    current.find(".overlay-fluid").removeClass("hide");
                }
                else if(v == "taken"){
                    current.attr("data-taken", "true");
                    current.children(".list-content").removeClass(color).addClass("bg-emerald");
                    current.find(".overlay-fluid").removeClass("overlay").addClass("completed");
                }
                else{
                    current.attr("data-taken", "true");
                    current.find(".overlay-fluid").removeClass("overlay").addClass("currently-enrolled");
                }
            });

        },
        error: function(result, status, x) {

            alert("Already Taken Faillll");
        }
    });
}