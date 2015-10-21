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
<body>
	<!--head start-->
    <div class="head">
    	<div class="wd">
            <div class="logo"><a href="${company.website}" title="${company.name}"><img src="${ctx}/resources/${company.logo}" width="480" height="91" alt="${company.name}" /></a></div>
            <div class="head-right">
            <!--
                <div class="banben">
                    <a href="/index.htm" title="Shenzhen Hien technology co.,ltd" class="en">English</a>
                    <a href="/zh_cnindex.htm" title="Shenzhen Hien technology co.,ltd" class="cn">中文版</a>
                    <a href="javascript:window.external.addFavorite('http://www.baidu.com','Shenzhen Hien technology co.,ltd') ; " title="Shenzhen Hien technology co.,ltd" class="addfav">Favorites</a>
                </div>
                 -->
                <div class="search">
                    <form target="_blank" method="post" name="searchform" id="searchform" action="/web/search.php?lanstr=en">
                        <input name="s" type="submit" class="search_btn" value="" /><input name="keywords" id="keywords" type="text" class="search_txt" /><span>Search：</span>
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
    <!--banner start-->
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
    <!--center start-->
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
	        <img alt="" width="204" height="52" src="${ctx}/resources/views/css/contact.jpg" /> Tel :${(company.telPhone)!''}<br />
			Email :${(company.email)!'--'}<br>
			Contact: ${(company.contactUser)!'--'}<br>
			Shenzhen Office Address: ${(company.address)!''}
    	</div>
	</div>
        <!--left end-->
        <!--right start-->
    <div class="right">
    	<div class="sitemap">
    		<h1>${category.enName}</h1><span></span>
	    	<div>You are here: <a href='${ctx}'>Home</a> &gt;&gt; 
			    <#if (parentCol.enName != column.enName)>
			    	<a href="${ctx}/${(parentCol.url)!''}">${parentCol.enName}</a>&gt;&gt;
			    </#if>
	    		<a href='${ctx}/${(column.url)!''}'>${column.enName}</a>
			    <#if (category.parent)??>
				    <a href='${ctx}/${(column.url)!''}'>${category.parent.enName}</a> 
			    </#if>
			</div>
		</div>
		<div class="con-panel">
			<!--产品详细 start-->
			<link href="${ctx}/resources/views/css/zoom.css?${style_v}" type="text/css" rel="stylesheet" />
			<link href="${ctx}/resources/views/css/pro_one.css?${style_v}" type="text/css" rel="stylesheet" />
			<script language="javascript" src="${ctx}/resources/views/images/zoom.js?${style_v}" type="text/javascript"></script>
			<script language="javascript" src="${ctx}/resources/views/images/lib.js?${style_v}" type="text/javascript"></script>
			<script language="javascript" src="${ctx}/resources/views/images/zoomcss.js?${style_v}" type="text/javascript"></script>
			<!-- 产品多图展示  开始 -->
			<div class="pro_detail">
		   		<!-- 产品图片展示 开始 -->
			   	<div class="pro_detail_pic pro_left" >
			        	<div id=preview>
			            	<div class=jqzoom id=spec-n1 style="line-height:227px;">
			            		<IMG src="${ctx}/resources/${model.picUrl}" 
			            			jqimg="${ctx}/resources/${model.picUrl}" width="300" height="227"/>
			            	</div>
			            	<#--
		            		<div id=spec-n5>
				                <div class=control id=spec-left>
				                    <img src="/web/template/themes/default/skins/images/left.gif" />
				                </div>
			                	<div id=spec-list>
			                    	<ul class=list-h>
			                        	<li><img src="${ctx}/resources/${model.picUrl}" 
			                        		bigpic="${ctx}/resources/${model.picUrl}"  class="on"  
			                        		oripic="${ctx}/resources/${model.picUrl}" width="60" height="45"> 
			                        	</li>
			                        	<li><img src="${ctx}/resources/${model.picUrl}" 
			                        		bigpic="${ctx}/resources/${model.picUrl}"  
			                        		oripic="${ctx}/resources/${model.picUrl}" width="60" height="45"> 
			                       	 	</li>
			                        	<li><img src="/web/userfiles/product/thumb/HE623-2.png" 
			                        		bigpic="/web/userfiles/product/middle/HE623-2.png"  
			                        		oripic="/web/userfiles/product/big/HE623-2.png" width="60" height="45"> 
			                        	</li>
			                    	</ul>
			                	</div>
			                	<div class=control id=spec-right>
			                    	<img src="/web/template/themes/default/skins/images/right.gif" />
			                	</div>
		            		</div>
		            		-->
		        		</div>
		   			</div>
			   		<!-- 产品图片展示 结束 -->
			   		<div class="pro_detail_name pro_right" >
			        	<div class="pro_name">Name：<b>${model.enName}</b></div>
			        	<div class="pro_name">Category：<a href="/239/" title="Wireless charger transmitter">${model.category.enName}</a></div>
			        	<div class="short_des">
			            	<b class="tezheng">Brief：</b><br />
			             	${model.introduce}
			        	</div>
			  		</div>
			</div>
	<!-- 产品多图展示 结束 -->
	<!-- 详细介绍 开始 -->
	<div class="prodes">
	    <div class="pro_tab_nav">
	        <span id="span1" class="span_on" onclick="gettab(1,2)">Description</span>
	        <#--<span id="span2" onclick="gettab(2,2)">Parameter</span>-->
	    </div>
    	<div id="tab1" class="tab_con" style="display:block;">
    		${(model.description)!'No description'}
			<br type="_moz" />
		</div>
			    <#--
			    <div id="tab2" class="tab_con">
			    <span style="font-size: 18px;"><strong>Parameter:</strong></span><strong></strong><br />
			<br />
			<table class="aliDataTable" border="1" style="margin: 0px; padding: 0px; font-family: Arial, Helvetica, sans-senif; font-size: 12px; font-stretch: inherit; line-height: 18px; border-collapse: collapse; border-spacing: 0px; word-wrap: break-word; width: 684px; color: rgb(51, 51, 51); height: 318px;">
			    <tbody style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Product name:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">HE-623 QI power bank wireless charger</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Input:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">micro USB 5V1A</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">2 USB output:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">DC5.0V2100mA</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Wireless output:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">5W(5v1a)</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Wireless standard:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">QI standard</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Wireless frequency:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">100-200kHz</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Power bank capacity:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">8000mAh li-polymer cell&nbsp;</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Weight:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">300g</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Size:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">155mm*75mm*15.5mm</td>
			        </tr>
			        <tr style="margin: 0px; padding: 0px; font-family: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit;">
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">Color:</td>
			            <td style="margin: 0px; padding: 1px; font-family: inherit; font-style: inherit; font-variant: inherit; font-stretch: inherit; line-height: inherit; float: none; word-wrap: break-word; color: rgb(0, 0, 0); border: 1px solid rgb(204, 204, 204);">white/black</td>
			        </tr>
			    </tbody>
			</table>
	    </div>
	    -->
	</div>
