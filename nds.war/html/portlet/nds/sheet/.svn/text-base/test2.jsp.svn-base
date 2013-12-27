<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
</head>

<body>
<table border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
  <tr bgcolor="#FDFBE3">
  <form name="queryform" method="post" action="/nds/servlets/QueryInputHandler" onSubmit="return checkOptions(this);">
    <input type='hidden' name="sheet" value="10101">
    <input type='hidden' name="objectid" value="129192">
    <input type='hidden' name="input" value="true">
    <input type='hidden' name="quick_search_data" value="">
    <input type='hidden' name="quick_search_column" value="">
    <input type='hidden' name="quick_search" value="false">

    
    <input type='hidden' name='table' value='10102'>
    <input type='hidden' name='start' value='1'>
    <input type='hidden' name='range' value='50'>
    <input type='hidden' name='select_count' value='11'>
    <input type='hidden' name='select/0/columns' value='1307'>
    <input type='hidden' name='select/1/columns' value='1309,1535'>
    <input type='hidden' name='select/3/columns' value='1310'>
    <input type='hidden' name='select/4/columns' value='1311'>
    <input type='hidden' name='select/5/columns' value='1312'>
    <input type='hidden' name='select/6/columns' value='1313'>
    <input type='hidden' name='select/7/columns' value='1314'>
    <input type='hidden' name='select/8/columns' value='1316'>
    <input type='hidden' name='select/9/columns' value='1317'>
    <input type='hidden' name='select/10/columns' value='1318'>
    <input type='hidden' name='param_count' value='1'>
    <input type='hidden' name='param/0/columns' value='1319'>
    <input type='hidden' name='param/0/value' value="129192">
    <input type='hidden' id='orderColumns' name='order/columns' value='1307'>
    <input type='hidden' id='orderAsc' name='order/asc' value='false'>
    <input type='hidden' name='resulthandler' value='/sheet/sheet_item.jsp' >
    <input type='hidden' name='fullrange_subtotal' value='false' >
</form>
<form name="sheet_item_modify" method="post" action="/nds/control/command" onSubmit="return checkOptions(this);">
    <input type='hidden' name="sheet" value="10101">
    <input type="hidden" name="input" value="true">
    <input type='hidden' name="objectid" value="129192">
    <input type='hidden' name="directory" value="OUTLETDAYSALESHT_LIST">
     <input type='hidden' name="id1" value="129192">
    <input type='hidden' name="table" value="10102">

    
    <input type='hidden' name='start' value='1'>
    <input type='hidden' name='range' value='50'>
    <input type='hidden' id='orderColumns' name='order/columns' value='1307'>
    <input type='hidden' id='orderAsc' name='order/asc' value='false'>
    <input type='hidden' name='formRequest' value='/sheet/sheet_item.jsp?input=true&sheet=10101&objectid=129192'>
      <td >
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
        <!--这个表是用来控制布局的-->
        <tr><td>
        <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
          <tr>
            <td width="8%">&nbsp;</td>
            <td width="92%" valign="bottom">
              <div align="right"><font color="#FF3300"> </font></div>
            </td>
          </tr>
        </table>
        </td></tr>
		<tr><td>
		






        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" height="24">
          <tr>

    <td width="100%" align="left" >
 <Script language="javascript">
  function doCommand(form, cmd){
    if (cmd.indexOf("Delete")>=0 ){
        if (!confirm("你确认要删除吗?")) {
            return false;
        }
    }
    form.command.value=cmd;
   if( checkOptions(form) !=false){ showProgressWnd(); form.submit();}

  }

 </script>
<input type='hidden' name="command" value='Command.jsp error'>
          
