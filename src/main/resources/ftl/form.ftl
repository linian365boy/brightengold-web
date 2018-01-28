					<div lang="en-US" dir="ltr" id="wpcf7-f11-p358-o1" class="wpcf7" role="form">
						<div class="screen-reader-response"></div>
						<form novalidate="novalidate" class="wpcf7-form">
							<p>Full Name<span class="cred">*</span>:<br>
					    		<span class="wpcf7-form-control-wrap your-name">
					    			<input type="text" required aria-invalid="false" aria-required="true" class="wpcf7-form-control wpcf7-text wpcf7-validates-as-required" size="40" name="name">
					    		</span> 
					    	</p>
							<p>Email Address<span class="cred">*</span>:<br>
					    		<span class="wpcf7-form-control-wrap your-email">
					    			<input type="email" required aria-invalid="false" aria-required="true" class="wpcf7-form-control wpcf7-text wpcf7-email wpcf7-validates-as-required wpcf7-validates-as-email" size="40" name="email">
					    		</span> 
					    	</p>
							<p>Your Message<span class="cred">*</span>:<br>
					    		<span class="wpcf7-form-control-wrap your-message">
					    			<textarea aria-invalid="false" class="wpcf7-form-control wpcf7-textarea" rows="10" cols="40" name="content"></textarea>
					    		</span> 
					    	</p>
					    	<p>Captcha<span class="cred">*</span>:<br>
					    		<span class="wpcf7-form-control-wrap captcha">
					    			<input name="kaptcha" required type="text" id="kaptcha" maxlength="4" class="chknumber_input" />
								    <img src="${ctx}/views/getVerifyCode.html" id="kaptchaImage"  style="margin-bottom: -3px"/>  
								    <a href="javascript:void(0);" id="kaptchaHref" onclick="changeCode();">Refresh the code</a>
					    		</span>
					    	</p>
					    	<p class="cred">* Required information</p>
							<p>
								<input type="submit" class="wpcf7-form-control wpcf7-submit" value="Send Email">
								<img class="ajax-loader" src="${ctx}/resources/views/style-ewa/images/ajax-loader.gif" alt="send now..." style="display: none;">
							</p>
							<div class="wpcf7-response-output wpcf7-display-none"></div>
						</form>
					</div>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery("form.wpcf7-form").submit(function(e){
				e.preventDefault();
				jQuery(".ajax-loader").show();
				jQuery("span.wpcf7-not-valid-tip").remove();
				jQuery("div.wpcf7-display-none").hide();
			  	jQuery.getJSON("${ctx}/views/feedback/add.html",{
			  			name:jQuery("input[name='name']").val(),
			  			email:jQuery("input[name='email']").val(),
			  			content:jQuery(".wpcf7-textarea").val(),
			  			kaptcha:jQuery("#kaptcha").val()
			  		},function(data){
			  			jQuery(".ajax-loader").hide();
				  		if(data.code==201){
				  			jQuery("#kaptcha").focus();
				  			jQuery("#kaptcha").after('<span role="alert" class="wpcf7-not-valid-tip">'+data.message+'</span>');
				  		}else if(data.code==202){
				  			if(data.data.name){
				  				jQuery("input[name='name']").focus();
				  				jQuery("input[name='name']").after('<span role="alert" class="wpcf7-not-valid-tip">'+data.data.name+'</span>');
				  			}
				  			if(data.data.email){
				  				jQuery("input[name='email']").focus();
				  				jQuery("input[name='email']").after('<span role="alert" class="wpcf7-not-valid-tip">'+data.data.email+'</span>');
				  			}
				  			if(data.data.content){
				  				jQuery(".wpcf7-textarea").focus();
				  				jQuery(".wpcf7-textarea").after('<span role="alert" class="wpcf7-not-valid-tip">'+data.data.content+'</span>');
				  			}
				  		}else if(data.code==200){
				  			jQuery(".wpcf7-textarea").val("");
				  		}
				  		jQuery("#kaptchaHref").click();
				  		jQuery("div.wpcf7-display-none").html(data.message).addClass("wpcf7-validation-errors").show();
			  	},"json");
			});
		});
		function changeCode(){
	    	jQuery('#kaptchaImage').hide().attr('src', '${ctx}/views/getVerifyCode.html?' + Math.floor(Math.random()*100)).fadeIn();  
	    	event.cancelBubble=true;
		}
	</script>