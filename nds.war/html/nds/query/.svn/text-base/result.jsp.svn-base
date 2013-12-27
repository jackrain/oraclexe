<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
  /**
  * yfzhu 2005-05-12 remark DO NOT ADD  errorPage IN THIS PAGE!
  */
%> 
<%
    QueryRequestImpl query= (QueryRequestImpl)request.getAttribute("query");
    Expression userExpr= (Expression)request.getAttribute("userExpr");
    Expression expr= query.getParamExpression();
    // add security filter here

    //
	QueryResult result= (QueryResult) QueryEngine.getInstance().doQuery(query);
        String title="";
        if( result !=null){
		    title += result.getQueryRequest().getMainTable().getDescription(locale);
        }
     String titleName=PortletUtils.getMessage(pageContext, "query-result",null)+" - "+ query.getMainTable().getDescription(locale);
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=titleName%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>

<style>
a {  color: #0000CC; text-decoration: none}
A:visited{TEXT-DECORATION: none£»color: #FF0000}
A:hover{color: #FF6600; TEXT-DECORATION: underline}
a:active {  color: #FF0000}
</style>
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="<%=colorScheme.getPortletTitleBg()%>" width="100%">
        <tr>
          <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#cccccc">
        <tr>
          <td>
          <br>

<jsp:include page="inc_result.jsp" flush="true" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<script>
try{document.attachEvent( "oncontextmenu", showContextMenu );
document.attachEvent( "onkeyup", rememberKeyCode );}catch(ex){}
</script>
<%@ include file="/html/nds/footer_info.jsp" %>