<input class="command6_button" type='button' name='OutletDaySaleShtItemModify' value='&nbsp;保存选中条目' onclick="javascript:doCommand(sheet_item_modify, 'OutletDaySaleShtItemModify')" >


        
<input class="command6_button" type='button' name='OutletDaySaleShtItemDelete' value='&nbsp;删除选中条目' onclick="javascript:doCommand(sheet_item_modify, 'OutletDaySaleShtItemDelete')" >


        
<input class="command2_button" type='button' name='OutletDaySaleShtDelete' value='删&nbsp;&nbsp;&nbsp;&nbsp;除' onclick="javascript:doCommand(sheet_item_modify, 'OutletDaySaleShtDelete')" >


        
<input class="command2_button" type='button' name='OutletDaySaleShtSubmit' value='提&nbsp;&nbsp;&nbsp;&nbsp;交' onclick="javascript:doCommand(sheet_item_modify, 'OutletDaySaleShtSubmit')" >


        
<input class="command_button" type='button' name='Print' value='打&nbsp;&nbsp;&nbsp;&nbsp;印' onclick="javascript:printHidden('/nds/print/sheet_title.jsp?table=10101&id=129192&order/columns=1307&order/asc=false');" >
<span id="tag_close_window"></span>
<Script language="javascript">
 // check show close window button or not
 if(  self==top){
 	document.all("tag_close_window").insertAdjacentHTML("beforeEnd",
 	 "<input class='command_button' type='button' name='Cancle' value='关闭窗口' onclick='javascript:window.close();' >");
 }
</script>

            </td>
          </tr>
        </table>

<Script language="javascript">
function showProgressWnd() {
	
	ProgressWnd.style.visibility="visible";
	cover.style.visibility="visible";
	
}
function hideProgressWnd(){
	ProgressWnd.style.visibility="hidden";
	cover.style.visibility="hidden";
	
}
function printHidden(url) {
  showProgressWnd();
  document.body.insertAdjacentHTML("beforeEnd",
    "<iframe name=printHiddenFrame width=0 height=0></iframe>");
  var doc = printHiddenFrame.document;
  doc.open();
  doc.write("<body onload=\"setTimeout('parent.onprintHiddenFrame()', 0)\">");
  doc.write("<iframe name=printMe width=0 height=0 src=\"" + url + "\"></iframe>");
  doc.write("</body>");
  doc.close();
}

function onprintHiddenFrame() {
  function onfinish() {
    printHiddenFrame.outerHTML = "";
    if ( window.onprintcomplete ) window.onprintcomplete();
    hideProgressWnd();
  }
  printFrame(printHiddenFrame.printMe, onfinish);
}  
</script>
<DIV id=ProgressWnd style="Z-INDEX: 10; LEFT: 20px; VISIBILITY: hidden; POSITION: absolute; TOP: 120px">
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD width="30%"></TD>
    <TD bgColor=#ff9900>
      <TABLE height=70 cellSpacing=2 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD align=middle bgColor=#eeeeee>正在处理请求,请稍候...</TD></TR></TBODY></TABLE></TD>
    <TD width="30%"></TD></TR></TBODY></TABLE>
</DIV>
<DIV id=cover style="Z-INDEX: 9; LEFT: 0px; VISIBILITY: hidden; POSITION: absolute; TOP: 0px">
<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=middle><BR></TD></TR></TBODY></TABLE>
</DIV>

		</td></tr>
        <tr><td>
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#999999" align="center">
          <tr bgcolor="#FFFFFF">
            <td>
              <table width="98%" border="0" cellspacing="2" cellpadding="2" align="center">
                <tr>
                  <td align="left"><table border=0 cellspacing="0" cellpadding="0"><tr><td>
                
				<input class="command2_button" type='button' name='newItemBtn' value='新增条目'
				onclick="javascript:popup_window('/nds/sheet/sheet_item_add.jsp?sheet=10101&objectid=129192')" >
				<input class="command_button" type='button' name='Import' value='导&nbsp;&nbsp;&nbsp;&nbsp;入' onclick="javascript:import_excel()" >
                   &nbsp;&nbsp;&nbsp;&nbsp;
                    
        在<select class='select_quick' name='quick_search_column'><option value='1309,1535' selected>产品编号</option><option value='1311' >数量</option><option value='1314' >实售小计</option><option value='1316' >销售时间</option><option value='1317' >营业员编号</option><option value='1318' >发票编号</option></select>项查找符合条件：<input class="input_text" type="text" size="10" maxlength="255" name="quick_search_data">
		的数据<input class="command2_button" type='button' name='searchItemBtn' value='开始查找' onclick="javascript:searchItem(document.queryform, document.sheet_item_modify.quick_search_data.value, document.sheet_item_modify.quick_search_column.value)" >
        

                  </td> </tr></table>
                  </td>
                </tr>
                <tr>
                  <td align="left">
                    






 <Script language="javascript">
