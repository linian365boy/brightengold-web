	<!DOCTYPE html>
	<html lang="en"><head>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width,initial-scale=1"/>
	<title>${(category.enName)!''} | Sunshinecig</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="description" content="Welcome to sunshin.">
	<meta name="keywords" content="sunshin,sunshinecig,ecig">
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>
	<link href="${ctx}/resources/views/style2/css/application.css" rel="stylesheet"/>
	<link href="${ctx}/resources/views/style2/css/link.css" rel="stylesheet">
</head><body>
	<div id="iqWrap" class="container">
		<header id="iqHead" class="navbar navbar-inverse container-fluid">
			<a href="${ctx }" class="text-center btn-block">
				<img src="${ctx }/resources/${company.logo }" alt="${company.name}"/>
			</a>

			<nav class="navbar-inner">
				<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".navmenu">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>

				<div class="nav-collapse collapse navmenu">
					<ul class="nav text-center" id="iqNav">
						<li class="dropdown"><a class="dropdown-toggle" href="/" id="iqLogo">sunshinecig</a></li>
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
				
<aside class="span3">
	<div id="_loadAsideBar">
    <a href="javascript:void(0);" class="btn btn-block btn-link fav">
        <h2>Categories <span class="icon-tags pull-right"></span></h2>
    </a>
    <ul class="unstyled">
    	<#if ((crossCol?size)>0)>
			<#list crossCol as col>
		        <li><a class="btn btn-link btn-block" href="${ctx}/${(col.url)!'#'}">${col.enName}</a></li>
			</#list>
		</#if>
    </ul>
	</div>
</aside>

<article class="span9">
		<div class="row-fluid">
	        <h2><a href="${ctx}/views/html/col/${(category.enName)?replace('\\s*','','ri')}.htm">${category.enName}</a></h2>
	        <div class="innerContent">
			<p>${(category.remark)!''}</p>
			<p>&nbsp;</p>
			</div>
	        <ul class="thumbnails">
	        	<#if ((category.products?size)>0)>
	        	<#list category.products as product>
	                <li class="span3 thumbnail text-center">
	                        <a href="${ctx}/views/html/product/${category.id}/${product.url}">
	                            <img src="${ctx }/resources/${product.picUrl}" alt="${product.enName}" />
	                        </a>
	                    <div class="caption">
	                        <h4 class="text-left clearfix">${product.enName}</h4>
	                    </div>
	                </li>
	               </#list>
	               </#if>
			</ul>
    </div>
    </article>
<div id="loading"></div>
			</div>
		</section>
		<div id="iqPush"></div>
	</div>

	<footer id="iqFoot" class="container">
		<div class="container-fluid">
			<div class="row-fluid">
				<ul class="span3 nav nav-list">
					<li class="nav-header">sunshinecig</li>
					<#if ((crossCol?size)>0)>
						<#list crossCol as col>
							<li><a href="${ctx}/${(col.url)!'#'}">${col.enName}</a></li>
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
					<li><div class="addthis_toolbox addthis_vertical_style">
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
				<div>&copy;&nbsp;${.now?string("yyyy")}&nbsp;Copyright. All Rights Reserved.</div>
				<div>
<p>sunshinecig® trade mark and associated market identifiers are the exclusive property of ${company.name}</p>
</div>
			</div>
		</div>
	</footer>
	<script src="${ctx}/resources/views/style2/js/scripts.js"></script>
	<script src="${ctx}/resources/views/style2/js/jquery.form.min.js"></script>
</body>
</html>