<!--描述 end-->
<#--
<div class="recommand">
	<div class="pro_tab_nav"><span class="span_on">Related Products</span></div>
	<script type="text/javascript" src="/web/template/themes/default/skins/js/MSClass.js"></script>
	<div id="pro_con">
		<ul class="prolist" id="pro_list">
        				<li>
                <a href="/239/87.html" title="HE601 QI wireless charger transmitter " class="pro-img"><img src="/web/userfiles/product/-E6-97-A0-E7-BA-BF-E5-85-85-E7-94-B5-E5-99-A8/HE601/list/601-5.jpg" width="165" height="125" alt="HE601 QI wireless charger transmitter " /></a>
                <a href="/239/87.html" title="HE601 QI wireless charger transmitter " style="font-size:12px;">HE601 QI wireless ch...</a>
            </li>
						<li>
                <a href="/239/85.html" title="HE600 5W QI wireless charger transmitter " class="pro-img"><img src="/web/userfiles/product/-E6-97-A0-E7-BA-BF-E5-85-85-E7-94-B5-E5-99-A8/HE600/list/600-6.jpg" width="165" height="125" alt="HE600 5W QI wireless charger transmitter " /></a>
                <a href="/239/85.html" title="HE600 5W QI wireless charger transmitter " style="font-size:12px;">HE600 5W QI wireless...</a>
            </li>
						<li>
                <a href="/239/83.html" title="HE630 QI wireless charger rectangle shape" class="pro-img"><img src="/web/userfiles/product/-E6-97-A0-E7-BA-BF-E5-85-85-E7-94-B5-E5-99-A8/HE630/list/630AA6.JPG" width="165" height="125" alt="HE630 QI wireless charger rectangle shape" /></a>
                <a href="/239/83.html" title="HE630 QI wireless charger rectangle shape" style="font-size:12px;">HE630 QI wireless ch...</a>
            </li>
						<li>
                <a href="/239/81.html" title="HE636 QI standard wireless charger 5V1A" class="pro-img"><img src="/web/userfiles/product/-E6-97-A0-E7-BA-BF-E5-85-85-E7-94-B5-E5-99-A8/HE636/list/636A9.JPG" width="165" height="125" alt="HE636 QI standard wireless charger 5V1A" /></a>
                <a href="/239/81.html" title="HE636 QI standard wireless charger 5V1A" style="font-size:12px;">HE636 QI standard wi...</a>
            </li>
						<li>
                <a href="/239/79.html" title="HE633 5V1A wireless charger for mobile phone " class="pro-img"><img src="/web/userfiles/product/-E6-97-A0-E7-BA-BF-E5-85-85-E7-94-B5-E5-99-A8/HE633/list/633YJ2.jpg" width="165" height="125" alt="HE633 5V1A wireless charger for mobile phone " /></a>
                <a href="/239/79.html" title="HE633 5V1A wireless charger for mobile phone " style="font-size:12px;">HE633 5V1A wireless ...</a>
            </li>
						<li>
                <a href="/239/75.html" title="HE632 5V1A QI wireless charger ultra-thin design" class="pro-img"><img src="/web/userfiles/product/-E6-97-A0-E7-BA-BF-E5-85-85-E7-94-B5-E5-99-A8/HE632/list/632A5.jpg" width="165" height="125" alt="HE632 5V1A QI wireless charger ultra-thin design" /></a>
                <a href="/239/75.html" title="HE632 5V1A QI wireless charger ultra-thin design" style="font-size:12px;">HE632 5V1A QI wirele...</a>
            </li>
			
		</ul>
	</div>
	<script type="text/javascript"> 
	var marqueediv1=new Marquee({
		MSClass	  : ["pro_list","pro_con"],
		Direction : 2,
		Step	  : 0,
		Width	  : 695,
		Height	  : 176,
		Timer	  : 20,
		DelayTime : 0,
		WaitTime  : 0,
		ScrollStep: 170,
		SwitchType: 0,
		AutoStart : true
		
	});
	</script>
</div>
-->
<div class="back"><a href="javascript:history.back(-1)">Back >></a></div>
<!--产品详细 end-->
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
