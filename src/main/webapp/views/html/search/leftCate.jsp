<%@include file="../../commons/include.jsp"%>
<div id="tertiary" class="sidebar-container" role="complementary">
	<div class="sidebar-inner">
		<div class="widget-area" id="sidebar-widgets">
			<aside id="woocommerce_product_search-2"
				class="widget woocommerce widget_product_search">
				<div id="sun">
					<h3 class="wpb_area_title">
						<span>Search Products</span>
					</h3>
				</div>
				<form role="search" method="get" class="woocommerce-product-search"
					action="${ctx}/views/products/search">
					<label class="screen-reader-text" for="s">Search for:</label> <input
						type="search" class="search-field"
						placeholder="Search Products&hellip;" value="${keyword }" name="keyword"
						title="Search for:"/> <input type="hidden" name="pageNo"
						value="${pageNo }" /> <input type="submit" value="Search" />
				</form>
			</aside>
			<aside id="woocommerce_product_categories-2"
				class="widget woocommerce widget_product_categories">
				<div id="sun">
					<h3 class="wpb_area_title">
						<span>Product Category</span>
					</h3>
				</div>
				<ul class="product-categories">
					<c:forEach items="${categorys}" var="pCategory">
						<li class="cat-item cat-item-420 cat-parent"><a
							href="${ctx}/views/html/col/${fn:replace(pCategory.enName,' ','')}.htm">${(pCategory.enName)}</a>
							<span class="count">(${(pCategory.productsSize)})</span> <c:if
								test="${fn:length(pCategory.children)>0}">
								<ul class='children'>
									<c:forEach items="${(pCategory.children)}" var="cCategory">
										<li class="cat-item cat-item-410"><a
											href="${ctx}/views/html/col/${fn:replace(cCategory.enName,' ','')}.htm">${(cCategory.enName)}</a>
											<span class="count">(${(cCategory.productsSize)})</span></li>
									</c:forEach>
								</ul>
							</c:if></li>
					</c:forEach>
				</ul>
			</aside>
			<aside id="text-2" class="widget widget_text">
				<div id="sun">
					<h3 class="wpb_area_title">
						<span>Lastest News</span>
					</h3>
				</div>
				<div class="textwidget">
					<ul class="product-categories">
						<c:forEach items="${indexNews}" var="news">
							<li class="cat-item cat-item-18"><a href="${ctx}/">${(news.title)}</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</aside>
		</div>
		<!-- .widget-area -->
	</div>
	<!-- .sidebar-inner -->
</div>
<!-- #tertiary -->