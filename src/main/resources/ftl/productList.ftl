<#macro showNews cid titleNum>
<#nested>
<#--<#local news=newsList[cid]/>-->
<#--
<ul class="prolist">
	<#list productPage.result as product>
		<li>
	        <a href="${ctx}/views/html/product/${column.code}/${productPage.currentPageIndex}/${product.url}" 
	        	title="${product.enName}" class="pro-img">
	        	<img src="${ctx }/resources/${product.picUrl}" width="165" height="125" alt="${product.enName}" />
	        </a>
	        <a href="${ctx}/views/html/product/${column.code}/${productPage.currentPageIndex}/${product.url}" 
	        	title="${product.enName}"><#if (((product.enName)?length) <= 20)>${product.enName}<#else>${(product.enName)[0..19]}...</#if></a>
	    </li>
	</#list>
</ul> -->

					<ul class="products">
						<#list productPage.result as product>
							<li class="${(product_index%4==0)?string('first','')} ${((product_index+1)%4==0)?string('last','')} post-${product.id} product type-product status-publish has-post-thumbnail product_cat-prohormones-sarms product_tag-methoxydienone-powder shipping-taxable product-type-simple product-cat-prohormones-sarms product-tag-methoxydienone-powder instock">
								<a href="${ctx}/views/html/product/${column.code}/${productPage.currentPageIndex}/${product.url}">
									<img width="500" height="500" src="${ctx }/resources/${product.picUrl}" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="${product.enName}" />
									<h3>${product.enName}</h3>
								</a>
							</li>
						</#list>
						<#--
						<li class="first post-1066 product type-product status-publish has-post-thumbnail product_cat-prohormones-sarms product_tag-methoxydienone-powder shipping-taxable product-type-simple product-cat-prohormones-sarms product-tag-methoxydienone-powder instock">
							<a href="http://www.genuineraws.com/product/methoxydienone-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Methoxydienone-Powder.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Methoxydienone Powder" />
								<h3>Methoxydienone Powder</h3>
							</a>
						</li>
						<li class="post-312 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-testosterone-acetate-powder product_tag-testosterone-acetate-powder-for-sale product_tag-testosterone-acetate-powder-manufacturers product_tag-testosterone-acetate-powder-price product_tag-testosterone-acetate-powder-recipe product_tag-testosterone-acetate-powder-suppliers shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-testosterone-acetate-powder product-tag-testosterone-acetate-powder-for-sale product-tag-testosterone-acetate-powder-manufacturers product-tag-testosterone-acetate-powder-price product-tag-testosterone-acetate-powder-recipe product-tag-testosterone-acetate-powder-suppliers instock">
							<a href="http://www.genuineraws.com/product/testosterone-acetate-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-Acetate-1.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Testosterone Acetate Powder" />
								<h3>Testosterone Acetate Powder</h3>
							</a>
						</li>
						<li class="post-112 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-testosterone-enanthate product_tag-testosterone-enanthate-powder shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-testosterone-enanthate product-tag-testosterone-enanthate-powder instock">
							<a href="http://www.genuineraws.com/product/testosterone-enanthate-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-enanthate.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="testosterone enanthate powder manufacturers" />
								<h3>Testosterone Enanthate Powder</h3>
							</a>
						</li>
						<li class="last post-113 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-buy-testosterone-propionate-powder product_tag-testosterone-propionate-powder product_tag-testosterone-propionate-powder-conversion product_tag-testosterone-propionate-powder-manufacturers shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-buy-testosterone-propionate-powder product-tag-testosterone-propionate-powder product-tag-testosterone-propionate-powder-conversion product-tag-testosterone-propionate-powder-manufacturers instock">
							<a href="http://www.genuineraws.com/product/testosterone-propionate-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-Propionate-1.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="raw Testosterone Propionate powder" />
								<h3>Testosterone Propionate Powder</h3>
							</a>
						</li>
						
						
						<li class="first post-504 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-raw-testosterone-cypionate-powder product_tag-testosterone-cypionate-powder product_tag-testosterone-cypionate-powder-conversion product_tag-testosterone-cypionate-powder-for-sale product_tag-testosterone-cypionate-powder-manufacturers product_tag-testosterone-cypionate-powder-price shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-raw-testosterone-cypionate-powder product-tag-testosterone-cypionate-powder product-tag-testosterone-cypionate-powder-conversion product-tag-testosterone-cypionate-powder-for-sale product-tag-testosterone-cypionate-powder-manufacturers product-tag-testosterone-cypionate-powder-price instock">
							<a href="http://www.genuineraws.com/product/testosterone-cypionate-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-Cypionate-1.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="testosterone cypionate powder manufacturers" />
								<h3>Testosterone Cypionate Powder</h3>
							</a>
						</li>
						<li class="post-114 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-test-phenylpropionate product_tag-testosterone-phenylpropionate shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-test-phenylpropionate product-tag-testosterone-phenylpropionate instock">
							<a href="http://www.genuineraws.com/product/testosterone-phenylpropionate-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-Isocaproate-1.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Testosterone Isocaproate raw powder" />
								<h3>Testosterone Phenylpropionate Powder</h3>
							</a>
						</li>
						<li class="post-115 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-omnadren product_tag-sustanon-250 product_tag-testosterone-blend product_tag-testosterone-sustanon-250 shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-omnadren product-tag-sustanon-250 product-tag-testosterone-blend product-tag-testosterone-sustanon-250 instock">
							<a href="http://www.genuineraws.com/product/sustanon-250-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Sustanon250.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="sustanon 250 powder conversion" />
								<h3>Sustanon 250 Powder</h3>
							</a>
						</li>
						<li class="last post-309 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-testosterone-base shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-testosterone-base instock">
							<a href="http://www.genuineraws.com/product/testosterone-base-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-Base-1.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="testosterone base powder recipe" />
								<h3>Testosterone Base Powder</h3>
							</a>
						</li>
						
						<li class="first post-310 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-methyltestosterone shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-methyltestosterone instock">
							<a href="http://www.genuineraws.com/product/17-methyltestosterone-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/17-Methyltestosterone-Powder.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="17-Methyltestosterone Powder" />
								<h3>17-Methyltestosterone Powder</h3>
							</a>
						</li>
						<li class="post-457 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-testosterone-decanoate shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-testosterone-decanoate instock">
							<a href="http://www.genuineraws.com/product/testosterone-decanoate-powder/">
								<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-decanoate.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Testosterone decanoate raw powder" />
								<h3>Testosterone Decanoate Powder</h3>
							</a>
						</li>
						<li class="post-302 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-andriol product_tag-testosterone-undecanoate shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-andriol product-tag-testosterone-undecanoate instock">

	
	<a href="http://www.genuineraws.com/product/testosterone-undecanoate-powder/">

		<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-Undecanoate-1.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Buy Testosterone undecanoate powder" />
		<h3>Testosterone Undecanoate Powder</h3>

		

	</a>

	
