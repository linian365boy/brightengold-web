<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery form plugin -->
<script src="/resources/plugins/jQueryForm/jquery.form.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/resources/plugins/jQueryUI/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.6 -->
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- Bootstrap table -->
<script src="/resources/plugins/bootstrap-table/bootstrap-table.js"></script>
<!-- put your locale files after bootstrap-table.js -->
<script src="/resources/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- Morris.js charts -->
<script src="/resources/plugins//raphael/raphael-min.js"></script>
<!-- <script src="/resources/plugins/morris/morris.min.js"></script> -->
<!-- Sparkline -->
<script src="/resources/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="/resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="/resources/plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="/resources/plugins/moment/moment.min.js"></script>
<script src="/resources/plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="/resources/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/resources/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<!-- <script src="/resources/dist/js/pages/dashboard.js"></script> -->
<!-- AdminLTE for demo purposes -->
<script src="/resources/dist/js/demo.js"></script>

<script type="text/javascript">
		$(function(){
			var pmenuText = "${pmenuText}";
			var menuText = "${menuText}";
			$.getJSON("${ctx}admin/sys/menu/findMenuByRole.html?t="+new Date().getTime(),function(json){
				var pMenu = json.tree.item;
				var str = "";
				if((pMenu!=null)&&(pMenu.length!=0)){
					for(var i=0;i<pMenu.length;i++){
						str+= "<li class='treeview'>";
						str+= "<a href='"+pMenu[i].url+"' id='nav_"+(i+1)+"' title="+pMenu[i].text+"><i class='fa fa-pie-chart'></i><span>"+pMenu[i].text+"</span><span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span></a>";
						var sMenu = pMenu[i].item;
						if((sMenu!=null)&&(sMenu.length!=0)){
							str+= "<ul class='treeview-menu'>";
							for(var j=0;j<sMenu.length;j++){
								str+="<li><a title="+sMenu[j].text+" href='javascript:void(0);' onclick='gotoMenu(&apos;${ctx}"+sMenu[j].url+"&apos;,&apos;"+pMenu[i].text+"&apos;,&apos;"+sMenu[j].text+"&apos;)'><i class='fa fa-circle-o'></i>"+sMenu[j].text+"</a></li>";
							}
							str+="</ul></li>";
						};
					};
				};
				$("#mainNavigation").after(str);
			});
		})
		
		function gotoMenu(url,ptext,text){
		  $("#menuForm").prop("action",url);
		  $("#pmenuText").val(ptext);
		  $("#menuText").val(text);
		  $(".sidebar .sidebar-menu li").removeClass("active");
	      $("a[title='"+text+"']").parents(".sidebar-menu li").addClass("active");
		  $('#menuForm').ajaxForm(function(data) {
	         $("#menuForm").prop("action","#");
	         $("#pmenuText").val("");
	    	 $("#menuText").val("");
	    	 if(data.indexOf("login")!=-1){
	    		 top.location.href="${ctx}admin/login.html";
	    	 }else{
		    	 $("div.content-wrapper").html(data);
	    	 }
	      });
		  $('#menuForm').submit();
	  }
		function runningFormatter(value, row, index){
			  return (index+1)+parseInt($(".page-size").text())*(parseInt($(".page-number.active").text())-1);
		}
		function actionFormatter(value, row, index) {
			    return [
			        '<a class="label label-info edit" href="javascript:void(0)" title="修改">修改</a>',
					'<a class="label label-danger ml10 remove" href="javascript:void(0)" title="删除">删除</a>'
			    ].join('');
		}
		window.actionEvents = {
				    'click .edit': function (e, value, row, index) {
				    	update(row.id);
				    },
				    'click .remove': function (e, value, row, index) {
				    	del(row.id);
				    }
		};
</script>