function unselectall()
{
    if(document.all.myCheckBoxAll.checked){
		document.all.myCheckBoxAll.checked = document.all.myCheckBoxAll.checked&0;
    } 	
}

function selectall(theForm)
{
    var length = 13;
    document.all.myCheckBoxAll.checked = document.all.myCheckBoxAll.checked|0;

    if (length == 0 ){
          return; 
    }
    if (length ==1 )
    {
       theForm.selectedItemIdx.checked=document.all.myCheckBoxAll.checked ;
    }
   
    if (length>1)
    {
      for (var i = 0; i < length; i++)
       {
        theForm.selectedItemIdx[i].checked=document.all.myCheckBoxAll.checked;         
       }
    }

} 
  function doSubmit(form, start,range){
   form.range.value=range;
   form.start.value=start;
   form.submit();
  }
  function setIndex(form,index){
    form.start.value=index;
    form.submit();

  }
  //Hawke begin
  function changeControlValue(control, value){
        control.value = value;
  }
  function reOrder(formName,columnValue){
        if(formName.orderColumns.value == columnValue){
            if(formName.orderAsc.value == 'true')
                formName.orderAsc.value = 'false';
            else
                formName.orderAsc.value = 'true'
        }else{
            formName.orderColumns.value = columnValue;
        }
        setIndex(formName,1);
  }
  function createReport(form){
        changeControlValue(form.resulthandler,"/reports/create_report.jsp");
        form.submit();
  }
  function pop_up(url, window_name){
        window.open(url,window_name);
  }
  function checkModifiedLine(controlName,line){
        if(controlName.value == undefined){
            if(line < controlName.length)
            {
                controlName[line].checked = true;
                //alert(line+':Got');
            }
        }else{
            if(line == 0)
                controlName.checked = true;
        }
  }
  function move(id,e){
	//document.getElementById(['']);
	var array = id.split('_');
	if(array.length < 3){
		alert("id("+")"+id+"错误！");
		return;
	}
	var row = array[1];
	var col = array[2];
	switch(e.keyCode){
		case 37:{
			var object = document.getElementById(id);
			if(object.value.length > 0)
				return;
			//alert("LEFT");
			col--;
			var nId = "column_" + row + "_" + col;
			//alert("Next Id:"+nId);
		 	var obj = document.getElementById([nId]);
			if(obj != null)
				obj.focus();
			break;
		}
		case 38:{
			//alert("UP");
			row--;
			var nId = "column_" + row + "_" + col;
			//alert("Next Id:"+nId);
		 	var obj = document.getElementById([nId]);
			if(obj != null)
				obj.focus();
			break;
		}
		case 39: {
			var object = document.getElementById(id);
			if(object.value.length > 0)
				return;
			//alert("RIGHT");
			col++;
			var nId = "column_" + row + "_" + col;
			//alert("Next Id:"+nId);
		 	var obj = document.getElementById([nId]);
			if(obj != null)
				obj.focus();
			break;
		}
		case 40:
		case 13:{
			//alert("DOWN");
			row++;
			var nId = "column_" + row + "_" + col;
			//alert("Next Id:"+nId);
		 	var obj = document.getElementById([nId]);
			if(obj != null)
				obj.focus();
			break;
		}
                default:{
                        if(e.keyCode != 9 && e.keyCode !=16)
                                checkModifiedLine(document.sheet_item_modify.selectedItemIdx,row);
                }
	}
	//alert("I got "+e.keyCode);
  }
  function refresh(form){
    form.submit();
  }
  function refreshPage(){
    document.queryform.submit();
  }
  function openScript(theURL) {
    var W=420,H=500;
    newWindow=window.open(theURL,"FlinkWindow",'width=' + W + ',height=' + H + ',dependent=yes,resizable=1,scrollbars=yes,menubar=no,status=yes' );
    newWindow.focus();
  }
  //Hawke end
</script>

