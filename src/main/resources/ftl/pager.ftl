<#macro pager url totalPage curPage=1 class="" showPageNum=10>
<nav class="woocommerce-pagination">
<ul class="page-numbers">
<#local halfPage=(showPageNum/2)?int/>
<#if (halfPage>=curPage)>
	<#if (curPage<=1)>
	<#else>
		<li><a href="javascript:void(0);" onclick="goPage(${curPage-1},'${column.code}');" class="prev page-numbers"><i class="fa fa-long-arrow-left"></i></a><li>
	</#if>
	<@showPage start=1 end=curPage curPage=curPage url=url class=class/>
	<#if (curPage+halfPage>totalPage)>
		<#local endPage=totalPage>
	<#else>
		<#local endPage=curPage+halfPage>
	</#if>
	<#if ((curPage+1)<=endPage)>
		<@showPage start=curPage+1 end=endPage curPage=curPage url=url class=class/>
	</#if>
	<#if (curPage>=totalPage)>
	<#else>
		<a href="javascript:void(0);" onclick="goPage(${curPage+1},'${column.code}');" class="next page-numbers"><i class="fa fa-long-arrow-right"></i></a>
	</#if>
<#else>
	<#if (curPage<=1)>
	<#else>
		<li><a href="javascript:void(0);" onclick="goPage(${curPage-1},'${column.code}');" class="prev page-numbers"><i class="fa fa-long-arrow-left"></i></a><li>
	</#if>
	<@showPage start=curPage-halfPage end=curPage curPage=curPage url=url class=class/>
	<#if (curPage+halfPage>totalPage)>
		<#local endPage=totalPage>
	<#else>
		<#local endPage=curPage+halfPage>
	</#if>
	<#if ((curPage+1)<=endPage)>
		<@showPage start=curPage+1 end=endPage curPage=curPage url=url class=class/>
	</#if>
	<#if (curPage>=totalPage)>
	<#else>
		<a href="javascript:void(0);" onclick="goPage(${curPage+1},'${column.code}');" class="next page-numbers"><i class="fa fa-long-arrow-right"></i></a>
	</#if>
</#if>
</ul>
</nav>
</#macro>

<#macro showPage start end curPage url class>
	<#list start..end as page>
		<#if curPage==page>
			<li><span class="page-numbers current">${curPage}</span></li>
		<#else>
			<li><a href="javascript:void(0);" onclick="goPage(${page},'${column.code}');" class="page-numbers">${page}</a></li>
		</#if>
	</#list>
</#macro>