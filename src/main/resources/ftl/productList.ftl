<#macro showNews cid titleNum>
<#nested>
			<ul class="products">
					<#list productPage.result as product>
						<li class="${(product_index%4==0)?string('first','')} ${((product_index+1)%4==0)?string('last','')} post-${product.id} product type-product status-publish has-post-thumbnail product_cat-prohormones-sarms product_tag-methoxydienone-powder shipping-taxable product-type-simple product-cat-prohormones-sarms product-tag-methoxydienone-powder instock">
							<a href="${ctx}/views/html/product/detail/${product.id}.htm">
								<img width="500" height="500" src="${ctx }/resources/${product.picUrl}" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="${product.enName}" />
								<h3>${product.enName}</h3>
							</a>
						</li>
					</#list>
			</ul>
</#macro>
<@showNews cid="1" titleNum=70>
</@showNews>
<#import "pager.ftl" as my/>
<@my.pager url="/views/html/product/" totalPage=productPage.totalPageNum curPage=productPage.currentPageIndex class="pagers" showPageNum=10 isCategory="false"/>
<script type="text/javascript">
		function goPage(urlPre,pageNo){
			jQuery("#productContent").load(urlPre+"/"+pageNo+".htm");
		}
</script>