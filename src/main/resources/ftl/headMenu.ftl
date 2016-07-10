<div id="utilitybar" class="utilitybar">
        	<div class="ubarinnerwrap">
                <div class="socialicons">
 
                </div>
                                <div class="topphone">
              
                    Tel :  ${(company.telPhone)!''}                </div>
                                
                                <div class="topphone">
             
                    Email:  ${(company.email)!''}                </div>
                                
            </div> 
        </div>
                
        <div class="headerwrap">
            <header id="masthead" class="site-header" role="banner">
         		<div class="headerinnerwrap">
					                        <a class="home-link" href="http://www.genuineraws.com/" title="HongKong Shijingu Technology Co., Ltd" rel="home">
                            <span><img src="http://www.genuineraws.com/wp-content/uploads/QQ截图20160225163056.png" alt="HongKong Shijingu Technology Co., Ltd" /></span>
                        </a>
                    	
        
                    <div id="navbar" class="navbar">
                        <nav id="site-navigation" class="navigation main-navigation" role="navigation">
                            <h3 class="menu-toggle">Menu</h3>
                            <a class="screen-reader-text skip-link" href="#content" title="Skip to content">Skip to content</a>
                            <div class="nav-container">
                            <ul id="menu-%e8%8f%9c%e5%8d%952" class="nav-menu">
                            	<li id="menu-item-680" class="menu-item menu-item-type-post_type menu-item-object-page　page_item page-item-75 menu-item-680 ${column!'current-menu-item current_page_item'}">
                            		<a href="${ctx}/">Home</a>
                            	</li>
                            	<#if ((crossCol?size)>0)>
								<#list crossCol as col>
									<li id="menu-item-685" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-685 ${(col.id==column.id)?string('current-menu-item current_page_item','')}">
										<a href="${ctx}/views/html/col/${col.code}.htm">${col.enName}</a>
										<#if ((col.childColumn)?size>0)>
										<ul class="sub-menu">
											<#list col.childColumn as cCol>
												<li id="menu-item-818" class="menu-item menu-item-type-taxonomy menu-item-object-product_cat menu-item-818">
												<a href="${ctx}/views/html/col/${cCol.code}.htm">${(cCol.enName)!''}</a></li>													
											</#list>
										</ul>
										</#if>
									</li>
								</#list>
								</#if>													
							</ul>
							</div>                        
						</nav><!-- #site-navigation -->			
                    </div><!-- #navbar -->
                    <div class="clear"></div>
                </div>
            </header><!-- #masthead -->
        </div>
        <!-- #Banner -->
        <div class="other-slider" style="">
	       	<div  style="margin-top:0px;" id="owl-demo-side-flash" class="owl-carousel">
	       	<div class="lazyOwl"><p><img class="alignnone size-medium wp-image-815" src="http://www.genuineraws.com/wp-content/uploads/602.jpg" alt="602" width="1200" height="250" /></p>
</div></div>        </div>