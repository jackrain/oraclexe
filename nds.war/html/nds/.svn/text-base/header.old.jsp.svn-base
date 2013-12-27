<%@ include file="/html/nds/common/init.jsp" %>
<%!     
private final static java.text.DateFormat timeFormatter =new java.text.SimpleDateFormat("HH:mm:ss");
%>

<html>
<head>
	<title><%= request.getParameter("html_title") %></title>

<%@ include file="/html/common/init.jsp" %>
<%@ include file="/html/common/themes/top_meta.jsp" %>
<%@ include file="/html/common/themes/top_meta-ext.jsp" %>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico" />
<link type="text/css" rel="stylesheet" href="/html/nds/css/nds_header.css">
<link type="text/css" rel="stylesheet" href="/html/nds/css/portal.css">
<link type="text/css" rel="StyleSheet" href="/html/nds/css/cb2.css">
<link type="text/css" rel="StyleSheet" href="/html/nds/css/nds_portal.css" />
<link type="text/css" rel="StyleSheet" href="<%= NDS_PATH%>/css/custom-ext.css" />
<script language="JavaScript" src="/html/nds/js/top_css_ext.js"></script>
<script type="text/javascript" language="JavaScript1.5" src="/html/nds/js/ieemu.js"></script>
<script language="JavaScript" src="/html/nds/js/cb2.js"></script>
<script language="JavaScript" src="/html/js/sniffer.js"></script>

<%if(BrowserSniffer.is_mozilla(request)){%>
	<script language="JavaScript" src="<%= contextPath%>/html/nds/js/xmenu.js"></script>
	<script language="JavaScript" src="<%= contextPath%>/html/nds/js/cssexpr.js"></script>
	<link type="text/css" rel="stylesheet" href="<%= contextPath%>/html/nds/css/xmenu.css"  />
	<link type="text/css" rel="stylesheet" href="<%= contextPath%>/html/nds/css/xmenu.windows.css" />
<%}else{%>	
	<link type="text/css" rel="StyleSheet" href="<%=contextPath%>/html/nds/js/menu4/skins/officexp/officexp.css" />
	<script language="JavaScript" src="<%= contextPath%>/html/nds/js/menu4/poslib.js"></script>
	<script language="JavaScript" src="<%= contextPath%>/html/nds/js/menu4/scrollbutton.js"></script>
	<script language="JavaScript" src="<%= contextPath%>/html/nds/js/menu4/menu4.js"></script>
	<%if ( ParamUtil.get(request, "enable_context_menu", false)==false){%>
	<script language="JavaScript" src="<%= contextPath%>/html/nds/js/initctxmenu_<%=locale.toString()%>.js"></script>
	<%}else{%>
	<script>
	 //disable context menu control in top_css_ext.js 
	  document.detachEvent( "oncontextmenu",noContextMenu );
	</script>
	<%}
}%>
	<script language="JavaScript" src="<%= contextPath %>/html/nds/js/common.js"></script>
	<script language="JavaScript" src="<%= contextPath %>/html/nds/js/print.js"></script>
	<script language="JavaScript" src="/html/nds/js/prototype.js"></script>
	<script language="JavaScript" src="/html/js/ajax.js"></script>
	<script language="JavaScript" src="/html/js/util.js"></script>
</head>

<%
//String bodyBackground =colorScheme.getPortletBg();//colorScheme.getPortletBg() ;// GetterUtil.get(request.getParameter("body_background"), colorScheme.getPortletBg());
String bodyBackground = GetterUtil.get(request.getParameter("body_background"), colorScheme.getPortletBg());
String bodyMargins = request.getParameter("body_margins");
String bodyPadding = request.getParameter("body_padding");
String bodyAttributeText=request.getParameter("body_attributes");
if(bodyAttributeText==null) bodyAttributeText="";
%>

<c:if test="<%= bodyMargins == null %>">
	<body class="body_class" bgcolor="<%= bodyBackground %>"  bottommargin="0" topmargin="0" <%=bodyAttributeText%>>
</c:if>

<c:if test="<%= bodyMargins != null %>">
	<body class="body_class" bgcolor="<%= bodyBackground %>" leftmargin="<%= bodyMargins %>" marginheight="<%= bodyMargins %>" marginwidth="<%= bodyMargins %>" rightmargin="<%= bodyMargins %>" topmargin="<%= bodyMargins %>" <%=bodyAttributeText%>>
