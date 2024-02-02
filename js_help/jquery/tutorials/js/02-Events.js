$(document).ready(function()
{
    $(".h1").click(function(){
        $("h1").hide();
    });

    $(".h2").click(function(){
        $(this).css("color", "red");  // This work with this selector(.h2)
        $("h2").css("color", "red");
    });

    $(".h3").dblclick(function(){
        $("h3").hide();
    });

    $(".h4").mouseenter(function(){
        $("h4").css("color", "blue");
    });

    $(".h4").mouseleave(function(){
        $("h4").css("color", "black");
    });

    $(".para").hover(
        function(){
            $("p").css("color", "red");
        },
        function(){
            $("p").css("color", "black");
        }
    );
})
