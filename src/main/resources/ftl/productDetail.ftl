			<div id="content" class="site-content" role="main">
                <nav class="woocommerce-breadcrumb" itemprop="breadcrumb">
                	<a href="${ctx}/">Home</a>&nbsp;&#47;&nbsp;
                	<a href="${ctx}/views/html/col/${((product.category.enName)!'')?replace('\\s*','','ri')}.htm">${((product.category.enName)!'')!''}</a>
                	&nbsp;&#47;&nbsp;${(model.enName)!''}
                </nav>
			<div itemscope itemtype="${ctx}/resources/${model.picUrl}" id="product-1066" class="post-1066 product type-product status-publish has-post-thumbnail product_cat-prohormones-sarms product_tag-methoxydienone-powder shipping-taxable product-type-simple product-cat-prohormones-sarms product-tag-methoxydienone-powder instock">
							<div class="images">
							<a href="${ctx}/resources/${model.picUrl}" itemprop="image" class="woocommerce-main-image zoom" title="" data-rel="prettyPhoto"><img width="500" height="500" src="${ctx}/resources/${model.picUrl}" class="attachment-shop_single size-shop_single wp-post-image" alt="${(model.enName)!''}" title="${(model.enName)!''}" /></a>
							</div>
								<div class="summary entry-summary">
								<h1 itemprop="name" class="product_title entry-title">${(model.enName)!''}</h1>
						<div itemprop="offers" itemscope itemtype="${ctx}/resources/${model.picUrl}">
							<p class="price"></p>
						</div>
						<div class="product_meta" >
							<span class="posted_in">Categories: <a href="${ctx}/" rel="tag">${(product.category.enName)!''}</a>.</span>
							<div class="addthis_sharing_toolbox"></div>
						</div>
							</div><!-- .summary -->
						<div class="woocommerce-tabs">
							<ul class="tabs">
									<li class="description_tab">
										<a href="#tab-description">Description</a>
									</li>
										</ul>
								<div class="panel entry-content" id="tab-description">
									${(model.description)!'no description!'}
								</div>
								</div>
									<div class="related products">
									<#if (relatedProducts?? && (relatedProducts?size>0))>
									  <div class="wpb_slider_area wpb_latest_pro_sli wpb_fix_cart">
									  	<div id="sun" >
									  		<h3 class="wpb_area_title"><span>Related Product</span></h3>
									  	</div>
									  	<div class="supercat-des">
											<a class="img-class" title=""></a>		
										</div>
											<div id="owl-demo-related" class="owl-carousel">
												<#list relatedProducts as relatedp>
														<div class="item">
															<figure>
																<a href="${ctx}/relatedp" class="lazyOwl">
																	<img width="300" height="300" src="${ctx }/resources/${relatedp.picUrl}" class="wpb_pro_img wp-post-image" alt="${relatedp.enName}" />
																</a>
																<figcaption>
																	<h3 class="pro_title">${relatedp.enName}</h3>
																	<div class="price_area_fix">		
																		<p class="product woocommerce add_to_cart_inline " style="border:4px solid #ccc; padding: 12px;">
																			<a href="${ctx}/relatedp" rel="nofollow" data-product_id="440" data-product_sku="" data-quantity="1" class="button  product_type_simple">查看更多</a>
																		</p>
																	</div>
																</figcaption>
															</figure>
														</div>
													</#list>			
												</div>
											</div>	 
										</#if> 
									</div>
	</div><!-- #product-1066 -->
</div><!-- #content --></>