<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/resources/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/resources/dist/js/demo.js"></script>
<!-- page script -->
<script>
  $(function () {
    $("#table").DataTable();
    /*$('#table').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false
    });*/
    
    var t = new Date().getTime();
	$.getJSON("${ctx}admin/sys/menu/findMenuByRole.html?t="+t,function(json){
		var pMenu = json.tree.item;
		var str = "";
		var pmenuText = "${pmenuText}";
		var menuText = "${menuText}";
		if((pMenu!=null)&&(pMenu.length!=0)){
			for(var i=0;i<pMenu.length;i++){
				if(pmenuText==null || (pmenuText!=null && pmenuText!='' && pmenuText==pMenu[i].text)){
					str+= "<li class='active treeview'>";
				}else{
					str+= "<li class='treeview'>";
				}
				str+= "<a href='"+pMenu[i].url+"' id='nav_"+(i+1)+"' title="+pMenu[i].text+"><i class='fa fa-pie-chart'></i><span>"+pMenu[i].text+"</span><span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span></a>";
				var sMenu = pMenu[i].item;
				if((sMenu!=null)&&(sMenu.length!=0)){
					str+= "<ul class='treeview-menu'>";
					for(var j=0;j<sMenu.length;j++){
						if(menuText!=null && menuText!='' && menuText==sMenu[j].text){
							str+="<li class='active'>";
						}else{
							str+="<li>";
						}
						str+="<a title="+sMenu[j].text+" href='javascript:void(0);' onclick='gotoMenu(&apos;${ctx}"+sMenu[j].url+"&apos;,&apos;"+pMenu[i].text+"&apos;,&apos;"+sMenu[j].text+"&apos;)'><i class='fa fa-circle-o'></i>"+sMenu[j].text+"</a></li>";
					}
					str+="</ul></li>";
				};
			};
		};
		$("#mainNavigation").after(str);
	});
  });
  
  function gotoMenu(url,ptext,text){
	  $("#menuForm").prop("action",url);
	  $("#pmenuText").val(ptext);
	  $("#menuText").val(text);
	  $("#menuForm").submit();
  }
</script>