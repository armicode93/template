var isPhoneDevice = "ontouchstart" in document.documentElement;

(function($) {
  "use strict";

  //var basicScroll=70;
  var basicScroll=-1;
  if ($('body.quicklinks').length > 0 && $('#quicklinks').length > 0) {
	  basicScroll += $('#quicklinks').height();
  }  
    
  $('.js-scroll-trigger[href*="#"]:not([href="#"]), .page-reference a[href*="#"]:not([href="#"])').click(function() {	
    if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      if (target.length) {
    	var scrollTarget = (target.offset().top - basicScroll);
    	if (scrollTarget<100) {
    		scrollTarget = 0;
    	}
        $('html, body').animate({
          scrollTop: scrollTarget
        }, 1000, "easeInOutExpo");
        return false;
      }
    }
  });

  $('.js-scroll-trigger').click(function() {
    $('.navbar-collapse').collapse('hide');
  });

  $('body').scrollspy({
    target: '#mainNav',
    offset: basicScroll
  });

  // Collapse the navbar when page is scrolled
  $(window).scroll(function() {
    if ($("#mainNav").offset().top > basicScroll+30) {
      $("#mainNav").addClass("navbar-shrink");
    } else {
      $("#mainNav").removeClass("navbar-shrink");
    }
  });

})(jQuery); // End of use strict