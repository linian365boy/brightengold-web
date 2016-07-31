<#macro pager url totalPage curPage=1 class="" showPageNum=10>
<nav class="woocommerce-pagination">
<ul class="page-numbers">
<#local halfPage=(showPageNum/2)?int/>
<#if (halfPage>=curPage)>
	<#if (curPage<=1)>
		<#--<a title="Previous" class="no_pre" href="javascript:void(0);">Prev</a>-->
	<#else>
		<#--<a title="Previous" onclick="goPage(${curPage-1},'${column.code}');" href="javascript:void(0);">Prev</a>-->
		<li><a href="javascript:void(0);" onclick="goPage(${curPage-1},'${column.code}');" class="prev page-numbers">←</a><li>
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
		<#--<a title="Next" class="no_next" href="javascript:void(0);">Next</a>-->
	<#else>
		<#--<a title="Next" href="javascript:void(0);" onclick="goPage(${curPage+1},'${column.code}');">Next</a>-->
		<a href="javascript:void(0);" onclick="goPage(${curPage+1},'${column.code}');" class="next page-numbers">→</a>
	</#if>
<#else>
	<#if (curPage<=1)>
		<#--<a title="Previous" class="no_pre" href="javascript:void(0);">Prev</a>-->
	<#else>
		<#--<a title="Previous"　href="javascript:void(0);"　onclick="goPage(${curPage-1},'${column.code}');">Prev</a>-->
		<li><a href="javascript:void(0);" onclick="goPage(${curPage-1},'${column.code}');" class="prev page-numbers">←</a><li>
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
		<#--<a title="Next" class="no_next" href="javascript:void(0);">Next</a>-->
	<#else>
		<#--<a title="Next" href="javascript:void(0);" onclick="goPage(${curPage+1},'${column.code}');">Next</a>-->
		<a href="javascript:void(0);" onclick="goPage(${curPage+1},'${column.code}');" class="next page-numbers">→</a>
	</#if>
</#if>
</ul>
</nav>
</#macro>

<#macro showPage start end curPage url class>
	<#list start..end as page>
		<#if curPage==page>
			<#--<a title="Go${page}Page" class="current">${curPage}</a>-->
			<li><span class="page-numbers current">${curPage}</span></li>
		<#else>
			<#--<a title="Go${page}Page" href="javascript:void(0);" onclick="goPage(${page},'${column.code}');" id="p${page}">${page}</a>-->
			<li><a href="javascript:void(0);" onclick="goPage(${page},'${column.code}');" class="page-numbers">3</a></li>
		</#if>
	</#list>
</#macro>