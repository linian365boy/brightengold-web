// JavaScript Document
	$(function(){			
	   $(".jqzoom").jqueryzoom({
			xzoom:300,
			yzoom:225,
			offset:10,
			position:"right",
			preload:1,
			lens:1
		});
		$("#spec-list").jdMarquee({
			deriction:"left",
			width:327,
			height:72,
			step:2,
			speed:4,
			delay:10,
			control:true,
			_front:"#spec-right",
			_back:"#spec-left"
		});
		$("#spec-list img").bind("mouseover",function(){
			var src=$(this).attr("bigpic");
			var src_1=$(this).attr("oripic");
			$("#spec-n1 img").eq(0).attr({
				src:src.replace("\/n5\/","\/n1\/"),
				jqimg:src_1.replace("\/n5\/","\/n0\/")
			});
			$("#spec-list img").removeClass();
			$(this).addClass('on');
		}).bind("mouseout",function(){
			$("#spec-list img").removeClass();
			$(this).addClass('on');
		});				
	})