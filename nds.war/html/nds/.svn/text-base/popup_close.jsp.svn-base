<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="nds.control.web.*,nds.util.*,java.util.*,java.net.*,java.io.*"%>
<html>
<head>
	<title>popup</title>
</head>

<body  bgcolor="#ffffff" text="#000000" link="#0000ff" vlink="#800080" alink="#ff0000">

<p>

<%	Throwable exec= (Throwable)request.getAttribute("error");
	if( exec ==null ){
%>
	<script>
    if(typeof(window.opener.name)!='unknown'){
        window.opener.document.location.reload();
		window.close();
    }else{
    	self.close();
    }
	</script>

<%
	}else{
		request.getRequestDispatcher("/error.jsp").forward(request, response);
	}
%>

</body></html>
