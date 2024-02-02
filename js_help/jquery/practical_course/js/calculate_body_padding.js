/* global $ */

$(function (){
    
    'use strict';
    
    // Calculate body padding top depend on navbar height
    
    $('body').css('paddingTop', $('.navbar').innerHeight() + 20);
    
    // Smoth scroll to element
    
    $('.navbar li a').click(function(e){
        e.preventDefault();
        $('html, body').animate({
            scrollTop: $('#' + $(this).data('scroll')).offset().top
        }, 1000);
    });
})