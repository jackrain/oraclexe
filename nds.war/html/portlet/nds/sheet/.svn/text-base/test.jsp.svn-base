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

    <td colspan=2>
    
      <form name="sheet_title_form" method="post" action="/nds/control/command" onSubmit="return checkOptions(document.sheet_title_form);">
        <input type='hidden' name="input" value="true">
        <input type='hidden' name='directory' value='OUTLETDAYSALESHT_LIST'>
        
        
        <input type='hidden' name='formRequest' value='/sheet/sheet_title.jsp?action=input&table=10101&id=129192'>
        
        <table border="0" width="98%" align="center" >
          <tr>
            <td width="3%">&nbsp; </td>
            <td width="97%" align="center" valign="bottom">
              <div align="right"><br>
              </div>
            </td>
          </tr>
        </table>
        

        
        






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
          
<input class="command2_button" type='button' name='OutletDaySaleShtModify' value='保&nbsp;&nbsp;&nbsp;&nbsp;存' onclick="javascript:doCommand(sheet_title_form, 'OutletDaySaleShtModify')" >


        
<input class="command2_button" type='button' name='OutletDaySaleShtDelete' value='删&nbsp;&nbsp;&nbsp;&nbsp;除' onclick="javascript:doCommand(sheet_title_form, 'OutletDaySaleShtDelete')" >


        
<input class="command2_button" type='button' name='OutletDaySaleShtSubmit' value='提&nbsp;&nbsp;&nbsp;&nbsp;交' onclick="javascript:doCommand(sheet_title_form, 'OutletDaySaleShtSubmit')" >


        
<input class="command_button" type='button' name='Print' value='打&nbsp;&nbsp;&nbsp;&nbsp;印' onclick="javascript:printHidden('/nds/print/sheet_title.jsp?table=10101&id=129192');" >
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

        <table width="98%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#999999" align="center">
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

    <input type="hidden" name="table" value="10101">
    <tr>

    <td height="18" width="16%" nowrap align="left">编号<font color='red'>*</font>::</td>
    <td height="18" width="33%" nowrap align="left">
      RXA0312020007
    </td>



    <td height="18" width="16%" nowrap align="left">客户编号<font color='red'>*</font>::</td>
    <td height="18" width="33%" nowrap align="left">
      
                
                <input type="text" name="customer_no" tabIndex="1" maxlength="20" size="20" id="column_1290" value="CSA037" /><font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串,最长位数:20'></font>
				<a href='#' onclick=pop_up("/nds/servlets/query?table=10032&return_type=s&accepter_id=sheet_title_form.column_1290","T1095304150362")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                                    
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">客户名称::</td>
    <td height="18" width="33%" nowrap align="left">
      上海新华联
    </td>



    <td height="18" width="16%" nowrap align="left">日销时间<font color='red'>*</font>::</td>
    <td height="18" width="33%" nowrap align="left">
      
                
                <input type="text" name="daysaledate" tabIndex="2" maxlength="40" size="20" id="column_1292" value="2003/11/30" /><font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/date.gif' width=16 height=18 align=absmiddle alt='格式：yyyy/mm/dd ' ></font>
				
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">店长::</td>
    <td height="18" width="33%" nowrap align="left">
      
                
                <input type="text" name="shopleadername" tabIndex="3" maxlength="20" size="20" id="column_1293" value="D3563113000" /><font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串,最长位数:20'></font>
				
    </td>



    <td height="18" width="16%" nowrap align="left">制单人工号::</td>
    <td height="18" width="33%" nowrap align="left">
      <a href='/nds/servlets/viewObject?ifm=false&table=10061&id=110131'>D106</a>
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">核对人工号::</td>
    <td height="18" width="33%" nowrap align="left">
      
                
                <input type="text" name="checker_no" tabIndex="4" maxlength="20" size="20" id="column_1298" value="" /><font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串,最长位数:20'></font>
				<a href='#' onclick=pop_up("/nds/servlets/query?table=10061&return_type=s&accepter_id=sheet_title_form.column_1298","T1095304150362")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                                    
    </td>



    <td height="18" width="16%" nowrap align="left">审核人工号::</td>
    <td height="18" width="33%" nowrap align="left">
      
                
                <input type="text" name="auditor_no" tabIndex="5" maxlength="20" size="20" id="column_1299" value="" /><font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串,最长位数:20'></font>
				<a href='#' onclick=pop_up("/nds/servlets/query?table=10061&return_type=s&accepter_id=sheet_title_form.column_1299","T1095304150362")><img border=0 width=16 height=16 align=absmiddle src='<%=contextPath%>/html/portlet/nds/sheet/images/find.gif' alt='点击打开新页面查找本项内容'></a>
                                    
    </td>

</tr><tr>

    <td height="18" width="16%" nowrap align="left">审核意见::</td>
    <td height="18" width="33%" nowrap align="left">
      
                
                <input type="text" name="auditnote" tabIndex="6" maxlength="40" size="20" id="column_1300" value="" /><font size=2><img src='<%=contextPath%>/html/portlet/nds/sheet/images/char.gif' width=16 height=18 align=absmiddle alt='格式：任意字符串,最长位数:40'></font>
				
    </td>


    
</table>

               <br>

            </td>
          </tr>
        </table>
        &nbsp;&nbsp;&nbsp;<a  href='/nds/sheet/sheet_item.jsp?input=true&sheet=10101&objectid=129192' ><img src='<%=contextPath%>/html/portlet/nds/sheet/images/createrows.gif' width='18' height='13' border='0'>进入单据条目列表</a>&nbsp;→

          <br>


        </form>

      </td>
    </tr>
 </table>

</body>
</html>

