<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	String tabName= PortletUtils.getMessage(pageContext, "relate_table",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Things needed in this page:
     *  table - int the table id which to be filtered
     *  hier  - int 0 for none, 1 for directly related table, 99 for all
     */
    

%>

<%
    int tableId= ParamUtils.getIntParameter(request, "table", -1);
    int inputHier= ParamUtils.getIntParameter(request, "hier", -1);

    TableManager tm=TableManager.getInstance();
    Hashtable htColumns=new Hashtable();

    Table table = tm.getTable(tableId);
    ArrayList cols= tm.getReferedColumns( table.getId(), inputHier,htColumns);
    LinkArrayConverter conv=new LinkArrayConverter(htColumns);
    ArrayList ret;
    if (inputHier !=0){
    	ret=conv.convertToTable(cols);
    }else{
    	ret=new ArrayList();
    }
    
	
	
%>

<script>
	function view_list(tableId){
		popup_window('../query/query.jsp?table='+tableId);
	}
</script>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="90%">
  <tr>
    <td rowspan=2>&nbsp;</td>
          <td>

          </td>
          <td rowspan=2>&nbsp;</td>
        </tr>
        <tr>
          <td colspan=3>
		<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
		         <tr >
        		  	<td align='center' ><%=PortletUtils.getMessage(pageContext, "current-relate-level",null)%>:<%=inputHier%></td>
          		 </tr>

          <tr >
          	
            <td> <table border="0" cellspacing="0" cellpadding="0" align="center" width="90%" bordercolordark="#CCCCCC" bordercolorlight="#FFFFFF" >
            	<%
            		if(ret.size()==0){
                      out.println("<tr><td align='center'><font color='red'> <b>"+PortletUtils.getMessage(pageContext, "no-relate-tables",null)+"</b></font></td></tr>");
            		}else
            		for(int i=0;i< ret.size();i++){
            			ArrayList row=(ArrayList) ret.get(i);
            			out.print("<tr>");
            			for(int j=0;j< row.size();j++){
            				Column col= (Column) row.get(j);
            				if( col==null) out.print("<td>&nbsp;</td>");
            				else
            					out.print("<td nowrap><a href='javascript:view_list("+ col.getTable().getId()+")'>"+ col.getTable().getDescription(locale)+"["+ col.getDescription(locale)+ "]</a></td>");
            			}
            			
            			out.println("</tr>");
            		}           	
            	%>
            
            </table>
 </td></tr></table>
 <br>
 </td></tr></table>
		
    </div>
</div>		
<%@ include file="/html/nds/footer_info.jsp" %>