<table border="0" width="98%" align="center">
  <tr>
    <td>
	
    	<input type="checkbox" name="myCheckBoxAll" value=1 onclick=selectall(sheet_item_modify)> 全选
        
      
      <img src="<%=contextPath%>/html/portlet/nds/sheet/images/begin.gif" width="22" height="18" border=0 > <img src="<%=contextPath%>/html/portlet/nds/sheet/images/back.gif" width="22" height="18" border=0>
      
      <img src="<%=contextPath%>/html/portlet/nds/sheet/images/next.gif" width="22" height="18"  border=0> <img src="<%=contextPath%>/html/portlet/nds/sheet/images/end.gif" width="22" height="18" border=0>
      
        
        每页显示条数：
        <select size="1" name="range" onChange="doSubmit(document.queryform, 1, this.value)">
          
          <option value="5" >5</option>
          
          <option value="10" >10</option>
          
          <option value="20" >20</option>
          
          <option value="50" selected>50</option>
          
          <option value="100" >100</option>
          
          <option value="200" >200</option>
          
          <option value="2000" >2000</option>
          
        </select>
        <a href='javascript:createReport(document.queryform)'>[创建报告]</a>
        
        <a href='javascript:refresh(document.queryform)'>[刷新]</a>
        共有13条记录，现在是第1至13条记录
    </td>
  </tr>
  <tr>
    <td valign="bottom">
      <hr noshade size="1">
    </td>
  </tr>
