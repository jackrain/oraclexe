<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>

<%
  /**
  *  do bsh script
     parameter:
         "bsh.script" -String 
         bsh.servlet.captureOutErr - default to false
         "id" - ad_script object id
  *  attributes:
         bsh.out  - String  output 
         bsh.result  - String  return result
         bsh.exception - String  
  */
  
  //check permission
  userWeb.checkPermission("SHELL",nds.security.Directory.WRITE);
  
  Properties props=EJBUtils.getApplicationConfig().getConfigurations("schema").getProperties();
  if(! "true".equalsIgnoreCase(props.getProperty("modify","true"))){
	throw new NDSException("@no-permission@");
  }
  
  String script=request.getParameter("bsh.script");
  boolean captureOutErr=Tools.getBoolean(request.getParameter("bsh.servlet.captureOutErr"), false);
  String scriptOut= (String) request.getAttribute("bsh.out");
  String scriptError= (String)request.getAttribute("bsh.exception");
  String scriptResult= (String) request.getAttribute("bsh.result");
  int adScriptId= ParamUtils.getIntParameter(request, "id", -1);
  if(adScriptId!=-1){
     script=QueryEngine.getInstance().doQueryOne("select content from ad_script where id="+adScriptId).toString();
  }
  String btype=request.getParameter("bsh.type");
  boolean isPython=("python".equals(btype));
%>
<script>
	document.title="<%=PortletUtils.getMessage(pageContext, "shell",null)%>";
function selectScript(){
 window.location="<%=NDS_PATH%>/shell/scripts.jsp";
}	
</script>
<div id="obj-content">
<br>	

<form method="POST" action="/servlets/eval">
<b><%=PortletUtils.getMessage(pageContext, "script",null)%></b>
<select name="bsh.type"><option value="beanshell" <%=isPython?"":"selected"%>>BeanShell</option>
<option value="python" <%=isPython?"selected":""%>>Python</option></select><br>
<TEXTAREA name="bsh.script" rows="30" cols="120">
<%=(script==null?"":script)%>
</TEXTAREA>
<p><!--
<%=PortletUtils.getMessage(pageContext, "shell-capture-out",null)%>:
<INPUT type="checkbox"  name="bsh.servlet.captureOutErr" value="true" <%=(captureOutErr?"checked":"")%>>
<%=PortletUtils.getMessage(pageContext, "display-raw-output",null)%>:
<INPUT type="checkbox" name="bsh.servlet.output" value="raw">
<p>-->
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="submit" value="<%=PortletUtils.getMessage(pageContext, "shell-run",null)%>">
<INPUT type="button" value="<%=PortletUtils.getMessage(pageContext, "select-script",null)%>" onclick="selectScript();">
</form>

<%
if(nds.util.Validator.isNotNull(scriptOut)){
%>
<b><%=PortletUtils.getMessage(pageContext, "shell-output",null)%></b>
<table width="80%" border="1" cellpadding="6"><tr><td bgcolor="#eeeeee">
<pre>
<%=scriptOut%>
</pre>
</td></tr></table>
<%}%>

<%
if(nds.util.Validator.isNotNull(scriptError)){
%>
<b><%=PortletUtils.getMessage(pageContext, "shell-exception",null)%></b>
<table width="80%" border="1" cellpadding="6"><tr><td bgcolor="#eeeeee">
<%=scriptError%>
</td></tr></table>
<%}%>

<%
if(nds.util.Validator.isNotNull(scriptResult)){
%>
<b><%=PortletUtils.getMessage(pageContext, "shell-result",null)%></b>
<table width="80%" border="1" cellpadding="6"><tr><td bgcolor="#eeeeee">
<%=scriptResult%>
</td></tr></table>
<%}%>

</div>
<%@ include file="/html/nds/footer_info.jsp" %>
