<#macro pager url totalPage curPage=1 class="" showPageNum=10 isCategory="false">
<nav class="woocommerce-pagination">
<ul class="page-numbers">
<#local halfPage=(showPageNum/2)?int/>
<#if (halfPage>=curPage)>
	<#if (curPage<=1)>
	<#else>
		<#if isCategory=="true">
			<li><a href="javascript:void(0);" onclick="goPage('${url}${category.id}',${curPage-1});" class="prev page-numbers">&larr;</a><li>
		<#else>
			<li><a href="javascript:void(0);" onclick="goPage('${url}${column.code}',${curPage-1});" class="prev page-numbers">&larr;</a><li>
		</#if>
	</#if>
	<@showPage start=1 end=curPage curPage=curPage url=url class=class isCategory=isCategory/>
	<#if (curPage+halfPage>totalPage)>
		<#local endPage=totalPage>
	<#else>
		<#local endPage=curPage+halfPage>
	</#if>
	<#if ((curPage+1)<=endPage)>
		<@showPage start=curPage+1 end=endPage curPage=curPage url=url class=class isCategory=isCategory/>
	</#if>
	<#if (curPage>=totalPage)>
	<#else>
		<#if isCategory=="true">
			<li><a href="javascript:void(0);" onclick="goPage('${url}${category.id}',${curPage+1});" class="next page-numbers">&rarr;</a><li>
		<#else>
			<li><a href="javascript:void(0);" onclick="goPage('${url}${column.code}',${curPage+1});" class="next page-numbers">&rarr;</a><li>
		</#if>
	</#if>
<#else>
	<#if (curPage<=1)>
	<#else>
		<#if isCategory=="true">
			<li><a href="javascript:void(0);" onclick="goPage('${url}${category.id}',${curPage-1});" class="prev page-numbers">&larr;</a><li>
		<#else>
			<li><a href="javascript:void(0);" onclick="goPage('${url}${column.code}',${curPage-1});" class="prev page-numbers">&larr;</a><li>
		</#if>
	</#if>
	<@showPage start=curPage-halfPage end=curPage curPage=curPage url=url class=class isCategory=isCategory/>
	<#if (curPage+halfPage>totalPage)>
		<#local endPage=totalPage>
	<#else>
		<#local endPage=curPage+halfPage>
	</#if>
	<#if ((curPage+1)<=endPage)>
		<@showPage start=curPage+1 end=endPage curPage=curPage url=url class=class isCategory=isCategory/>
	</#if>
	<#if (curPage>=totalPage)>
	<#else>
		<#if isCategory=="true">
			<li><a href="javascript:void(0);" onclick="goPage('${url}${category.id}',${curPage+1});" class="next page-numbers">&rarr;</a><li>
		<#else>
			<li><a href="javascript:void(0);" onclick="goPage('${url}${column.code}',${curPage+1});" class="next page-numbers">&rarr;</a><li>
		</#if>
	</#if>
</#if>
</ul>
</nav>
</#macro>

<#macro showPage start end curPage url class isCategory>
	<#list start..end as page>
		<#if curPage==page>
			<li><span class="page-numbers current">${curPage}</span></li>
		<#else>
			<#if isCategory=="true">
				<li><a href="javascript:void(0);" onclick="goPage('${url}${category.id}',${page});" class="page-numbers">${page}</a></li>
			<#else>
				<li><a href="javascript:void(0);" onclick="goPage('${url}${column.code}',${page});" class="page-numbers">${page}</a></li>
			</#if>
		</#if>
	</#list>
</#macro>