</c:if>

<c:if test="<%= bodyPadding != null %>">
	<table bgcolor="<%= colorScheme.getPortletBg() %>" border="0" cellpadding="<%= bodyPadding %>" cellspacing="0">
	<tr>
		<td>
</c:if>

<c:if test="<%= ParamUtil.get(request, "show_top", true) %>">
	<%@ include file="/html/nds/top_bar.jsp" %>
</c:if>

<%
MessagesHolder mh = MessagesHolder.getInstance();
String header_message="";

Object exec= request.getAttribute("error");
if(exec !=null && (exec instanceof Throwable))
{
	request.removeAttribute("error");
	if (nds.control.web.WebUtils.isSystemDebugMode()){
  		header_message ="<script language=\"javascript\">function popup_errmsg() {"
             +"errorWindow = window.open('','_blank','resizable=yes,scrollbars=yes,menubar=no,toolbar=no,width=720,height=200');errorWindow.focus();"
             +"errorWindow.document.writeln('<html><head><title>"+PortletUtils.getMessage(pageContext, "error",null)+"</title></head><body><pre>"
             +WebUtils.stringForJsOutput(Tools.getExceptionStackTrace((Throwable)exec)+"\\n\\n\\n"+nds.util.Tools.toString(request))+"</pre><body></html>');}</script>";
		if(exec instanceof NDSException){
      		header_message +=("<a href=\"javascript:popup_errmsg()\"><img height=16 width=16 border=0 src="+NDS_PATH+"/images/error.gif><font color=red>"+PortletUtils.getMessage(pageContext, "exception",null)+": " + mh.translateMessage(((NDSException)exec).getSimpleMessage(),locale) + "</font></a>");
  		}else{
      		header_message +=("<a href=\"javascript:popup_errmsg()\"><img height=16 width=16 border=0 src="+NDS_PATH+"/images/error.gif><font color=red>"+PortletUtils.getMessage(pageContext, "exception",null)+": " + mh.translateMessage(((Throwable)exec).getMessage(),locale)+ "</font></a>");
  		}
	}else{
		if(exec instanceof NDSException){
      		header_message +=("<a href=\"#\"><img height=16 width=16 border=0 src="+NDS_PATH+"/images/error.gif><font color=red>"+PortletUtils.getMessage(pageContext, "exception",null)+": " + mh.translateMessage(((NDSException)exec).getSimpleMessage(),locale) + "</font></a>");
  		}else{
      		header_message +=("<a href=\"#\"><img height=16 width=16 border=0 src="+NDS_PATH+"/images/error.gif><font color=red>"+PortletUtils.getMessage(pageContext, "exception",null)+": " + mh.translateMessage(((Throwable)exec).getMessage(),locale)+ "</font></a>");
  		}
	}
}
ValueHolder holder= (ValueHolder)request.getAttribute(nds.util.WebKeys.VALUE_HOLDER);
 	if( holder !=null)	{
		header_message +="<img height=13 width=13 border=0 src='"+NDS_PATH+"/images/isok.gif' TITLE='["+Thread.currentThread().getName()+"]'><b><font color='#cccccc'>"+timeFormatter.format(new java.util.Date())+"&nbsp;"+PortletUtils.getMessage(pageContext, "information",null)+":</font></b>"+mh.translateMessage((String)holder.get("message"),locale);
	}else{
		// some pages are directed by HttpServletResponse, not forwarded by RequestDispather,
		// so the FlowProcessor would append message from server-side to HttpServletRequest's parameter list
		// named as nds.util.WebKeys.MESSAGE defines, so we should try to get message from there
		// @see nds.control.web.FlowProcessor
		String holder_message= request.getParameter(nds.util.WebKeys.VALUE_HOLDER_MESSAGE);
		if( holder_message !=null){
			header_message +="<img height=13 width=13 border=0 src='"+NDS_PATH+"/images/isok.gif' TITLE='["+Thread.currentThread().getName()+"]'><b><font color='#cccccc'> "+timeFormatter.format(new java.util.Date())+"&nbsp;"+PortletUtils.getMessage(pageContext, "information",null)+": </font></b>"+holder_message;	
		}
	}
if( Validator.isNotNull(header_message)){	
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"> <td height="16"> 
<%=header_message%>
</td></tr>
</table>  
<%
}
%>

<table height="100%" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
