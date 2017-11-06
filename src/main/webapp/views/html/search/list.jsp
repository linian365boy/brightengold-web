<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../commons/include.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Home - ${(company.name)}</title>
<meta name="description" itemprop="description" content="${(webConfig.description)}" />
<meta name="keywords" itemprop="keywords" content="${(webConfig.keyword)}" />

<link rel="canonical" href="${ctx}/" />
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
<jsp:include page="headCss.jsp"/>
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
<script type='text/javascript' src='${ctx}/resources/js/jquery-1.11.1.min.js'></script>
<script type='text/javascript' src='${ctx}/resources/js/jquery-migrate.min.js'></script>
<script type="text/javascript" src="${ctx}/resources/js/unslider/unslider.min.js"></script>
<meta name="generator" content="WordPress 4.5.3" />
<meta name="generator" content="WooCommerce 2.3.11" />
<link rel='shortlink' href='${ctx}/' />
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
<body class="archive search search-results post-type-archive post-type-archive-product custom-background woocommerce woocommerce-page sidebar nx-boxed onecol-blog no-avatars" style="  ">
	<div id="page" class="hfeed site">
	    <jsp:include page="headMenu.jsp"/>
		<div id="main" class="site-main">
			<div id="primary" class="content-area">
				<div id="content" class="site-content" role="main">
					<nav class="woocommerce-breadcrumb" >
						<a href="${ctx}/">Home</a>
						&nbsp;&#47;&nbsp;Search results for &ldquo;${keyword }&rdquo;
					</nav>
					<h1 class="page-title">Search Results: &ldquo;${keyword }&rdquo;</h1>
					<c:choose>
						<c:when test="${fn:length(page.result)>0 }">
							<ul class="products">
								<c:forEach items="${page.result }" var="product" varStatus="status">
									<li class="${(status.index%4==0)?'first':'' } ${((status.index+1)%4==0)?'last':'' } post-113 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-buy-testosterone-propionate-powder product_tag-testosterone-propionate-powder product_tag-testosterone-propionate-powder-conversion product_tag-testosterone-propionate-powder-manufacturers shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-buy-testosterone-propionate-powder product-tag-testosterone-propionate-powder product-tag-testosterone-propionate-powder-conversion product-tag-testosterone-propionate-powder-manufacturers instock">
									 		<a href="${ctx}/views/html/product/detail/${product.id}.htm">
											<img width="500" height="500" src="${ctx}/resources/${product.picUrl}" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="${product.enName }" />
											<h3>${product.enName }</h3>
										</a>
									</li>
								</c:forEach>
							</ul>
							<c:if test="${page.totalPageNum>1 }">
								<nav class="woocommerce-pagination">
									<ul class="page-numbers">
										<c:if test="${pageNo>1 }">
											<li><a href="${ctx}/views/products/search?pageNo=${pageNo-1}&keyword=${keyword}" class="prev page-numbers">←</a></li>
										</c:if>
										<c:forEach var="index" begin="1" end="${page.totalPageNum }" step="1">
											<c:choose>
												<c:when test="${pageNo==index }">
													<li><span class="page-numbers current">${index }</span></li>
												</c:when>
												<c:otherwise>
													<li><a href="${ctx}/views/products/search?pageNo=${index}&keyword=${keyword}" class="page-numbers">${index }</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<c:if test="${pageNo<page.totalPageNum }">
											<li><a href="${ctx}/views/products/search?pageNo=${pageNo+1}&keyword=${keyword}" class="next page-numbers">→</a></li>
										</c:if>
									</ul>
								</nav>
							</c:if>
						</c:when>
						<c:otherwise>
							<i class="fa fa-warning"></i><span>&nbsp;No Result</span>
						</c:otherwise>
					</c:choose>
				</div><!-- #content -->
		    	<jsp:include page="leftCate.jsp"/>
			</div><!-- #primary -->
			<hr />
			<jsp:include page="bottom.jsp"/>
		</div>
		<script type='text/javascript' src='${ctx}/resources/views/style-ewa/js/select2.min.js'></script>
		<jsp:include page="bottomJs.jsp"/>
	</div>
</body>
</html>