<!DOCTYPE html>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${(product.enName)!''} - ${(company.name)!''}</title>
<meta name="description" itemprop="description" content="${(webConfig.description)!''}" />
<style type="text/css">
img.wp-smiley,
img.emoji {
	display: inline !important;
	border: none !important;
	box-shadow: none !important;
	height: 1em !important;
	width: 1em !important;
	margin: 0 .07em !important;
	vertical-align: -0.1em !important;
	background: none !important;
	padding: 0 !important;
}
</style>
<#include "headCss.ftl">
<style id='imax-extra-stylesheet-inline-css' type='text/css'>
#sun h3 span {
    background: none repeat scroll 0 0 #5fd6d8;
}
#sun h3 span::before {
    border-bottom: 37px solid #5fd6d8;
}
.wpb_area_title{
border-bottom: 3px solid #5fd6d8;
}
#woocommerce_product_categories-2 {
    font-weight: bold;
}
</style>
<script type='text/javascript' src='${ctx}/resources/js/jquery-1.11.1.min.js?${style_v}'></script>
<script type='text/javascript' src='${ctx}/resources/js/jquery-migrate.min.js?${style_v}'></script>
<script type="text/javascript" src="${ctx}/resources/js/unslider/unslider.min.js"></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/js.js'></script>
<meta name="generator" content="WordPress 4.5.3" />
<meta name="generator" content="WooCommerce 2.3.11" />
<style type="text/css">
.grid figcaption a, div.grid_no_animation figcaption a.button {background: #1abc9c!important;}
.grid figcaption a:hover, div.grid_no_animation figcaption a.button:hover {background: #16a085!important;}
.owl-theme .owl-controls .owl-page span {background: #8BCFC2;}
.owl-theme .owl-controls .owl-page.active span,
.owl-theme .owl-controls.clickable .owl-page:hover span{background: #16A085;}
.owl-theme .owl-controls .owl-buttons div {background: #CCCCCC;}
.owl-theme .owl-controls.clickable .owl-buttons div:hover{background:#999999;}
div.grid_no_animation figcaption .pro_price_area .amount {text-decoration: none;color: #16A085;}
</style>
<style type="text/css">
a,a:visited,.blog-columns .comments-link a:hover {color: #5fd6d8;}input:focus,textarea:focus,.site-footer .widget-area .widget .wpcf7 .wpcf7-submit {border: 1px solid #5fd6d8;}button,input[type="submit"],input[type="button"],input[type="reset"],.tx-service.curved .tx-service-icon span,.tx-service.square .tx-service-icon span {background-color: #5fd6d8;}.nav-container .sub-menu,.nav-container .children {border-top: 2px solid #5fd6d8;}.ibanner,.da-dots span.da-dots-current,.tx-cta a.cta-button {background-color: #5fd6d8;}#ft-post .entry-thumbnail:hover > .comments-link,.tx-folio-img .folio-links .folio-linkico,.tx-folio-img .folio-links .folio-zoomico {background-color: #5fd6d8;}.entry-header h1.entry-title a:hover,.entry-header > .entry-meta a:hover {color: #5fd6d8;}.featured-area div.entry-summary > p > a.moretag:hover {background-color: #5fd6d8;}.site-content div.entry-thumbnail .stickyonimg,.site-content div.entry-thumbnail .dateonimg,.site-content div.entry-nothumb .stickyonimg,.site-content div.entry-nothumb .dateonimg {background-color: #5fd6d8;}.entry-meta a,.entry-content a,.comment-content a,.entry-content a:visited {color: #5fd6d8;}.format-status .entry-content .page-links a,.format-gallery .entry-content .page-links a,.format-chat .entry-content .page-links a,.format-quote .entry-content .page-links a,.page-links a {background: #5fd6d8;border: 1px solid #5fd6d8;color: #ffffff;}.format-gallery .entry-content .page-links a:hover,.format-audio .entry-content .page-links a:hover,.format-status .entry-content .page-links a:hover,.format-video .entry-content .page-links a:hover,.format-chat .entry-content .page-links a:hover,.format-quote .entry-content .page-links a:hover,.page-links a:hover {color: #5fd6d8;}.iheader.front {background-color: #5fd6d8;}.navigation a,.tx-post-row .tx-folio-title a:hover,.tx-blog .tx-blog-item h3.tx-post-title a:hover {color: #5fd6d8;}.paging-navigation div.navigation > ul > li a:hover,.paging-navigation div.navigation > ul > li.active > a {color: #5fd6d8;	border-color: #5fd6d8;}.comment-author .fn,.comment-author .url,.comment-reply-link,.comment-reply-login,.comment-body .reply a,.widget a:hover {color: #5fd6d8;}.widget_calendar a:hover {background-color: #5fd6d8;	color: #ffffff;	}.widget_calendar td#next a:hover,.widget_calendar td#prev a:hover {background-color: #5fd6d8;color: #ffffff;}.site-footer div.widget-area .widget a:hover {color: #5fd6d8;}.site-main div.widget-area .widget_calendar a:hover,.site-footer div.widget-area .widget_calendar a:hover {background-color: #5fd6d8;color: #ffffff;}.widget a:visited { color: #373737;}.widget a:hover,.entry-header h1.entry-title a:hover,.error404 .page-title:before,.tx-service-icon span i,.tx-post-comm:after {color: #5fd6d8;}.da-dots > span > span,.site-footer .widget-area .widget .wpcf7 .wpcf7-submit {background-color: #5fd6d8;}.iheader,.format-status,.tx-service:hover .tx-service-icon span,.ibanner .da-slider .owl-item .da-link:hover {background-color: #5fd6d8;}.tx-cta {border-left: 6px solid #5fd6d8;}.paging-navigation #posts-nav > span:hover, .paging-navigation #posts-nav > a:hover, .paging-navigation #posts-nav > span.current, .paging-navigation #posts-nav > a.current, .paging-navigation div.navigation > ul > li a:hover, .paging-navigation div.navigation > ul > li > span.current, .paging-navigation div.navigation > ul > li.active > a {border: 1px solid #5fd6d8;color: #5fd6d8;}.entry-title a { color: #141412;}.tx-service-icon span { border: 2px solid #5fd6d8;}.nav-container .current_page_item > a,.nav-container .current_page_ancestor > a,.nav-container .current-menu-item > a,.nav-container .current-menu-ancestor > a,.nav-container li a:hover,.nav-container li:hover > a,.nav-container li a:hover,ul.nav-container ul a:hover,.nav-container ul ul a:hover {background-color: #5fd6d8; }.tx-service.curved .tx-service-icon span,.tx-service.square .tx-service-icon span {border: 6px solid #e7e7e7; width: 100px; height: 100px;}.tx-service.curved .tx-service-icon span i,.tx-service.square .tx-service-icon span i {color: #FFFFFF;}.tx-service.curved:hover .tx-service-icon span,.tx-service.square:hover .tx-service-icon span {background-color: #e7e7e7;}.tx-service.curved:hover .tx-service-icon span i,.tx-service.square:hover .tx-service-icon span i,.folio-style-gallery.tx-post-row .tx-portfolio-item .tx-folio-title a:hover {color: #5fd6d8;}.site .tx-slider .tx-slide-button a,.ibanner .da-slider .owl-item.active .da-link  { background-color: #5fd6d8; color: #FFF; }.site .tx-slider .tx-slide-button a:hover  { background-color: #373737; color: #FFF; }</style>
<style type="text/css" id="custom-background-css">
body.custom-background { background-color: #e2e2e2; }
</style>
<link rel="icon" href="${ctx}/resources/views/style-ewa/images/steroids-benefits.png" sizes="32x32" />
<link rel="icon" href="${ctx}/resources/views/style-ewa/images/steroids-benefits.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="${ctx}/resources/views/style-ewa/images/steroids-benefits.png" />
<meta name="msapplication-TileImage" content="${ctx}/resources/views/style-ewa/images/steroids-benefits.png" />
</head>
<body class="single single-product postid-1066 custom-background woocommerce woocommerce-page sidebar nx-boxed onecol-blog no-avatars" style="  ">
	<div id="page" class="hfeed site">
    	<#include "headMenu.ftl">
		<div id="main" class="site-main">
	<div id="primary" class="content-area">
		<#--virtual 相对路径-->
        <!--#include virtual="${product.url}"-->
		<#include "leftCate.ftl">
	</div><!-- #primary -->
<hr />
<#include "bottom.ftl">
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
	
// sidebar carousel latest

    $("#owl-demo-side").owlCarousel({
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
	
	$("#owl-demo-side-feature").owlCarousel({
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
</script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/jquery.form.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/scripts.js'></script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/slideset.js'></script>
<script type='text/javascript'>
/* <![CDATA[ */
var wc_single_product_params = {"i18n_required_rating_text":"\u663e\u793a\u94fe\u63a5\u8bc4\u7ea7","review_rating_required":"yes"};
/* ]]> */
</script>
<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/single-product.min.js'></script>
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
<script type="text/javascript">
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('G(I).K(v(a){a(\'\\2\\8\\m\\0\\0\\c\').H(\'\\9\\e\\3\\9\\F\\8\\o\\D\');$E=a(\'\\8\\f\\i\\0\\k\\7\\9\\1\\r\\8\\1\\j\\7\\c\\D\\p\\2\\3\\e\\4\');$x=a(\'\\2\',$E);$g=a(\'\\8\\f\\i\\0\\k\\7\\9\\1\\r\\8\\3\\c\\2\\y\\5\\4\\N\\2\');s=v(b){b.M(\'\\t\\L\\7\\5\\i\\l\\Q\\m\\0\\0\\c\').P(\'\\i\\5\\e\',"\\m\\0\\0\\c\\O\\3\\k\\1\\j\\6\\h\\2\\7\\1\\0\\h\\d\\m\\0\\0\\c\\J\\5\\3\\y\\j\\1\\6\\r\\h\\2\\7\\1\\0\\h\\d\\f\\0\\4\\3\\1\\3\\0\\p\\6\\h\\i\\3\\y\\j\\1\\h\\d\\2\\k\\t\\7\\4\\1\\12\\6\\C\\n\\d\\2\\k\\t\\7\\4\\1\\10\\6\\q\\d\\1\\3\\p\\1\\u\\f\\2\\9\\3\\1\\l\\6\\q\\8\\n\\d\\e\\5\\p\\4\\u\\f\\2\\9\\3\\1\\l\\6\\q\\8\\n\\d\\4\\0\\o\\1\\Z\\0\\9\\7\\4\\6\\o\\2\\e\\4\\5\\d\\4\\c\\0\\0\\1\\j\\13\\0\\z\\5\\6\\C\\d\\4\\j\\0\\14\\Y\\3\\1\\e\\5\\6\\o\\2\\e\\4\\5\\d\\1\\3\\1\\e\\5\\u\\f\\2\\9\\3\\1\\l\\6\\q\\8\\n").U()};X($x.W){$x.V(\'\\c\\0\\7\\4\\5\\c\\0\\z\\5\\r\\9\\e\\3\\9\\F\',v(){$w=a(R).S(A);$w.T($g);$g.B();$g=$w;a(\'\\8\\c\\0\\7\\4\\5\\1\\i\\2\\f\').B();s($g);11 A})};s($g)});',62,67,'x6f|x74|x61|x69|x73|x65|x3a|x75|x2e|x63|||x6d|x2c|x6c|x70|productImages|x27|x72|x68|x64|x79|x7a|x35|x66|x6e|x30|x20|addjqueryzoom|x6a|x4f|function|image|thumbnails|x67|x76|false|remove|x33|x62|thumbnailsContainer|x6b|jQuery|unbind|document|x48|ready|x71|addClass|x3e|x57|attr|x2d|this|clone|insertAfter|jqueryzoom|bind|length|if|x54|x46|x59|return|x58|x4d|x77'.split('|'),0,{}))
        </script>
</body>
</html>