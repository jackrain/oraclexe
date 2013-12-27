<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
 /**
	 List table and homepage of specified cagtegory
	 	1. id -- ad_tablecategory.id
 */
int categoryId= ParamUtils.getIntParameter(request,"id", -1);
TableManager manager=TableManager.getInstance();
TableCategory category= manager.getTableCategory(categoryId);

if(Validator.isNotNull(category.getPageURL())){
%>
	<jsp:include page="<%=category.getPageURL()%>"/>
<%
}else{
%>
	<b><%=category.getDescription(locale)%></b>
<%}
%>


