<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<title>Company Profile-USB charging wall socket, wireless charger, USB 
charger, car charger, mobile power,Shenzhen hien technology co.,ltd</title>
<meta name="keywords" content="USB charging wall socket, wireless charger, USB charger, car charger, mobile power,Shenzhen hien technology co.,ltd"></meta>
<meta name="description" content="Hain Technology Development Co., Ltd. Shenzhen was founded in 2009, formerly known as Shenzhen Technology Co. Huaen, due to development needs, in 2011 officially changed its name to the Shenzhen Science and Technology Development Co., Ltd. Hain, the company has an independent R &amp; D team, is a product R &amp; D, production, sales as one of the diveified high-tech enterprises ,hotline:0086-755-28412985"></meta>
<link href="${ctx}/resources/views/css/style_en.css?${style_v}" type="text/css" rel="stylesheet"></link>
<link rel="icon" href="${ctx }/resources/images/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="${ctx }/resources/images/favicon.ico" type="image/x-icon" />
<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js?${style_v}"></script>
<script type="text/javascript" src="${ctx}/resources/js/unslider/unslider.min.js?${style_v}"></script>
<script type="text/javascript" src="${ctx}/resources/views/css/commen.js?${style_v}"></script>
<script type="text/javascript">
	var basePath = "${ctx}";
</script>
</head>

<body>
	<!--head start-->
    <div class="head">
    	<div class="wd">
            <div class="logo"><a href="${company.website}" title="${company.name}"><img src="${ctx}/resources/${company.logo}" alt="${company.name}" height="91" width="480"></a></div>
            <div class="head-right">
            <!--
                <div class="banben">
                    <a href="http://www.hienpower.com/index.htm" title="Shenzhen Hien technology co.,ltd" class="en">English</a>
                    <a href="http://www.hienpower.com/zh_cnindex.htm" title="Shenzhen Hien technology co.,ltd" class="cn">中文版</a>
                </div>
                -->
                <div class="search">
                    <form target="_blank" method="post" name="searchform" id="searchform" action="/web/search.php?lanstr=en">
                        <input name="s" class="search_btn" value="" type="submit"><input name="keywords" id="keywords" class="search_txt" type="text"><span>Search：</span>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--head end-->
    <!--menu start-->
    <div class="menu">
    	<ul>
    		<li><a title="首 页" href="" class="bigli">首 页</a></li>
    		<li class="mline"></li>
    		<#if ((crossCol?size)>0)>
	    		<#list crossCol as col>
	    			<#if ((col.childColumn)?size)==0 >
		    			<li><a class="bigli" href="${ctx}/${(col.url)!'#'}" title="${(col.name)!''}" 
		    				id="${(col.code)!''}">${(col.name)!''}</a>
		    			</li>
		            <#else>
		                <li class="bigli">
			    			<a class="" href="${ctx}/${(col.url)!''}" title="${(col.name)!''}" id="${(col.code)!''}">${(col.name)!''}</a>
				            	<ul style="display: none;">
					    			<#list col.childColumn as childCol>
					    				<li><a href="${ctx}/${(childCol.url)!''}" title="${(childCol.name)!''}" 
				            			id="${(childCol.code)!''}">${(childCol.name)!''}</a></li>
					    			</#list>
				            	</ul>
			            </li>
	                </#if>
	                <#if col_has_next>
				        <li class="mline"></li>
	                </#if>
	    		</#list>
    		</#if>
        </ul>
    </div>
    <!--menu end-->
    <div class="banner">
    	<ul>
    		<#if indexAds?size &gt; 0>
    			<#list indexAds as ad>
				    <li style="background-image: url('${ctx}/resources/${ad.picUrl}');cursor:pointer;" 
				    onclick='javascript:locationTo("${(ad.url)!}");'/>
			    </#list>
		    </#if>
		</ul>
    </div>
    <!--banner end-->
    <!--center start-->
    <script type="text/javascript">
	    $(function() {
	        $('.banner').unslider({
	        	speed: 500,               //  The speed to animate each slide (in milliseconds)
				delay: 3000,              //  The delay between slide animations (in milliseconds)
				complete: function() {},  //  A function that gets called after every slide animation
				keys: true,               //  Enable keyboard (left, right) arrow shortcuts
				dots: true,               //  Display dot navigation
				fluid: false              //  Support responsive design. May break non-responsive designs
	        });
	    });
    </script>
    <div class="center">
    	<!--left start-->
        <div class="left">
    <div class="left-top">${(parentCol.enName)!'--'}</div>
    <#if ((parentCol.childColumn)?size)&gt;0>
    	<ul class="left-menu">
    		<#list parentCol.childColumn as childColumn>
               <li>
               		<a href="${ctx}/${childColumn.url}" id="c_${childColumn.code}" title="${(childColumn.enName)!''}">${(childColumn.enName)!'--'}</a>
               		<#if (childColumn.categorys)?size &gt; 0>
               		<ul>
               			<#list childColumn.categorys as cate>
				        	<li><a href='${ctx}/cate' title='${cate.enName}' id= >${cate.enName}</a></li>
               			</#list>
		        	</ul>
               		</#if>
               </li>
    		</#list>
    	</ul>
    </#if>
    <div class="left-top m_t_10">CONTACT US</div>
    <div class="left-contact">
        <img alt="" src="${ctx}/resources/views/css/contact.jpg" height="52" width="204"> Tel :${(company.telPhone)!''}<br>
		Email :${(company.email)!'--'}<br>
		Contact: ${(company.contactUser)!'--'}<br>
		Shenzhen Office Address: ${(company.address)!''}
    </div>
</div>
        <!--left end-->
        <!--right start-->
        <div class="right">
        	<div class="sitemap">
    <h1>${column.enName}</h1><span></span>
    <div>You are here: <a href='${ctx}'>Home</a> &gt;&gt;
    <#if (parentCol.enName != column.enName)>
    	<a href="${ctx}/${(parentCol.url)!''}">${parentCol.enName}</a>&gt;&gt;
    </#if> 
    <a href='${ctx}/${(column.url)!''}'>${column.enName}</a></div>
</div>
            <div class="con-panel">
            <#--virtual 相对路径-->
            <!--#include virtual="../product/${column.code}/1.htm"-->
            </div>
        </div>
        <!--right end-->
    </div>
    <!--center end-->
    <!--botnav start-->
<div class="botnav">
    	<div class="wd">
            <ul>
            	<li class="contact">
            		<div class="hotline">
                        ${(company.telPhone)!''}
                    </div>
            	</li>
            	<li class="contact">
            		<div class="email">
                    	<a href="mailto:${(company.email)!''}" target="_blank" style="color:#2469e7;">${(company.email)!''}</a>
                    </div>
            	</li>
                <li class="contact">
                    <div class="dizhi">
                    	${(company.address)!''}
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="footer">
        <div class="wd">
        	Copyright &copy; 2015 
        	<#if .now?string("yyyy")!="2015">
        		-${.now?string("yyyy")} 
        	</#if>
            Shenzhen hien technology co.,ltd . All rights reserved.<br>
        </div>
    </div>
    <link href="${ctx}/resources/views/images/kefu.css" type="text/css" rel="stylesheet">
</body>
</html>