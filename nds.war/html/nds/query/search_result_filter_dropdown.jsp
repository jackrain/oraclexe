<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!  /**
     * Encode sql to html valid string, will be put into <input> tag
     */
    private String encode(String sql){
        String s=  nds.util.StringUtils.replace(sql,"\"", "\\\"");
        return s;
    }
%>
<%
	/**
		return to filter object input box 	
	*/

QueryRequest query =(QueryRequest) request.getAttribute("query");
Expression paremExpr= query.getParamExpression();
String paramExpStr=(paremExpr==null?"":paremExpr.toHTMLInputElement());
String desc=query.getParamDesc(false);
nds.schema.Filter fo=new nds.schema.Filter();
fo.setDescription(desc);
fo.setSql("IN ("+ encode(query.toPKIDSQL(false))+")");
fo.setExpression(paramExpStr);
System.out.println(fo.toXML());
%> 
oq.returnFilterObj_dropdown("<%=encode(desc)%>", "<%=fo.toXML()%>");
