<div id="content" class="site-content" role="main">
		<nav class="woocommerce-breadcrumb" ><a href="${ctx}">Home</a>&nbsp;&#47;&nbsp;${(model.column.code)!'--'}</nav>	
		<h1 class="page-title">${(model.column.code)!'--'}</h1>
		<h2>${model.title}</h2>
		<div class="titBar">Hits:<span id="clickcount">0</span> | Publish Date:${model.publishDate?string("yyyy-MM-dd")}</div>
		<p>&nbsp;</p>
		<div class="introduction"><strong>Abstract:</strong>&#12288;&#12288;${(model.introduce)!'' }</div>
				<article id="post-28" class="post-28 page type-page status-publish hentry">
					<div class="entry-content">
					${(model.content)!'no content'}
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<div class="fl">
			<#if model.keyWords??>
			Tag:<#list model.keyWords?split(";") as keyw>
			${keyw}
			<#if keyw_has_next>|&nbsp;&nbsp;</#if>
			</#list>
			</#if>
		</div>
			</div><!-- .entry-content -->
					<footer class="entry-meta">
				</footer><!-- .entry-meta -->
				</article><!-- #post -->
		<div id="comments" class="comments-area">
		</div><!-- #comments -->			
</div><!-- #content -->