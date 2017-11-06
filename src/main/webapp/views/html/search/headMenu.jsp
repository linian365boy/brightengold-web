<%@include file="../../commons/include.jsp" %>
<div id="utilitybar" class="utilitybar">
        	<div class="ubarinnerwrap">
                <div class="socialicons">
 
                </div>
                                <div class="topphone">
              
                    Tel :  ${(company.telPhone)}                </div>
                                
                                <div class="topphone">
             
                    Email:  ${(company.email)}                </div>
                                
            </div> 
        </div>
                
        <div class="headerwrap">
            <header id="masthead" class="site-header" role="banner">
         		<div class="headerinnerwrap">
					                        <a class="home-link" href="${ctx}/" title="${(company.name)}" rel="home">
                            <span><img src="${ctx}/resources/${(company.logo)}" alt="${(company.name)}" /></span>
                        </a>
                    	
        
                    <div id="navbar" class="navbar">
                        <nav id="site-navigation" class="navigation main-navigation" role="navigation">
                            <h3 class="menu-toggle">Menu</h3>
                            <a class="screen-reader-text skip-link" href="#content" title="Skip to content">Skip to content</a>
                            <div class="nav-container">
                            <ul id="menu-%e8%8f%9c%e5%8d%952" class="nav-menu">
                            	<li id="menu-item-680" class="menu-item menu-item-type-post_type menu-item-object-page　page_item page-item-75 
                            	menu-item-680 ${empty column?'current-menu-item current_page_item':''}">
                            		<a href="${ctx}/">Home</a>
                            	</li>
                            	<c:if test="${fn:length(crossCol)>0 }">
								<c:forEach items="${ crossCol}" var="col">
									<li id="menu-item-685" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children 
									menu-item-685 ${((!empty column) && (col.id)==(column.id))?'current-menu-item current_page_item':''}">
										<a href="${ctx}/views/html/col/${col.code}.htm">${col.enName}</a>
										<c:if test="${fn:length(col.childColumn)>0}">
										<ul class="sub-menu">
											<c:forEach items="${ col.categorys}" var="cate">
												<li id="menu-item-818" class="menu-item menu-item-type-taxonomy menu-item-object-product_cat menu-item-818">
												<a href="${ctx}/views/html/col/${cate.id}.htm">${(cate.enName)}</a></li>													
											</c:forEach>
										</ul>
										</c:if>
									</li>
								</c:forEach>
								</c:if>													
							</ul>
							</div>                        
						</nav><!-- #site-navigation -->			
                    </div><!-- #navbar -->
                    <div class="clear"></div>
                </div>
            </header><!-- #masthead -->
        </div>
        <!-- #Banner -->
        <div class="other-slider">
	       	<div  style="margin-top:0px;" id="owl-demo-side-flash" class="owl-carousel">
	       		<div class="banner">
	       			<ul>
					<c:if test="${fn:length(indexAds)>0}">
						<c:forEach items="${indexAds}" var="ad">
							<li style="background-image: url('${ctx}/resources/${ad.picUrl}');cursor:pointer;"
							onclick='javascript:locationTo("${(ad.url)}");'/>
						</c:forEach>
					</c:if>
					</ul>
				</div>
			</div>
		</div>
