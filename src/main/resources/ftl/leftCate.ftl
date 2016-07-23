<div id="tertiary" class="sidebar-container" role="complementary">
		<div class="sidebar-inner">
			<div class="widget-area" id="sidebar-widgets">
				<aside id="woocommerce_product_search-2" class="widget woocommerce widget_product_search"><div id="sun" ><h3 class="wpb_area_title"><span>Search Products</span></h3></div><form role="search" method="get" class="woocommerce-product-search" action="http://www.genuineraws.com/">
	<label class="screen-reader-text" for="s">Search for:</label>
	<input type="search" class="search-field" placeholder="Search Products&hellip;" value="" name="s" title="Search for:" />
	<input type="submit" value="Search" />
	<input type="hidden" name="post_type" value="product" />
</form>
</aside>
<aside id="woocommerce_product_categories-2" class="widget woocommerce widget_product_categories">
<div id="sun" ><h3 class="wpb_area_title"><span>Product Category</span></h3></div>
<ul class="product-categories">
	<#list categorys as pCategory>
		<li class="cat-item cat-item-420 cat-parent">
			<a href="${ctx}/views/html/col/${(pCategory.enName)?replace('\\s*','','ri')}.htm">${(pCategory.enName)!''}</a> 
			<span class="count">(${((pCategory.products)?size)!0})</span>
			<#if ((pCategory.children)?size>0)>
				<ul class='children'>
					<#list (pCategory.children) as cCategory>
						<li class="cat-item cat-item-410">
							<a href="${ctx}/views/html/col/${(cCategory.enName)?replace('\\s*','','ri')}.htm">${(cCategory.enName)!''}</a> 
							<span class="count">(${((cCategory.products)?size)!0})</span>
						</li>
					</#list>
				</ul>
			</#if>
		</li>
	</#list>
</ul>
</aside>
<aside id="text-2" class="widget widget_text">
<div id="sun"><h3 class="wpb_area_title"><span>Lastest News</span></h3></div>			
<div class="textwidget">
<ul class="product-categories">
	<#list indexNews as news>
		<li class="cat-item cat-item-18">
			<a href="${ctx}/">${(news.title)!''}</a> 
		</li>
	</#list>
</ul>
</div>
</aside>
					</div><!-- .widget-area -->
		</div><!-- .sidebar-inner -->
	</div><!-- #tertiary -->