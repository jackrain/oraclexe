<%@ include file="/html/nds/help/init.jsp" %>
<%
  /**
  * @param table - table name
  * @param mask - "query","add", "modify" , defautl to 'query'
  */
  TableManager manager=TableManager.getInstance();
  String tableName= request.getParameter("table");
  String mask=request.getParameter("mask");
  if(Validator.isNull(mask)) mask="query";
  int action=Table.QUERY;
  if("query".equalsIgnoreCase(mask)) action=Table.QUERY;
  else if("add".equalsIgnoreCase(mask)) action=Table.ADD;
  else if("modify".equalsIgnoreCase(mask)) action=Table.MODIFY;
  else{
  	out.print("error mask param:"+ mask);
  	return;
  }
  Table table= manager.getTable(tableName);
  if(table ==null){
  	out.print("table not found.");
  	return;
  }  
%>
<span class='tablehead'><%= PortletUtils.getMessage(pageContext, "key-columns",null)%></span>
<%  
  ArrayList cols= table.getAllColumns();
  for(Iterator it= cols.iterator();it.hasNext();){
  	Column col= (Column)it.next();
  	if (col.getDisplaySetting().isUIController()) continue;
  	String comments=  QueryUtils.getComments(col);
  	if( Validator.isNull(comments)) continue;
%>
<p><a href="#" class="DropDown" onclick="Outline2()"><img border=0 src="<%=WIKI_HELP_PATH%>/images/blueup.gif" ><%=col.getDescription(locale)%></b></a></p>
<DIV id="ExpCol"  class="collapsed" border="0" >
<%=comments%>
<%
	if(col.isValueLimited() && col.getDisplaySetting().getObjectType()!=DisplaySetting.OBJ_CHECK){
%>
	 <br><ol>
<%		PairTable pt=QueryUtils.getLimitValueComments(col);
		List l=pt.keyList();
		for(int i=0;i<l.size();i++){
			String k=(String)l.get(i);
			String v=(String)pt.get(k);
%>
			<li><%=k%> &nbsp;&nbsp;--&nbsp;&nbsp; <%=(v==null?"":v)%></li>
<%			
		}
%>	
	</ol>
<%
	}
%>
</DIV>
<%  	
  }
%>

