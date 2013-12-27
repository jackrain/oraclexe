<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<style>
.sp{
 cursor:hand;
}
</style>
<script type="text/javascript" language="javascript">
document.title="Closing...";
function checkOption(){
  if(exitForm.r_exit.checked){
  	window.location="/c/portal/logout?referer=/html/nds/common/close.htm";
  }else if(exitForm.r_logout.checked){
  	open("/c/portal/logout?referer=/index.html","_blank");
  }else if(exitForm.r_return.checked){
  	open("/index.html","_blank");
  }
  self.close();
  return false;
}
</script>
<table border=0><form name="exitForm">
<tr><td>
<b><%=PortletUtils.getMessage(pageContext, "exit-message",null)%></b>
<hr width="90%">
</td></tr>
<tr><td  class="sp" onclick="exitForm.r_exit.checked=true;"><input type='radio' id="r_exit" name='selectedItemIdx' value='exit' checked><%=PortletUtils.getMessage(pageContext, "exit-option-exit",null)%></td></tr>
<tr><td  class="sp" onclick="exitForm.r_logout.checked=true;"><input type='radio' id="r_logout" name='selectedItemIdx' value='logout'><%=PortletUtils.getMessage(pageContext, "exit-option-logon",null)%></td></tr>
<tr><td  class="sp" onclick="exitForm.r_return.checked=true;"><input type='radio' id="r_return" name='selectedItemIdx' value='return'><%=PortletUtils.getMessage(pageContext, "exit-option-return",null)%></td></tr>
<tr><td  class="sp" onclick="exitForm.r_close.checked=true;"><input type='radio' id="r_close" name='selectedItemIdx' value='close'><%=PortletUtils.getMessage(pageContext, "exit-option-close-window",null)%></td></tr>
<tr><td align="right"><br><input type='button' value="<%=PortletUtils.getMessage(pageContext, "execute-command",null)%>" onclick="javascript:checkOption()"></td></tr>
</form>
</table>
<%@ include file="/html/nds/footer_info.jsp" %>