</table>
<table width="98%" border="1" cellspacing="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFFFFF">
              <tr bgcolor="#FFFFFF">
                   <td  background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                    <input type="button" name="thisisorder" value="序号">
                    
                    <input type="hidden" name="arrayItemSelecter" value="selectedItemIdx">
                   </td>
                   

                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1307" value="ID*↑" onClick="javascript:reOrder(queryform,'1307')">
                        
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1309,1535" value="产品编号*" onClick="javascript:reOrder(queryform,'1309,1535')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串'></font>
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1310" value="产品名称 " onClick="javascript:reOrder(queryform,'1310')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串'></font>
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1311" value="数量*" onClick="javascript:reOrder(queryform,'1311')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/num.gif' width=16 height=18 align=absmiddle alt='格式：任意数字'></font>
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1312" value="零售单价 " onClick="javascript:reOrder(queryform,'1312')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/num.gif' width=16 height=18 align=absmiddle alt='格式：任意数字'></font>
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1313" value="扣率(％) " onClick="javascript:reOrder(queryform,'1313')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/num.gif' width=16 height=18 align=absmiddle alt='格式：任意数字'></font>
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1314" value="实售小计*" onClick="javascript:reOrder(queryform,'1314')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/num.gif' width=16 height=18 align=absmiddle alt='格式：任意数字'></font>
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1316" value="销售时间 " onClick="javascript:reOrder(queryform,'1316')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/num.gif' width=16 height=18 align=absmiddle alt='格式：任意数字'></font>
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1317" value="营业员编号 " onClick="javascript:reOrder(queryform,'1317')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串'></font>
                      </td>
                    
                      <td nowrap background="<%=contextPath%>/html/portlet/nds/sheet/images/Nds_table_bg_2.gif">
                        
                        <input type="button" name="1318" value="发票编号 " onClick="javascript:reOrder(queryform,'1318')">
                        <font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串'></font>
                      </td>
                    
              </tr>
              
              <tr bgcolor="#EFEFEF">
               <td width="6%" height="20">1</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414556"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="0" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="1" onKeyDown="move('column_0_0',event)" maxlength="20" size="20" id="column_0_0" value="C89-ZA352-04000" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_0_0","T1095304161008")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=170435' target="_blank" title="点击查看产品编号*为C89-ZA352-04000的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           女式针织手套

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="2" onKeyDown="move('column_0_1',event)" maxlength="8" size="8" id="column_0_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           68

                </td>
                
                <td nowrap width="2%" height="20">
                           100

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="3" onKeyDown="move('column_0_2',event)" maxlength="15" size="15" id="column_0_2" value="68" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="4" onKeyDown="move('column_0_3',event)" maxlength="2" size="2" id="column_0_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="5" onKeyDown="move('column_0_4',event)" maxlength="20" size="20" id="column_0_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="6" onKeyDown="move('column_0_5',event)" maxlength="20" size="20" id="column_0_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#FFFFFF">
               <td width="6%" height="20">2</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414555"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="1" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="7" onKeyDown="move('column_1_0',event)" maxlength="20" size="20" id="column_1_0" value="C89-ZA351-57000" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_1_0","T1095304161009")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=170434' target="_blank" title="点击查看产品编号*为C89-ZA351-57000的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           针织围巾

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="8" onKeyDown="move('column_1_1',event)" maxlength="8" size="8" id="column_1_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           88

                </td>
                
                <td nowrap width="2%" height="20">
                           100

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="9" onKeyDown="move('column_1_2',event)" maxlength="15" size="15" id="column_1_2" value="88" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="10" onKeyDown="move('column_1_3',event)" maxlength="2" size="2" id="column_1_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="11" onKeyDown="move('column_1_4',event)" maxlength="20" size="20" id="column_1_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="12" onKeyDown="move('column_1_5',event)" maxlength="20" size="20" id="column_1_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#EFEFEF">
               <td width="6%" height="20">3</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414554"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="2" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="13" onKeyDown="move('column_2_0',event)" maxlength="20" size="20" id="column_2_0" value="C89-BF353-09000" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_2_0","T1095304161010")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=170414' target="_blank" title="点击查看产品编号*为C89-BF353-09000的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           山东绸运动帽

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="14" onKeyDown="move('column_2_1',event)" maxlength="8" size="8" id="column_2_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           65

                </td>
                
                <td nowrap width="2%" height="20">
                           100

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="15" onKeyDown="move('column_2_2',event)" maxlength="15" size="15" id="column_2_2" value="65" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="16" onKeyDown="move('column_2_3',event)" maxlength="2" size="2" id="column_2_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="17" onKeyDown="move('column_2_4',event)" maxlength="20" size="20" id="column_2_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="18" onKeyDown="move('column_2_5',event)" maxlength="20" size="20" id="column_2_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#FFFFFF">
               <td width="6%" height="20">4</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414553"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="3" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="19" onKeyDown="move('column_3_0',event)" maxlength="20" size="20" id="column_3_0" value="C89-BF356-04000" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_3_0","T1095304161010")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=170423' target="_blank" title="点击查看产品编号*为C89-BF356-04000的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           针织帽

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="20" onKeyDown="move('column_3_1',event)" maxlength="8" size="8" id="column_3_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           58

                </td>
                
                <td nowrap width="2%" height="20">
                           100

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="21" onKeyDown="move('column_3_2',event)" maxlength="15" size="15" id="column_3_2" value="58" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="22" onKeyDown="move('column_3_3',event)" maxlength="2" size="2" id="column_3_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="23" onKeyDown="move('column_3_4',event)" maxlength="20" size="20" id="column_3_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="24" onKeyDown="move('column_3_5',event)" maxlength="20" size="20" id="column_3_5" value="" />
                            

                           

                </td>
                
              </tr>
              

              <tr bgcolor="#EFEFEF">
               <td width="6%" height="20">5</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414552"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="4" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="25" onKeyDown="move('column_4_0',event)" maxlength="20" size="20" id="column_4_0" value="C89-BF352-15000" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_4_0","T1095304161134")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=170410' target="_blank" title="点击查看产品编号*为C89-BF352-15000的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           灯芯绒运动帽

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="26" onKeyDown="move('column_4_1',event)" maxlength="8" size="8" id="column_4_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           68

                </td>
                
                <td nowrap width="2%" height="20">
                           100

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="27" onKeyDown="move('column_4_2',event)" maxlength="15" size="15" id="column_4_2" value="68" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="28" onKeyDown="move('column_4_3',event)" maxlength="2" size="2" id="column_4_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="29" onKeyDown="move('column_4_4',event)" maxlength="20" size="20" id="column_4_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="30" onKeyDown="move('column_4_5',event)" maxlength="20" size="20" id="column_4_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#FFFFFF">
               <td width="6%" height="20">6</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414551"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="5" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="31" onKeyDown="move('column_5_0',event)" maxlength="20" size="20" id="column_5_0" value="C89-BF360-14000" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_5_0","T1095304161134")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=170464' target="_blank" title="点击查看产品编号*为C89-BF360-14000的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           针织帽

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="32" onKeyDown="move('column_5_1',event)" maxlength="8" size="8" id="column_5_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           58

                </td>
                
                <td nowrap width="2%" height="20">
                           100

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="33" onKeyDown="move('column_5_2',event)" maxlength="15" size="15" id="column_5_2" value="58" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="34" onKeyDown="move('column_5_3',event)" maxlength="2" size="2" id="column_5_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="35" onKeyDown="move('column_5_4',event)" maxlength="20" size="20" id="column_5_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="36" onKeyDown="move('column_5_5',event)" maxlength="20" size="20" id="column_5_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#EFEFEF">
               <td width="6%" height="20">7</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414550"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="6" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="37" onKeyDown="move('column_6_0',event)" maxlength="20" size="20" id="column_6_0" value="P08-KN407-68230" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_6_0","T1095304161135")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=172531' target="_blank" title="点击查看产品编号*为P08-KN407-68230的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           跑步鞋

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="38" onKeyDown="move('column_6_1',event)" maxlength="8" size="8" id="column_6_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           780

                </td>
                
                <td nowrap width="2%" height="20">
                           <span class='error_int'>84.61</span>

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="39" onKeyDown="move('column_6_2',event)" maxlength="15" size="15" id="column_6_2" value="660" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="40" onKeyDown="move('column_6_3',event)" maxlength="2" size="2" id="column_6_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="41" onKeyDown="move('column_6_4',event)" maxlength="20" size="20" id="column_6_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="42" onKeyDown="move('column_6_5',event)" maxlength="20" size="20" id="column_6_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#FFFFFF">
               <td width="6%" height="20">8</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414549"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="7" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="43" onKeyDown="move('column_7_0',event)" maxlength="20" size="20" id="column_7_0" value="C57-PF352-0300L" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_7_0","T1095304161136")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=169849' target="_blank" title="点击查看产品编号*为C57-PF352-0300L的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           女式弹力毛圈长裤

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="44" onKeyDown="move('column_7_1',event)" maxlength="8" size="8" id="column_7_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           280

                </td>
                
                <td nowrap width="2%" height="20">
                           <span class='error_int'>78.57</span>

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="45" onKeyDown="move('column_7_2',event)" maxlength="15" size="15" id="column_7_2" value="220" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="46" onKeyDown="move('column_7_3',event)" maxlength="2" size="2" id="column_7_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="47" onKeyDown="move('column_7_4',event)" maxlength="20" size="20" id="column_7_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="48" onKeyDown="move('column_7_5',event)" maxlength="20" size="20" id="column_7_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#EFEFEF">
               <td width="6%" height="20">9</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414548"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="8" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="49" onKeyDown="move('column_8_0',event)" maxlength="20" size="20" id="column_8_0" value="C58-PF352-1000L" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_8_0","T1095304161137")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=169669' target="_blank" title="点击查看产品编号*为C58-PF352-1000L的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           针织长裤

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="50" onKeyDown="move('column_8_1',event)" maxlength="8" size="8" id="column_8_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           240

                </td>
                
                <td nowrap width="2%" height="20">
                           100

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="51" onKeyDown="move('column_8_2',event)" maxlength="15" size="15" id="column_8_2" value="240" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="52" onKeyDown="move('column_8_3',event)" maxlength="2" size="2" id="column_8_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="53" onKeyDown="move('column_8_4',event)" maxlength="20" size="20" id="column_8_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="54" onKeyDown="move('column_8_5',event)" maxlength="20" size="20" id="column_8_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#FFFFFF">
               <td width="6%" height="20">10</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414547"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="9" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="55" onKeyDown="move('column_9_0',event)" maxlength="20" size="20" id="column_9_0" value="C58-PF152-1400M" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_9_0","T1095304161267")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=150051' target="_blank" title="点击查看产品编号*为C58-PF152-1400M的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           针织长裤

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="56" onKeyDown="move('column_9_1',event)" maxlength="8" size="8" id="column_9_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           220

                </td>
                
                <td nowrap width="2%" height="20">
                           100

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="57" onKeyDown="move('column_9_2',event)" maxlength="15" size="15" id="column_9_2" value="220" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="58" onKeyDown="move('column_9_3',event)" maxlength="2" size="2" id="column_9_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="59" onKeyDown="move('column_9_4',event)" maxlength="20" size="20" id="column_9_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="60" onKeyDown="move('column_9_5',event)" maxlength="20" size="20" id="column_9_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#EFEFEF">
               <td width="6%" height="20">11</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414546"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="10" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="61" onKeyDown="move('column_10_0',event)" maxlength="20" size="20" id="column_10_0" value="C58-MF357-0200M" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_10_0","T1095304161268")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=169551' target="_blank" title="点击查看产品编号*为C58-MF357-0200M的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           立领长袖开衫

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="62" onKeyDown="move('column_10_1',event)" maxlength="8" size="8" id="column_10_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           380

                </td>
                
                <td nowrap width="2%" height="20">
                           <span class='error_int'>84.21</span>

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="63" onKeyDown="move('column_10_2',event)" maxlength="15" size="15" id="column_10_2" value="320" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="64" onKeyDown="move('column_10_3',event)" maxlength="2" size="2" id="column_10_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="65" onKeyDown="move('column_10_4',event)" maxlength="20" size="20" id="column_10_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="66" onKeyDown="move('column_10_5',event)" maxlength="20" size="20" id="column_10_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#FFFFFF">
               <td width="6%" height="20">12</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414545"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="11" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="67" onKeyDown="move('column_11_0',event)" maxlength="20" size="20" id="column_11_0" value="C58-JB357-090XL" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_11_0","T1095304161269")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=169931' target="_blank" title="点击查看产品编号*为C58-JB357-090XL的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           羽绒外套

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="68" onKeyDown="move('column_11_1',event)" maxlength="8" size="8" id="column_11_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           820

                </td>
                
                <td nowrap width="2%" height="20">
                           <span class='error_int'>85.36</span>

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="69" onKeyDown="move('column_11_2',event)" maxlength="15" size="15" id="column_11_2" value="700" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="70" onKeyDown="move('column_11_3',event)" maxlength="2" size="2" id="column_11_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="71" onKeyDown="move('column_11_4',event)" maxlength="20" size="20" id="column_11_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="72" onKeyDown="move('column_11_5',event)" maxlength="20" size="20" id="column_11_5" value="" />
                            

                           

                </td>
                
              </tr>
              
              <tr bgcolor="#EFEFEF">
               <td width="6%" height="20">13</td>
               
                  

                
                <td nowrap width="6%" height="20">
                           
                               
                              <input type="hidden" name="itemid" value="414544"  >
                              
                              <input type="checkbox" name="selectedItemIdx" value="12" onclick="unselectall()" />
                              
                            

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="product_NO" tabIndex="73" onKeyDown="move('column_12_0',event)" maxlength="20" size="20" id="column_12_0" value="C58-JF352-090XL" />
                            
                            <a href='#' onclick=pop_up("/nds/servlets/query?table=10125&return_type=s&accepter_id=sheet_item_modify.column_12_0","T1095304161270")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                            

                           <a href='/nds/servlets/viewObject?table=10125&id=169690' target="_blank" title="点击查看产品编号*为C58-JF352-090XL的产品的详细信息'">↑</a>
                                        

                </td>
                
                <td nowrap width="13%" height="20">
                           保暖夹克

                </td>
                
                <td nowrap width="5%" height="20">
                           
                              <input type="text" name="QTY" tabIndex="74" onKeyDown="move('column_12_1',event)" maxlength="8" size="8" id="column_12_1" value="1" />
                            

                           

                </td>
                
                <td nowrap width="10%" height="20">
                           490

                </td>
                
                <td nowrap width="2%" height="20">
                           <span class='error_int'>87.75</span>

                </td>
                
                <td nowrap width="10%" height="20">
                           
                              <input type="text" name="REALAMT" tabIndex="75" onKeyDown="move('column_12_2',event)" maxlength="15" size="15" id="column_12_2" value="430" />
                            

                           

                </td>
                
                <td nowrap width="1%" height="20">
                           
                              <input type="text" name="SALEPERIOD" tabIndex="76" onKeyDown="move('column_12_3',event)" maxlength="2" size="2" id="column_12_3" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="SALESMANNO" tabIndex="77" onKeyDown="move('column_12_4',event)" maxlength="20" size="20" id="column_12_4" value="" />
                            

                           

                </td>
                
                <td nowrap width="13%" height="20">
                           
                              <input type="text" name="INVOICENO" tabIndex="78" onKeyDown="move('column_12_5',event)" maxlength="20" size="20" id="column_12_5" value="" />
                            

                           

                </td>
                
              </tr>
              
            </table>

