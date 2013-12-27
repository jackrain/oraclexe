<%
/**
* Included by page with validCommands(Array) set
* validCommands elements are String or nds.web.bean.Button
* if String , it should be the button name in ButtonFactory
* predefined buttons are: Create/Modify/Delete/Submit and 
*  BatchCreate/BatchModify/BatchImport/BatchSubmit
*/
%>
<table width="98%" border="0" cellspacing="6" cellpadding="0" align="center" >
 <tr><td width="100%" align="left" >
<input type='hidden' name="command" value='null'>
<div class="buttons">
<%
ButtonFactory commandFactory= ButtonFactory.getInstance(pageContext,locale);
Button btn;
for(int i=0;i< validCommands.size();i++){
	btn=null;
	Object cmd= validCommands.get(i);
	if(cmd instanceof String){
		btn=commandFactory.getButton((String)cmd);
	}else if(cmd instanceof Button){
		btn=(Button)cmd;
	}
	if(btn==null) throw new Error("Internal error: command not found:"+ cmd);
%>
	<%=btn.toHREFbyimg("table-buttons2")%>
<%	
}
%>
<%@ include file="/html/nds/common/helpbtn.jsp"%>
<span id="closebtn"></span>
</div>
<Script language="javascript">
if( window.self==window.top){
	/*$("closebtn").innerHTML="<input class='command_button' type='button' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>(C)' accessKey='C' onclick='window.close();' name='Close'>";*/
					$("closebtn").innerHTML="<a id='btn_help' name='Close' href='javascript:window.close();'>"+
				"<img src=\"/html/nds/images/close.png\"/>"+gMessageHolder.CLOSE_DIALOG+"</a>";
}else{
			$("closebtn").innerHTML="<a id='btn_help' name='Close' href='javascript:art.dialog.close();'>"+
				"<img src=\"/html/nds/images/close.png\"/>"+gMessageHolder.CLOSE_DIALOG+"</a>";
	}
</script>
</td></tr>
</table>
<script language="JavaScript" src="<%=NDS_PATH%>/js/xp_progress.js"></script>
<DIV id=ProgressWnd style="position: absolute; left:290px; top:5px;z-index: 100;display:block;">
<script>
	var progressBar = createBar(200, 20, "#FFFFFF", 1, "#000000", "<%=colorScheme.getPortletTitleBg()%>", 150, 10, 3, "");
	progressBar.togglePause();
	progressBar.hideBar();
</script>
</div>

