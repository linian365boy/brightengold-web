<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jQuery 2.2.3 -->
<script src="/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery form plugin -->
<script src="/resources/plugins/jQueryForm/jquery.form.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- Bootstrap table -->
<script src="/resources/plugins/bootstrap-table/bootstrap-table.js"></script>
<!-- put your locale files after bootstrap-table.js -->
<script src="/resources/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
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
  /* $(function () {
		$.getJSON("${ctx}admin/sys/menu/findMenuByRole.html?t="+new Date().getTime(),function(json){
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
	  //$("#menuForm").submit();
	  $('#menuForm').ajaxForm(function(data) { 
          alert("Thank you for your comment!");
          console.info(data);
          $("#menuForm").prop("action","#");
          $("#pmenuText").val("");
    	  $("#menuText").val("");
      });
  }*/
  
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