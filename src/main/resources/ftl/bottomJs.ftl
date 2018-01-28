	<script type="text/javascript">
jQuery.noConflict();
(function( $ ) {
  $(function() {
$(document).ready(function() {
	// carousel latest
    $("#owl-demo").owlCarousel({
		autoPlay: true,
		stopOnHover: false,
		navigation: true,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 5,
        itemsDesktop : [1199,3],
        itemsDesktopSmall : [979,3],
		mouseDrag:false,
		touchDrag:false,
		lazyLoad : true,
	}); 
	// carousel feature
	$("#owl-demo-feature").owlCarousel({
		autoPlay: true,
		stopOnHover: false,
		navigation: true,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 4,
        itemsDesktop : [1199,3],
        itemsDesktopSmall : [979,3],
		mouseDrag:false,
		touchDrag:false,
		lazyLoad : true,
	});
	
// sidebar carousel feature product
	
	$(".owl-demo-side-feature").owlCarousel({
        autoPlay: false,
		stopOnHover: false,
		navigation: true,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 4,
        itemsDesktop : [1199,3],
        itemsDesktopSmall : [979,3],
		mouseDrag:false,
		touchDrag:false,
		lazyLoad : true,
    });
	
		// carousel related
	$("#owl-demo-related").owlCarousel({
		autoPlay: true,
		stopOnHover: false,
		navigation: true,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 4,
        itemsDesktop : [1199,3],
        itemsDesktopSmall : [979,3],
		mouseDrag:false,
		touchDrag:false,
		lazyLoad : true,
	});
	
//	
		$("#owl-demo-la").owlCarousel({
		autoPlay: true,
		stopOnHover: false,
		navigation: true,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 1,
        itemsDesktop : [1199,3],
        itemsDesktopSmall : [979,3],
		mouseDrag:false,
		touchDrag:false,
		lazyLoad : true,
	});
	
//	
		$("#owl-demo-fe").owlCarousel({
		autoPlay: false,
		stopOnHover: false,
		navigation: true,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 5,
        itemsDesktop : [1199,3],
        itemsDesktopSmall : [979,3],
		mouseDrag:false,
		touchDrag:false,
		lazyLoad : true,
	});
	
// sidebar carousel three product
	
	$("#owl-demo-side-three").owlCarousel({
        autoPlay: false,
		stopOnHover: false,
		navigation: true,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 4,
        itemsDesktop : [1199,3],
        itemsDesktopSmall : [979,3],
		mouseDrag:false,
		touchDrag:false,
		lazyLoad : true,
    });
		
// sidebar carousel flash product
	
	$("#owl-demo-side-flash").owlCarousel({
        autoPlay: false,
		stopOnHover: false,
		navigation: false,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 1,
        itemsDesktop : [1199,1],
        itemsDesktopSmall : [979,1],
		itemsTablet: [768,1],
      	itemsMobile:[479,1],
		mouseDrag:false,
		touchDrag:false,
		transitionStyle:"fade",
		lazyLoad : true,
    });

// sidebar carousel four product
	
	$("#owl-demo-side-four").owlCarousel({
        autoPlay: true,
		stopOnHover: true,
		navigation: true,
		navigationText: [
        "<i class='fa fa-angle-left'></i>",
        "<i class='fa fa-angle-right'></i> "
        ],
		slideSpeed: 1000,
		paginationSpeed: 1000,
		pagination:false,
		paginationNumbers: false,
        items : 4,
        itemsDesktop : [1199,3],
        itemsDesktopSmall : [979,3],
		mouseDrag:false,
		touchDrag:false,
		lazyLoad : true,
    });
	
	// slider style type for latest product general
	$('.wpb_latest_pro_sli .owl-wrapper').addClass('grid cs-style-3');
	// slider style type for feature product general
	$('.wpb_feature_pro_sli .owl-wrapper').addClass('grid cs-style-3');
	// slider style type for latest product sidebar
	$('.widget_wpb_latest_class .owl-wrapper').addClass('grid cs-style-3');
	// slider style type for feature product sidebar
	$('.widget_wpb_feature_class .owl-wrapper').addClass('grid cs-style-3');
		
	$('.wpb_related_pro_sli .owl-wrapper').addClass('grid cs-style-3');
	
	$('.wpb_la_pro_sli .owl-wrapper').addClass('grid cs-style-3');
	
	$('.wpb_fe_pro_sli .owl-wrapper').addClass('grid cs-style-3');
	
	$('.widget_wpb_three_class .owl-wrapper').addClass('grid cs-style-3');
	
	$('.widget_wpb_flash_class .owl-wrapper').addClass('grid cs-style-3');
	
	$('.widget_wpb_four_class .owl-wrapper').addClass('grid cs-style-3');
	
	$('.banner').unslider({
		speed: 500, // The speed to animate each slide (in milliseconds)
		delay: 3000, // The delay between slide animations (in milliseconds)
		complete: function() {}, // A function that gets called after every slide animation
		keys: true, // Enable keyboard (left, right) arrow shortcuts
		dots: true, // Display dot navigation
		fluid: false // Support responsive design. May break non-responsive designs
	});
	
});	
});
})(jQuery);

	function expansionOrClose(obj){
		jQuery("#leftWord").toggle(function(){
			if (jQuery(this).is(':hidden')) {
				jQuery(".fa-angle-double-up").hide();
				jQuery(".fa-angle-double-down").show();
			}else{
				jQuery(".fa-angle-double-up").show();
				jQuery(".fa-angle-double-down").hide();
			}
		});
	}
	function locationTo(url){
		if(url!=''){
			jQuery("#tempHref").attr("href",url);
			jQuery("#spanlink").click();
			jQuery("#tempHref").attr("href","javascript:void(0);");
		}
	}
</script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/jquery.form.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/scripts.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/slideset.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/jquery.blockUI.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/woocommerce.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/jquery.cookie.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/cart-fragments.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/masonry.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/jquery.masonry.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/waypoints.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/jquery.sidr.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/owl.carousel.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/functions.js'></script>