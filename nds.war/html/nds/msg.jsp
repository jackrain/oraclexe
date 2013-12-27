<%@ page isErrorPage="true" %>
<%@ include file="/html/nds/common/init.jsp" %>
<%
MessagesHolder mh = MessagesHolder.getInstance();
String msg=null;
response.setHeader("nds.code", "412"); // SC_PRECONDITION_FAILED 
Throwable exec= (Throwable)request.getAttribute("error");
if( exec !=null)	request.removeAttribute("error");
ByteArrayOutputStream outs=null;
if( exception ==null){
    if(exec !=null) exception =exec;
}
if(exception!=null)
	msg =mh.translateMessage( (exception instanceof NDSException)?((NDSException)exception).getSimpleMessage():
                     exception.getMessage(),locale);
%>	
<%=(msg==null?mh.translateMessage("@exception@",locale):msg)%>