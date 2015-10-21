// JavaScript Document
$(document).ready(function(e) {
    $(".menu .bigli").hover(function(){
		$(this).children("a:first").addClass("ahover");
		$(this).children("ul").show();
	},function(){
		$(this).children("a:first").removeClass("ahover");
		$(this).children("ul").hide();
	});
	
	var target_obj = jQuery('.left');
	var target_obj1 = jQuery('.right');
	if (target_obj.length > 0 && target_obj1.length > 0) {  
		var left_height=$(".left").height();
		var right_height=$(".right").height();
		if(parseInt(left_height) > parseInt(right_height)){
			$(".right").css("height",left_height+"px");
		}
	}
		
	/*product up flash */
	$(".adlist li").hover(function(){
		$(this).find('.tmbox').animate({left: '0px',width:'246',opacity:0.2,top: '0px',height:'150'}, 500);
	},function(){
		$(this).find('.tmbox').animate({left: '123px',width:'0',opacity:0.8,top: '75px',height:'0'}, 500);
	});
	
});

function gettab(index,base){
	for(var i=1;i<=base;i++){
		if(i==index){
			$("#span"+i).addClass("span_on");
			$("#tab"+i).fadeIn("1000");
		}else{
			$("#span"+i).removeClass("span_on");
			$("#tab"+i).fadeOut("1000");
		}
	}
}

function locationTo(url){
	if(url!=''){
		$("#tempHref").attr("href",url);
		$("#spanlink").click();
		$("#tempHref").attr("href","javascript:void(0);");
	}
}

function goPage(pageNo,code){
	$("#pager").load("/news/"+code+"/"+pageNo+".htm");
}