<table border="0" width="98%" align="center">
  <tr>
    <td valign="top">

        <hr noshade size="1">

    </td>
  </tr>
  <tr>
    <td>
      
      <img src="<%=contextPath%>/html/portlet/nds/sheet/images/begin.gif" width="22" height="18" border=0 > <img src="<%=contextPath%>/html/portlet/nds/sheet/images/back.gif" width="22" height="18" border=0>
      
      <img src="<%=contextPath%>/html/portlet/nds/sheet/images/next.gif" width="22" height="18"  border=0> <img src="<%=contextPath%>/html/portlet/nds/sheet/images/end.gif" width="22" height="18" border=0>
      
        
        每页显示条数：
        <select size="1" name="select" onChange="doSubmit(document.queryform, 1, this.value)">
          
          <option value="5" >5</option>
          
          <option value="10" >10</option>
          
          <option value="20" >20</option>
          
          <option value="50" selected>50</option>
          
          <option value="100" >100</option>
          
          <option value="200" >200</option>
          
          <option value="2000" >2000</option>
          
        </select>
        <a href='javascript:createReport(document.queryform)'>[创建报告]</a>
        
        <a href='javascript:refresh(document.queryform)'>[刷新]</a>
    </td>
  </tr>
</table>

                  </td>
                </tr>
                <tr>
                  
                  <td align="left"><a href="/nds/sheet/sheet_item_add.jsp?sheet=10101&objectid=129192"><img src="<%=contextPath%>/html/portlet/nds/sheet/images/createrows.gif" width="18" height="13" border="0">
                    [新增条目</a>]</td>
                   
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <br>
        </td></tr>

        <tr><td>
        <table width="600" border="1" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#999999" align="left">
          <tr bgcolor="#FFFFFF">
            <td>
              <br>
              





 <Script language="javascript">
  function pop_up(url, window_name){
     window.open(url,window_name);
  }
