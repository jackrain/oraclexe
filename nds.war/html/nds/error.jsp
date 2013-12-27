<%@ page isErrorPage="true" %>
<%@ include file="/html/nds/common/init.jsp" %>
<%
MessagesHolder mh = MessagesHolder.getInstance();
try{
	String msg=null;
	response.setHeader("nds.code", "412"); // SC_PRECONDITION_FAILED 
	Throwable exec= (Throwable)request.getAttribute("error");
	if( exec !=null)	request.removeAttribute("error");
	ByteArrayOutputStream outs=null;
    if( exception ==null){
        if(exec !=null) exception =exec;
    }
	if( exception !=null){
		
		msg =mh.translateMessage( (exception instanceof NDSException)?((NDSException)exception).getSimpleMessage():
                         exception.getMessage(),locale);
		response.setHeader("nds.exception",java.net.URLEncoder.encode(msg==null?mh.translateMessage("@exception@",locale):msg, "UTF-8"));
		if(userWeb.getUserId()==UserWebImpl.GUEST_ID){
			response.setHeader("nds.code", "1");
		}
	}
%>
<html>
<head>
	<title><%= PortletUtils.getMessage(pageContext, "exception",null)%></title>

<%@ include file="/html/common/init.jsp" %>
<%@ include file="/html/common/themes/top_meta.jsp" %>
<%@ include file="/html/common/themes/top_meta-ext.jsp" %>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico" />
	<script language="JavaScript" src="<%= contextPath %>/html/nds/js/common.js"></script>
	<script language="JavaScript" src="<%= contextPath %>/html/nds/js/print.js"></script>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/object.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal_header.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/nds_portal.css">
</head>

<%
String bodyBackground =colorScheme.getPortletBg();//colorScheme.getPortletBg() ;// GetterUtil.get(request.getParameter("body_background"), colorScheme.getPortletBg());
String bodyMargins = request.getParameter("body_margins");
String bodyPadding = request.getParameter("body_padding");
%>

<c:if test="<%= bodyMargins == null %>">
	<body class="body_class" bgcolor="<%= bodyBackground %>">
</c:if>

<c:if test="<%= bodyMargins != null %>">
	<body class="body_class" bgcolor="<%= bodyBackground %>" leftmargin="<%= bodyMargins %>" marginheight="<%= bodyMargins %>" marginwidth="<%= bodyMargins %>" rightmargin="<%= bodyMargins %>" topmargin="<%= bodyMargins %>">
</c:if>
<liferay-util:include page="/html/common/themes/top_messages.jsp" />
	
<c:if test="<%= bodyPadding != null %>">
	<table bgcolor="<%= colorScheme.getPortletBg() %>" border="0" cellpadding="<%= bodyPadding %>" cellspacing="0">
	<tr>
		<td>
</c:if>
<script language="javascript">
function errMsg(){
    var obj = null, req = null;
    obj = document.getElementById('errorMsg').style;
    if(obj.display == 'none')
        obj.display = 'block';
    else
        obj.display = 'none';
    
}
</script>
<table cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#cccccc" width="100%">
<tr  class="TitleStyleClass"   style="background-color: #eeeeee; color: #000000;"  >
    <td align="left" true valign="middle" width="100%">
      <%= PortletUtils.getMessage(pageContext, "exception",null)%>
    </td>
</tr>
<tr><td>
<p>
<%	
if( exception !=null ){
   
	out.println("<img src="+NDS_PATH+"/images/error.gif border=\"0\">"+msg);
	if(nds.control.web.WebUtils.isSystemDebugMode()){	
%>
<hr><b><a href="#" onClick="javascript:errMsg();return(false)"><%= PortletUtils.getMessage(pageContext, "debug-info",null)%></a></b>
<DIV id="errorMsg" class="exec" style="display:none;">
<pre>
<%
      Throwable e = exception;
      while (e != null) {
        e.printStackTrace(new PrintWriter(out));
        Throwable prev = e;
        e = e.getCause();
        if (e == prev)
          break;
      }
%>
</pre>
	<div id="reqMsg" class="exec">
		<hr>
        <p><pre>
        <%try{out.print(nds.util.Tools.toString(request));}
        	catch(Throwable t){}
        %>
        </pre></p>
	</div>        
</DIV>

<%
	} // end if debug mode
}//end if( exception !=null )
%>
</td></tr></table>
</body>
</html>
<%
}catch(Throwable ere){
	System.err.println("Found error for request:");
	try{
		System.err.println(nds.util.Tools.toString(request));
	}catch(Throwable ere2){}
	ere.printStackTrace();
}

%>
