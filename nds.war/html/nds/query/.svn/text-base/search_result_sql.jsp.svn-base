<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!    /**
     * Encode sql to html valid string, will be put into <input> tag
     */
    private String encode(String sql){
        String s=  nds.util.StringUtils.replace(sql,"\"", "\\\"");
//        s= nds.util.StringUtils.escapeHTMLTags(s);
        return s;
    }
%>
<%
	/**
		Only return script for query object, and call ObjectQuery.returnQuery method	 	
	*/

QueryRequest query =(QueryRequest) request.getAttribute("query");
Expression paremExpr= query.getParamExpression();
String paramExpStr=(paremExpr==null?"":paremExpr.toHTMLInputElement());
%> 
oq.returnQuery(" IN ( <%=encode( query.toPKIDSQL(false))%> )", "<%=encode(query.getParamDesc(false))%>", "<%=paramExpStr%>");

