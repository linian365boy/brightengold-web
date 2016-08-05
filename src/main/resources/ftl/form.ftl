					<div lang="en-US" dir="ltr" id="wpcf7-f11-p358-o1" class="wpcf7" role="form">
						<div class="screen-reader-response"></div>
						<form novalidate="novalidate" class="wpcf7-form" method="post" action="${ctx}/views/feedback/add.html">
							<p>Full Name:<span class="cred">*</span><br>
					    		<span class="wpcf7-form-control-wrap your-name">
					    			<input type="text" aria-invalid="false" aria-required="true" class="wpcf7-form-control wpcf7-text wpcf7-validates-as-required" size="40" value="" name="name">
					    		</span> 
					    	</p>
							<p>Email Address:<span class="cred">*</span><br>
					    		<span class="wpcf7-form-control-wrap your-email">
					    			<input type="email" aria-invalid="false" aria-required="true" class="wpcf7-form-control wpcf7-text wpcf7-email wpcf7-validates-as-required wpcf7-validates-as-email" size="40" value="" name="email">
					    		</span> 
					    	</p>
							<p>Your Message:<span class="cred">*</span><br>
					    		<span class="wpcf7-form-control-wrap your-message">
					    			<textarea aria-invalid="false" class="wpcf7-form-control wpcf7-textarea" rows="10" cols="40" name="content">
					    			</textarea>
					    		</span> 
					    	</p>
					    	<p>
					    		验证码
					    	</p>
					    	<p class="cred">* Required information</p>
							<p>
								<input type="submit" class="wpcf7-form-control wpcf7-submit" value="Send Email">
								<img class="ajax-loader" src="${ctx}/resources/views/style-ewa/images/ajax-loader.gif" alt="发送中。。。" style="visibility: hidden;">
							</p>
							<div class="wpcf7-response-output wpcf7-display-none"></div>
						</form>
					</div>