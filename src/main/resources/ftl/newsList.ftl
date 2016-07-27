<#macro showNews cid titleNum>
<#nested>
<#--<#local news=newsList[cid]/>-->
<ul class="newslist">
<#list newsPage.result as new>
    <li>
    	<a title="${new.title}" href="${ctx}/views/html/news/detail/${new.url}">
    	${(newsPage.currentPageIndex-1)*newsPage.pageSize+new_index+1}&nbsp;&nbsp;
	    	<#if (new.title?length>titleNum)>
				${new.title[0..titleNum]}...
				<#else>
				${new.title}
			</#if>
    	</a>
        <span>
	        <#if new.publishDate??>
				${new.publishDate}
			<#else>
				${.now?string("yyyy-MM-dd")}
			</#if>
		</span>
	</li>
</#list>
</ul>
</#macro>
<@showNews cid="1" titleNum=70>
</@showNews>
<#import "pager.ftl" as my/>
<@my.pager url="#" totalPage=newsPage.totalPageNum curPage=newsPage.currentPageIndex class="pagers" showPageNum=10/>