</script>

<table align="center" border="0" cellpadding="1" cellspacing="4" width="100%">
<input type="hidden" name="id" value="129192">

    <input type="hidden" name="sheet" value="10101">
    <tr>

    <td height="18" width="16%" nowrap align="left">编号::</td>
    <td height="18" width="33%" nowrap align="left">
      RXA0312020007
    </td>



    <td height="18" width="16%" nowrap align="left">客户编号::</td>
    <td height="18" width="33%" nowrap align="left">
      
      <a href='/nds/servlets/viewObject?ifm=false&table=10032&id=111633'>CSA037</a>
      
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">客户名称::</td>
    <td height="18" width="33%" nowrap align="left">
      上海新华联
    </td>



    <td height="18" width="16%" nowrap align="left">日销时间::</td>
    <td height="18" width="33%" nowrap align="left">
      2003/11/30
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">店长::</td>
    <td height="18" width="33%" nowrap align="left">
      D3563113000
    </td>



    <td height="18" width="16%" nowrap align="left">总数量::</td>
    <td height="18" width="33%" nowrap align="left">
      13
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">总零售金额::</td>
    <td height="18" width="33%" nowrap align="left">
      3615
    </td>



    <td height="18" width="16%" nowrap align="left">总实售金额::</td>
    <td height="18" width="33%" nowrap align="left">
      3195
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">制单人工号::</td>
    <td height="18" width="33%" nowrap align="left">
      
      <a href='/nds/servlets/viewObject?ifm=false&table=10061&id=110131'>D106</a>
      
    </td>



    <td height="18" width="16%" nowrap align="left">核对人工号::</td>
    <td height="18" width="33%" nowrap align="left">&nbsp;
      
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">审核人工号::</td>
    <td height="18" width="33%" nowrap align="left">&nbsp;
      
    </td>



    <td height="18" width="16%" nowrap align="left">审核意见::</td>
    <td height="18" width="33%" nowrap align="left">&nbsp;
      
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">状态::</td>
    <td height="18" width="33%" nowrap align="left">
      未提交
    </td>


    
</table>

            </td>
          </tr>
        </table>
        </td></tr>
        <tr><td>
        <table width="600" border="0" cellspacing="0" cellpadding="0"align="left">
          <tr>
            <td>
 	<br><br>
            </td>
          </tr>
        </table>
      </td></tr>
      </table>
      </td>
</form>
    </tr>
  </table>
   <br><br>
</body>
</html>

