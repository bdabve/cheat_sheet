$(document).ready(function(){
    // Hide, show, toggle
    // hide, show, toggle takes 2 parameters(speed, callback)
    // speed: 1000 speed in ms. you can use "fast" or "slow".
    // callback: means what to do after showing or hiding or toggling elements.
    //
    // hide: hide elements
    // show: show elements
    // toggle: toggle between show and hide
    $(".h1").click(function(){
        $("h1").hide();
    });

    $(".h2").click(function(){
        $("h2").show();
    });

    $(".h3").click(function(){
        $("h3").toggle();
    });
    $(".h4").click(function(){
        $("h4").hide(1000, function(){$("span").show()});
    });

    $(".para").click(function(){
        $("p").show(2000, alert("Paragraphe will apears."));
    });

    // Fade Effects
    // Fade work with opacity.
    // Fade take 2 parameter(speed, callback)
    //
    // fadeIn: show hidden objects.
    // fadeOut: hide object.
    // fadeToggle: toggle between show and hide.
    // fadeTo: take 3 parameter(speed, opacity, callback), fade to certain opacity.
    //
    // $(".fade").click(function(){
    //     $("fadeDiv").fadeIn(20000, function(){ $("#spandiv").fadeIn(3000)});
    // });
    //
    // $(".fade").click(function(){
    //     $("fadeDiv").fadeOut(20000, function(){ $("#spandiv").fadeIn(3000)});
    // });
    //
    // $(".fade").click(function(){
    //     $("fadeDiv").fadeToggle(20000, function(){ $("#spandiv").fadeIn(3000)});
    // });

    $(".fade").click(function(){
        $(".fadeDiv").fadeTo("slow", 0.3, function(){ $("#spandiv").fadeIn();});
    })

    // Slide Effects
    // Slide take 2 parameter(speed, callback)
    //
    // slideUp: hide elements.
    // slideDown: show hidden elements.
    // slideToggle: toggle between hide and show
    $(".openBox").click(function(){
        $(".box").slideDown(4000, function(){$(".openBox").slideUp(2000)})
    })

    // $(".openBox").click(function(){
    //     $(".box").slideUp(1000)
    // })

    // $(".openBox").click(function(){
    //     $(".box").slideToggle(1000)
    // })

    // Animate effects
    // Animate take 3 parameters({css property}, speed, callback)
    // You can change value with(+=, -=)
    // You can use hide, show, toggle EXE: $("elment").animate({width:'hide', height: 'show', left: 'toggle'})
    //
    $(".animate").animate({
        width:'500px',
        left: '100px',
        height: '+=200px',
        opacity: '0.5',
        borderRadius: '20px'
    }, 4000, function(){$(".spananimate").fadeIn(1000)});

    // This animation will wait until the first is done.
    $(".animate").animate({
        left:'hide'
    }, 3000)
});
