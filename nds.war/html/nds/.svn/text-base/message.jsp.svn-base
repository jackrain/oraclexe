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
		header_message +="<img border=0 src='"+NDS_PATH+"/images/ok.gif' TITLE='["+Thread.currentThread().getName()+"]'><b><font >"+((java.text.SimpleDateFormat)QueryUtils.smallTimeFormatter.get()).format(new java.util.Date())+"&nbsp;"+PortletUtils.getMessage(pageContext, "information",null)+":</font></b>"+mh.translateMessage((String)holder.get("message"),locale);
	}else{
		// some pages are directed by HttpServletResponse, not forwarded by RequestDispather,
		// so the FlowProcessor would append message from server-side to HttpServletRequest's parameter list
		// named as nds.util.WebKeys.MESSAGE defines, so we should try to get message from there
		// @see nds.control.web.FlowProcessor
		String holder_message= request.getParameter(nds.util.WebKeys.VALUE_HOLDER_MESSAGE);
		if( holder_message !=null){
			header_message +="<img border=0 src='"+NDS_PATH+"/images/ok.gif' TITLE='["+Thread.currentThread().getName()+"]'><b><font > "+((java.text.SimpleDateFormat)QueryUtils.smallTimeFormatter.get()).format(new java.util.Date())+"&nbsp;"+PortletUtils.getMessage(pageContext, "information",null)+": </font></b>"+holder_message;	
		}
	}
if( Validator.isNotNull(header_message)){	
%>
<div id="message" class="nt">
<%=header_message%>
</div>

<%
}
%>
