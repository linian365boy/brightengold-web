<html lang="en"><head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>Home | sunshinecig</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content="sunshin,sunshinecig,ecig">
	<meta name="description" content="Welcome to sunshin.">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${ctx}/resources/views/style2/css/css.css" rel="stylesheet">
	<link href="${ctx}/resources/views/style2/css/link.css" rel="stylesheet">
	</head>
	<body>
	<div id="iqWrap" class="container">
		<header id="iqHead" class="navbar navbar-inverse container-fluid">
			<a href="${ctx }" class="text-center btn-block">
				<img src="${ctx }/resources/${company.logo }" alt="${company.name}">
			</a>

			<nav class="navbar-inner">
				<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".navmenu">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>

				<div class="nav-collapse collapse navmenu">
					<ul class="nav text-center" id="iqNav">
						<li class="dropdown"><a class="dropdown-toggle" href="${ctx}" id="iqLogo">Home</a></li>
					<#if ((crossCol?size)>0)>
						<#list crossCol as col>
							<li class="dropdown"><a class="dropdown-toggle" href="${ctx}/${(col.url)!'#'}">${col.enName}</a></li>
						</#list>
					</#if>
					</ul>
				</div>
			</nav>
		</header>

		<section id="iqBody" class="container-fluid">
			<div class="row-fluid">
<article class="span12">
	<div class="hero-unit">
		<div id="iqSlider" class="container carousel slide">
			<div class="carousel-inner">
				<#list indexAds as ad>
					<div class="item ${(ad_index==0)?string('active','')}">
						<a <#if (ad.url)?? && ((ad.url)?length>0)> href="${ad.url}" target="_blank"<#else> href="javascript:void(0);" </#if>>
						<img src="${ctx}/resources/${ad.picUrl}" alt="${(ad.name)!''}" title="${(ad.name)!''}" width="1170" height="500">
						</a>
					</div>
				</#list>
			</div>
			<a class="carousel-control left" href="#iqSlider" data-slide="prev"></a>
			<a class="carousel-control right" href="#iqSlider" data-slide="next"></a>
		</div>
	</div>

	<ul class="thumbnails text-center">
	<#if (products??) && ((products?size)>0)>
		<#list products as product>
		<li class="span3">
		<a href="${ctx}/views/html/product/${product.category.id}/${(product.url)!'#'}" class="thumbnail" title="${(product.enName)!''}">
		<img src="${ctx}/resources/${product.picUrl}" width="259" height="193">
		</a>
		</li>	
		</#list>
	</#if>
	</ul>

	<div class="well well-small text-center">
		<strong>Trust in Sunshinecig®</strong>&nbsp;<br>
We know that to accomplish a switch away from tobacco you need and deserve the best products available. Sunshinecig is the 
best E-cigarette manufacturer and the global agent of kanger, Aspire, Joyetech, Smoktech, Sigelei and Vision. We pride 
ourselves on offering only top quality, genuine trademark products. We are SunshineCig, make your life full of sunshine. We 
don't want to leave anyone in the smoke and our goal is to help people as many as possible to make the switch from analog 
to electronic smoking and really enjoy the experience of the perfect vaping.
	</div>
</article>
			</div>
		</section>

		<div id="iqPush"></div>
	</div>

	<footer id="iqFoot" class="container">
		<div class="container-fluid">
			<div class="row-fluid">
				<ul class="span3 nav nav-list">
					<li class="nav-header">Sunshinecig</li>
					<#if ((crossCol?size)>0)>
						<#list crossCol as col>
							<li class="dropdown">
								<a class="dropdown-toggle" href="${ctx}/${(col.url)!'#'}">${col.enName}</a></li>
						</#list>
					</#if>
				</ul>

				<ul class="span3 nav nav-list">
					<li class="nav-header">Information</li>
					<#if infos?? && (infos?size>0)>
						<#list infos as inf>
							<li><a href="${ctx}/${inf.url}">${inf.name}</a></li>
						</#list>
					</#if>
				</ul>

				<ul class="span3 nav nav-list">
					<li class="nav-header">Follow Us</li>
					<li>
					<div class="addthis_toolbox addthis_vertical_style">
							<div class="addthis_toolbox addthis_vertical_style">
								<a class="addthis_button_facebook_follow at300b" href="https://www.facebook.com/wu.wilson.372" target="_blank" title="Follow on Facebook">
									<span class="at4-icon-left at4-icon aticon-facebook" style="background-color: rgb(48, 88, 145);">
										<span class="at_a11y">Share on facebook</span>
									</span>
									<span class="addthis_follow_label">Facebook</span>
								</a>
								<a class="addthis_button_google_follow at300b" title="Follow on Google" href="https://plus.google.com/u/0/103736009421571979699" target="_blank">
									<span class="at4-icon-left at4-icon aticon-google_follow" style="background-color: rgb(207, 72, 50);">
										<span class="at_a11y">Share on google_follow</span>
									</span>
									<span class="addthis_follow_label">Google</span>
								</a>
								<a class="addthis_button_skype_follow at300b" title="Follow on Skype" href="skype:wilsonwu552?chat" target="_blank">
									<span class="at4-icon-left at4-icon aticon-skype_follow" style="background-color: rgb(44, 168, 210);">
										<span class="at_a11y">Share on skype</span>
									</span>
									<span class="addthis_follow_label">Skype</span>
								</a>
								<div class="atclear"></div>
							</div>
							<div class="atclear"></div>
						</div>
					</li>
				</ul>
			</div>

			<div class="row-fluid" style="font-size:.8em">
				<div>©&nbsp;${.now?string("yyyy")}&nbsp;Copyright. All Rights Reserved.</div>
				<div>
<p>sunshinecig® trade mark and associated market identifiers are the exclusive property of ${company.name}</p>
</div>
			</div>
		</div>
	</footer>
	<script src="${ctx}/resources/views/style2/js/scripts.js"></script>
</body></html>