</li>

					
						<li class="last post-308 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-testosterone-isocaproate shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-testosterone-isocaproate instock">

	
	<a href="http://www.genuineraws.com/product/testosterone-isocaproate-powder/">

		<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Testosterone-Isocaproate-1.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Testosterone Isocaproate raw powder" />
		<h3>Testosterone Isocaproate Powder</h3>

		

	</a>

	
</li>

					
						<li class="first post-459 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-fluoxymesterone-halotestin-powder product_tag-fluoxymesterone-powder product_tag-halotestin-fluoxymesterone-powder product_tag-halotestin-powder shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-fluoxymesterone-halotestin-powder product-tag-fluoxymesterone-powder product-tag-halotestin-fluoxymesterone-powder product-tag-halotestin-powder instock">

	
	<a href="http://www.genuineraws.com/product/fluoxymesterone-halotestin-powder/">

		<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Fluoxymesterone-Powder.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Fluoxymesterone Powder" />
		<h3>Fluoxymesterone Halotestin Powder</h3>

		

	</a>

	
</li>

					
						<li class="post-455 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-buy-proviron-mesterolone-powder product_tag-proviron-mesterolone-powder product_tag-proviron-mesterolone-powder-side-effects product_tag-proviron-mesterolone-powder-suppliers shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-buy-proviron-mesterolone-powder product-tag-proviron-mesterolone-powder product-tag-proviron-mesterolone-powder-side-effects product-tag-proviron-mesterolone-powder-suppliers instock">

	
	<a href="http://www.genuineraws.com/product/mesterolone-proviron-powder/">

		<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Proviron-Mesterolone-Powder.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Proviron Mesterolone Powder" />
		<h3>Proviron Mesterolone Powder</h3>
	</a>
</li>
						<li class="post-505 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-testosterone-series product_tag-4-chlorotestosterone-acetate product_tag-clostebol-acetate product_tag-megagrisevit shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-testosterone-series product-tag-4-chlorotestosterone-acetate product-tag-clostebol-acetate product-tag-megagrisevit instock">
	<a href="http://www.genuineraws.com/product/clostebol-acetate-powder/">
		<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Clostebol-Acetate-Powder.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="Clostebol Acetate Powder" />
		<h3>Clostebol Acetate Powder</h3>
	</a>
	</li>
						<li class="last post-258 product type-product status-publish has-post-thumbnail product_cat-raw-steroid-powders product_cat-trenbolone-series product_tag-tren-ace-raw-powder product_tag-trenbolone-acetate product_tag-trenbolone-acetate-powder product_tag-trenbolone-acetate-powder-for-sale product_tag-trenbolone-acetate-powder-recipe product_tag-trenbolone-acetate-powder-wholesale shipping-taxable product-type-simple product-cat-raw-steroid-powders product-cat-trenbolone-series product-tag-tren-ace-raw-powder product-tag-trenbolone-acetate product-tag-trenbolone-acetate-powder product-tag-trenbolone-acetate-powder-for-sale product-tag-trenbolone-acetate-powder-recipe product-tag-trenbolone-acetate-powder-wholesale instock">
	<a href="http://www.genuineraws.com/product/trenbolone-acetate-powder/">
		<img width="500" height="500" src="http://www.genuineraws.com/wp-content/uploads/Trenbolone-acetate.jpg" class="attachment-shop_catalog size-shop_catalog wp-post-image" alt="trenbolone acetate powder recipe" />
		<h3>Trenbolone Acetate Powder</h3>
	</a>
</li> -->
				</ul>
</#macro>
<@showNews cid="1" titleNum=70>
</@showNews>
<#import "pager.ftl" as my/>
<@my.pager url="#" totalPage=productPage.totalPageNum curPage=productPage.currentPageIndex class="pagers" showPageNum=10/>