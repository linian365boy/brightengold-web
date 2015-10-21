<#macro showNews cid titleNum>
<#nested>
<#--<#local news=newsList[cid]/>-->
<ul class="prolist">
	<#list productPage.result as product>
		<li>
	        <a href="${ctx}/views/html/product/${category.id}/${productPage.currentPageIndex}/${product.url}" 
	        	title="${product.enName}" class="pro-img">
	        	<img src="${ctx }/resources/${product.picUrl}" width="165" height="125" alt="${product.enName}" />
	        </a>
	        <a href="${ctx}/views/html/product/${category.id}/${productPage.currentPageIndex}/${product.url}" 
	        	title="${product.enName}"><#if (((product.enName)?length) <= 20)>${product.enName}<#else>${(product.enName)[0..19]}...</#if></a>
	    </li>
	</#list>
</ul> 
</#macro>
<@showNews cid="1" titleNum=70>
</@showNews>
<#import "pager.ftl" as my/>
<@my.pager url="#" totalPage=productPage.totalPageNum curPage=productPage.currentPageIndex class="pagers" showPageNum=10/>