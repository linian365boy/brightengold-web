<!DOCTYPE html><html lang="en"><head>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width,initial-scale=1"/>
	<title>${model.enName} | sunshinecig</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="keywords" content="${model.enName},sunshin ${model.enName},sunshinecig ${model.enName},${model.enName} ecig">
	<meta name="description" content="Welcome to sunshin.${model.enName}">
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>
	<link href="${ctx}/resources/views/style2/css/application.css" rel="stylesheet"/>
	<link href="${ctx}/resources/views/style2/css/css.css" rel="stylesheet"/>
	<link href="${ctx}/resources/views/style2/css/link.css" rel="stylesheet">
	<link href="${ctx}/resources/views/style2/css/picfancy.css" rel="stylesheet">
</head><body>
	<div id="iqWrap" class="container">
		<header id="iqHead" class="navbar navbar-inverse container-fluid">
			<a href="/" class="text-center btn-block">
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
<article class="span7">
	<h2>
		${model.enName}
		<small>(${(model.category.enName)!''})</small>
</h2>
	<figure class="text-center">
		<a id="FullImgHref" href="javascript:void(0);" onclick='ShowFullImg("img_${model.id}");'>
			<img id="MainImg" src="${ctx}/resources/${model.picUrl}" data-src-main="${ctx}/resources/${model.picUrl}" alt="${model.enName}"/>
		</a>
	</figure>

	<ul class="thumbnails" style="border-bottom:1px solid #ddd">
		<li class="span2 text-center">
			<a id="img_${model.id}" href="${ctx}/resources/${model.picUrl}" rel="fancybox-button" class="fancybox-button" title="${model.enName}">
				<img src="${ctx}/resources/${model.picUrl}" alt="${model.enName}" data-src-main="${ctx}/resources/${model.picUrl}"/>
			</a>                                    
		</li>
</ul>
	<div id="ValidationMsg" class="alert alert-error hide"></div>
	<div class="clearfix"></div>
	<br/>
	<div class="innerContent">
		${(model.description)!'no description!'}
	</div>
</article>
<div class="span2">
<#if relateProducts?? && ((relateProducts?size)>0)>
<h4>Other Available Items In This Category</h4>
<ul class="thumbnails">
	<#list relateProducts as relate>
		<#if (relate.id != model.id) && (relate_index<6)>
			<li class="span thumbnail text-center">
				<a href="${ctx}/views/html/product/${(relate.category.id)!''}/${(relate.url)!'#'}" target="_blank">
					<img src="${ctx}/resources/${(relate.picUrl)!''}" alt="${(relate.enName)!''}"/>
				</a>		
				<div class="caption"><small>${(relate.enName)!''}</small>
					<br/>
					<a href="${ctx}/views/html/product/${(relate.category.id)!''}/${(relate.url)!'#'}" class="btn btn-mini btn-success" target="_blank">Details</a>
				</div>
			</li>
		</#if>
	</#list>
</ul>
</#if>
</div>

<div id="QuickBuyModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="QuickBuyModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
		<h3 id="QuickBuyModalLabel">&nbsp;</h3>
	</div>

	<div class="modal-body"></div>

	<div class="modal-footer">
		<button type="button" class="btn btn-small" data-dismiss="modal" aria-hidden="true">Close</button>
	</div>
</div>



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
<script src="${ctx}/resources/views/style2/js/jquery.fancybox.pack.js"></script>
<script src="${ctx}/resources/views/style2/js/jquery.fancybox-buttons.js"></script>
<script src="${ctx}/resources/views/style2/js/jquery.form.min.js"></script>
<script>
$(function () {
	$('.fancybox-button').fancybox({ prevEffect: 'none', nextEffect: 'none', openEffect: 'none', closeEffect: 'none', closeBtn: false, helpers: { title: { type: 'inside' }, buttons: {} } });
	$('.fancybox-button').on('hover', 'img', function () { $('#MainImg').attr('src', $(this).attr('data-src-main')); $('#FullImgHref').attr('onclick', 'ShowFullImg("' + $(this).parent().attr('id') + '");'); });
});
	function ShowFullImg(imgId) { $('#' + imgId).click(); }
</script>
</body></html>