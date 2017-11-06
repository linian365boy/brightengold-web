<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/resources/plugins/jQueryUI/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.6 -->
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="/resources/plugins//raphael/raphael-min.js"></script>
<script src="/resources/plugins/morris/morris.min.js"></script>
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
<script src="/resources/dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/resources/dist/js/demo.js"></script>
<script type="text/javascript">
		var t = new Date().getTime();
		$.getJSON("${ctx}/admin/sys/menu/findMenuByRole?t="+t,function(json){
			var pMenu = json.tree.item;
			var str = "";
			if((pMenu!=null)&&(pMenu.length!=0)){
				for(var i=0;i<pMenu.length;i++){
					if(i==0){
						str+= "<li class='active treeview'>";
					}else{
						str+= "<li class='treeview'>";
					}
					str+= "<a href='"+pMenu[i].url+"' id='nav_"+(i+1)+"' title="+pMenu[i].text+"><i class='fa fa-pie-chart'></i><span>"+pMenu[i].text+"</span><span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span></a>";
					var sMenu = pMenu[i].item;
					if((sMenu!=null)&&(sMenu.length!=0)){
						str+= "<ul class='treeview-menu'>";
						for(var j=0;j<sMenu.length;j++){
							if(j==0){
								str+="<li class='active'>";
							}else{
								str+="<li>";
							}
							str+="<a title="+sMenu[j].text+" href='${ctx}/"+sMenu[j].url+"'><i class='fa fa-circle-o'></i>"+sMenu[j].text+"</a></li>";
						}
						str+="</ul></li>";
					};
				};
			};
			$("#mainNavigation").after(str);
		});
</script>