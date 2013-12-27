<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%

	String tabName=PortletUtils.getMessage(pageContext, "object.batchupdate",null);
	
	String object_page_url=NDS_PATH+"/objext/batchupdate.jsp";
	request.setAttribute("page_help", "BatchUpdate");
	int navTabTotalWidth=DEFAULT_TAB_WIDTH; //total table width
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=PortletUtils.getMessage(pageContext, "object.batchupdate",null)%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="table_width" value="<%=String.valueOf(navTabTotalWidth)%>" />
</liferay-util:include>

<div id="tabs">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Template modification page
     * Things needed in this page (attributes) :
     *  1.  query     QueryRequest that contains filter
     */
TableManager manager=TableManager.getInstance();

QueryRequestImpl query =(QueryRequestImpl) request.getAttribute("query");
//int queryCount=Tools.getInt(QueryEngine.getInstance().doQueryOne(query.toCountSQL()), -1);
Table table=query.getMainTable();
int tableId=table.getId();
PairTable fixedColumns=(PairTable) request.getAttribute("fixedcolumns");
if(fixedColumns==null) fixedColumns=new PairTable();
/**------check permission---**/
// for status
String directory;
directory=table.getSecurityDirectory();

int perm= WebUtils.getDirectoryPermission(directory, request);
if(perm==0) throw new NDSException(PortletUtils.getMessage(pageContext, "no-permission",null));
boolean isWriteEnabled= ( ((perm & 3 )==3)) ;
boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled ;
/**------check permission end---**/
if(!canModify) throw new NDSException(PortletUtils.getMessage(pageContext, "no-permission",null));

QueryResult result=null;
int actionType=Column.MODIFY;
ArrayList columns=table.getModifiableColumns(Column.MODIFY);
boolean isInput=true ;
int objectId=-1;
%>

<style type="text/css">
blink {behavior: url(<%=NDS_PATH%>/css/blink.htc);}
</style>
<%
String form_name="single_object_modify";
%>
<form name="<%=form_name%>" method="post" action="<%=contextPath %>/control/command" onSubmit="return checkOptions(document.single_object_modify);">
<input type='hidden' name="ref_by_table" value="<%=ParamUtils.getIntParameter(request,"select_tab", -1)%>">
<input type='hidden' name="mainobjecttableid" value="<%= ParamUtils.getIntAttributeOrParameter(request, "mainobjecttableid",-1)%>">
<input type='hidden' name="input" value="<%= true%>">
<input type='hidden' name="nds.control.ejb.UserTransaction" value="N">
<input type='hidden' name="next-screen" value="<%=NDS_PATH%>/info.jsp">
<input type='hidden' name='directory' value='<%= directory%>'>
<%
Expression expr=(Expression)request.getAttribute("userExpr");
if(expr==null){
	expr= query.getParamExpression();
}
%>
<input type='hidden' name='param_expr' value='<%=(expr==null?"":expr.toHTMLInputElement())%>'>
<input type="hidden" name="queryindex_-1" id="queryindex_-1" value="-1">
<%
String uri = request.getRequestURI();
String queryString = request.getQueryString();
%>
<input type='hidden' name='formRequest' value='<%=object_page_url%>'>

<%
request.setAttribute("form_name", form_name);
%>
<table width="721" align="center" border="0" cellspacing="0" cellpadding="0"><tr><td width="100%">
<%
ArrayList validCommands=new ArrayList();//element: String
validCommands.add("Submit");
%>

<table border="0" width="98%" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="<%=colorScheme.getPortletTitleBg()%>">
	<tr>
		<td align='right' >
	<span class="hand-span">
	<img border=0 width=16 height=16 src='<%=NDS_PATH+"/images/comments.gif"%>'>
	<blink id="batch_update_text"><font color='red'><i>
	<%=PortletUtils.getMessage(pageContext, "current-filter",null)%>:
	<%
		String filterDesc;
		if(query.getParamDesc(true).trim().equals(""))
    		filterDesc=PortletUtils.getMessage(pageContext, "none",null);
     	else
     		filterDesc=query.getParamDesc(true).trim();
     %>
     <%=filterDesc%>
	</i></font></blink>
	</span>
		</td>
	</tr>
</table>
<script>
function doSubmit(){
	if (!confirm("<%= PortletUtils.getMessage(pageContext, "do-you-confirm-batch-update" ,null)%>\n<%=filterDesc%>?")) {
         return false;
    }
	form=document.<%=form_name%>;
	form.command.value="BatchUpdate";
    showProgressWnd();
    submitForm(form);
}

</script>
<%@ include file="/html/nds/objext/inc_command.jsp" %>

</td></tr></table>
<table width="721" border="0" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#999999" align="center">
	<tr ><td>
	<br>
		<%
    //if true, will show data without variable, else show variable directly. This is used for template setting page
    //@see inc_template.jsp/inc_batchupdate.jsp
    boolean bReplaceVariable= false;
    /**
    * Always return "" for any request for properties
    */
    Properties prefs=new Properties(){
    	public String getProperty(String key) {
    		return "";
	    }
    };
	request.setAttribute("showcheckbox","false");
	%>
		<%@ include file="/html/nds/objext/inc_single_object.jsp" %>
	<br>
	</td></tr>
</table>
<br>
</form>


	</div>
</div>

<%@ include file="/html/nds/footer_info.jsp" %>
