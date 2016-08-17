<footer class="sun" id="footer">
	<section class="footer-center" id="footercenter">
					<div class="container">
						<div class="container-inner">
            <div class="row">
             <div class="widget-2 col-lg-3 col-md-3 col-sm-6 col-xs-6 col-sp-12">
              <!-- Block CMS module -->
            <section class="footer-block" id="informations_block_left_1">
            <h4 class="title_block">Products</h4>
            <ul class="toggle-footer" style="">
             <li class="link">
            		<#list categorys as cate>
                            <a title="${(cate.enName)!''}" href="${ctx}/views/html/col/${(cate.enName)?replace('\\s*','','ri')}.htm">
                               ${(cate.enName)!''}
                            </a>
                   </#list>
             </li>
             </ul>
        </section>
           </div>
            <div class="widget-2 col-lg-3 col-md-3 col-sm-6 col-xs-6 col-sp-12">
            <section class="footer-block" id="informations_block_left_2">
            <h4 class="title_block">Follow Us</h4>
            <ul class="toggle-footer" style="">
         		<li class="link">
                            <a title="facebook" target="_blank" href="${(company.contactUserFacebook)!''}">
                            	<i class="fa fa-facebook-square fa-2"></i>
                            	<span>Facebook</span>
                            </a>
                </li>
                <li class="link">
                            <a title="twitter" target="_blank" href="${(company.contactUserTwitter)!''}">
                            	<i class="fa fa-tumblr-square fa-2"></i>
                            	<span>Twitter</span>
                            </a>
                 </li>
                 <li class="link">
                            <a title="google-plus" target="_blank" href="${(company.contactUsergooglePlus)!''}">
                            	<i class="fa fa-google-plus-square fa-2"></i>
                            	<span>Google Plus</span>
                            </a>
                 </li>
                 <li class="link">
                            <a title="Instagram" target="_blank" href="${(company.contactUserinstagram)!''}">
                            	<i class="fa fa-instagram fa-2"></i>
                            	<span>Instagram</span>
                            </a>
                  </li>
                 </ul>
        </section>
        <!-- /Block CMS module -->
                                                                                    </div>
 <div class="widget-2 col-lg-3 col-md-3 col-sm-6 col-xs-6 col-sp-12">
  <!-- MODULE Block contact infos -->
<section class="footer-block" id="block_contact_infos">
    <div>
        <h4 class="title_block">Contact Us</h4>
        <ul class="toggle-footer" style="">
            <li class="nohover">
            	<p>
            	<i class="fa fa-envelope-square fa-2"></i>
            	Email:<a href="mailto:${(company.email)!''}">${(company.email)!''}</a>
            </p>
            </li>
                            <li>
                </li>
                                                    <li>
                    <i class="fa fa-phone-square fa-2"></i>
                    <span>Tel:${(company.telPhone)!''}</span>
                </li>
                    </ul>
    </div>
</section>
                   </div>
       </div>
						</div>
					</div>
				</section>
</footer>
<a href="javascript:void(0);" id="tempHref" target="_blank" style="display:none;">
    	<span id="spanlink">slink</span>
    </a>