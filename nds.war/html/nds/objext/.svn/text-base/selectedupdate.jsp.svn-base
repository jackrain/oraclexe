<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	/**
	* update object with id listed in objectids. will convert to QueryRequest Object and forward to batchupdate.jsp
	   param 
	    objectids - in format like 'id1,id2,id3'
	    table - the table to be operated on
	*/
	TableManager manager= TableManager.getInstance();
	int tableId= Tools.getInt(request.getParameter("table"),-1);
	Table table= manager.getTable(tableId);
	String objectIds= request.getParameter("objectids");
	
	Expression filter=null;
	if( Validator.isNull(objectIds)){
		throw new NDSException( PortletUtils.getMessage(pageContext, "please-check-selected-lines",null));
	}else{
		filter= new Expression(new ColumnLink(new int[]{table.getPrimaryKey().getId()}),  " IN (" +objectIds+")", null);
	}
	QueryRequestImpl query= QueryEngine.getInstance().createRequest(userWeb.getSession());
	query.setMainTable(tableId,true);
	query.addSelection(table.getPrimaryKey().getId());
	query.addParam(filter);
	request.setAttribute("query", query);
	request.getRequestDispatcher("/html/nds/objext/batchupdate.jsp").forward(request, response);	
%>
