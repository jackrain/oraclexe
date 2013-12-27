<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/portlet/nds/init.jsp" %>
<%!
	/**
	* Parameters: 
	*   startidx --  start index for query
	*   order    --  order column(int) if not set will set to creationdate of u_note
	*   asc      --  1 for ascending, else for descending, default to desc
	*/
	
	
	/**
	*  max length to be display for the news' subject,
	*  if greater than that, will append ".."
	*/
 	private final static int MAX_SUBJECT_LENGTH_NARROW_1024=30;
 	private final static int MAX_SUBJECT_LENGTH_WIDE_1024=80;
 	private final static int MAX_SUBJECT_LENGTH_MAX_1024=160;
 	private final static int MAX_SUBJECT_LENGTH_NARROW_800=24;
 	private final static int MAX_SUBJECT_LENGTH_WIDE_800=50;
 	private final static int MAX_SUBJECT_LENGTH_MAX_800=120;
	
%>
<%
Portlet portlet = PortletManagerUtil.getPortletById(company.getCompanyId(), portletConfig.getPortletName());
%>
<script>
 
 function opn_<%=renderResponse.getNamespace()%>(oid){
 	popup_window("<%=NDS_PATH%>/sheet/object.jsp?table=u_note&id="+oid);
 }
 function opu_<%=renderResponse.getNamespace()%>(oid){
 	popup_window("<%=NDS_PATH%>/sheet/object.jsp?table=users&id="+oid);
 }
</script>

<%
	if(!userWeb.isActive()){
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td align="center">
<font class="bg" size="2"><span class="bg-neg-alert">
<%= PortletUtils.getMessage(pageContext, "current-are-not-active",null)%>
</span></font>
</td></tr></table>

<%  }else{
%>

<%
boolean isNarrow=portlet.isNarrow();
long windowWidth=RES_TOTAL;
DateFormat df = new java.text.SimpleDateFormat("MM-dd HH");
//df.setTimeZone(timeZone);
UNoteDAO dao=new UNoteDAO();
TableManager manager=TableManager.getInstance();
int startIndex= ParamUtil.get(renderRequest, "startidx", 0);
int orderColumnId= ParamUtil.get(renderRequest, "order", -1);
int asc= ParamUtil.get(renderRequest, "asc", -1);
if(orderColumnId==-1) 
	orderColumnId=TableManager.getInstance().getColumn("u_note","creationdate").getId();


 QueryResult result;
 int oid,uid;
 int priority;
 String title, uname,docstatus; 
 String startDate, creationDate;
 boolean isRead;
 int recordCount,i, maxTitleLength; 
	
%>
<table border="0" cellpadding="4" cellspacing="0" width="95%">

<% if(isNarrow==true && renderRequest.getWindowState() ==WindowState.NORMAL){
//narrow one
maxTitleLength=resolution.equals(Resolution.S1024X768_KEY)?MAX_SUBJECT_LENGTH_NARROW_1024:MAX_SUBJECT_LENGTH_NARROW_800;
 result= dao.find(request, 10, 0, orderColumnId, (asc==1) );
 while(result.next()){
 	 oid=((java.math.BigDecimal)result.getObject(1)).intValue();
 	 priority=Tools.getInt(result.getObject(2),3) ; //  "1" for emergency, "2" for urgent, "3" for normal
 	 title= (String)result.getObject(3);
 	 if(Validator.isNull(title)){
 	 	title=StringUtils.NBSP;
 	 }else{
 	 	title=StringUtils.shortenInBytes(title, maxTitleLength);
 	 }
 	 uname= (String)result.getObject(4);
 	 uid= result.getObjectID(4);
 	 
 	 if(result.getObject(5) !=null){ 
 	 	startDate= df.format((java.util.Date)result.getObject(5));
 	 }else{
 	 	startDate=StringUtils.NBSP;
 	 }
 	 if(result.getObject(6) !=null){ 
 	 	creationDate= df.format((java.util.Date)result.getObject(6));
 	 }else{
 	 	creationDate=StringUtils.NBSP;
 	 }
	 docstatus=(String)result.getObject(7);
	 isRead= "read".equalsIgnoreCase(docstatus);
%>
		<tr>
		    <td nowrap><%if( priority <=2){%>
					<img width=5 height=11 border=0 src="<%=contextPath%>/html/portlet/nds/notice/images/alert.gif">
				<%}%>
				<%if( priority <=1){%>
					<img width=5 height=11 border=0 src="<%=contextPath%>/html/portlet/nds/notice/images/alert.gif">
				<%}%>
			</td>
			<td>
				<font class="gamma" size="2"> 
				<%=(!isRead?"<b>":"")%>
				<a class="gamma" href="javascript:opn_<%=renderResponse.getNamespace()%>(<%=oid%>)">
					<%=title%>
				</a>
				<%=(!isRead?"</b>":"")%>
				</font>
			</td>
		</tr>
<%
 }
 
%>
<%if(!Boolean.TRUE.equals(session.getAttribute("allow_parent_frame"))){%>
<tr><td align='right' colspan=2><font class="gamma" size="2">
 [<a class="gamma" href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"/>">
 	<%= PortletUtils.getMessage(portletConfig, locale, "more",null)%>
 </a>]
</font></td></tr>
<%}%>
<%}else{%>
<tr>
<td width=1> </td>
<td> <font class="beta" size="2"><b><%= PortletUtils.getMessage(portletConfig, locale, "title" ,null)%></b> </td>
<td> <font class="beta" size="2"><b><%= PortletUtils.getMessage(portletConfig, locale, "author" ,null)%> </b></td>
<td> <font class="beta" size="2"><b><%= PortletUtils.getMessage(portletConfig, locale, "startdate" ,null)%> </b></td>
<td> <font class="beta" size="2"><b><%= PortletUtils.getMessage(portletConfig, locale, "creationdate" ,null)%></b> </td>
</tr>
<%
	if(renderRequest.getWindowState() !=WindowState.MAXIMIZED ){
		// wide one
		recordCount=15;
		maxTitleLength=resolution.equals(Resolution.S1024X768_KEY)?MAX_SUBJECT_LENGTH_WIDE_1024:MAX_SUBJECT_LENGTH_WIDE_800;
	}else{
		// maiximized one
		recordCount=30;
		maxTitleLength=resolution.equals(Resolution.S1024X768_KEY)?MAX_SUBJECT_LENGTH_MAX_1024:MAX_SUBJECT_LENGTH_MAX_800;
	}
 result= dao.find(request, recordCount, startIndex, orderColumnId, (asc==1) );
 
 while(result.next()){
 	 oid=((java.math.BigDecimal)result.getObject(1)).intValue();
 	 priority=Tools.getInt(result.getObject(2),3) ; //  "1" for emergency, "2" for urgent, "3" for normal
 	 title= (String)result.getObject(3);
 	 if(Validator.isNull(title)){
 	 	title=StringUtils.NBSP;
 	 }else{
 	 	title=StringUtils.shortenInBytes(title, maxTitleLength);
 	 }
 	 uname= (String)result.getObject(4);
 	 uid= result.getObjectID(4);
 	 
 	 if(result.getObject(5) !=null){ 
 	 	startDate= df.format((java.util.Date)result.getObject(5));
 	 }else{
 	 	startDate=StringUtils.NBSP;
 	 }
 	 if(result.getObject(6) !=null){ 
 	 	creationDate= df.format((java.util.Date)result.getObject(6));
 	 }else{
 	 	creationDate=StringUtils.NBSP;
 	 }
	 docstatus=(String)result.getObject(7);
	 isRead= "read".equalsIgnoreCase(docstatus);	
%>
		<tr>
		    <td nowrap align='right'>
		    	<%if( priority <=2){%>
					<img width=5 height=11 border=0 src="<%=contextPath%>/html/portlet/nds/notice/images/alert.gif">
				<%}%>
				<%if( priority <=1){%>
					<img width=5 height=11 border=0 src="<%=contextPath%>/html/portlet/nds/notice/images/alert.gif">
				<%}%>
			</td>
		
			<td>
				<font class="gamma" size="2"> 
				<%=(!isRead?"<b>":"")%>
				<a class="gamma" href="javascript:opn_<%=renderResponse.getNamespace()%>(<%=oid%>)">
					<%=title%>
				</a>
				<%=(!isRead?"</b>":"")%>
				</font>
			</td>
			<td>
				<font class="gamma" size="2">
					<a class="gamma" href="javascript:opu_<%=renderResponse.getNamespace()%>(<%=uid%>)">
					<%=uname%>
					</a>
				</font>
			</td>
			<td>
				<font class="gamma" size="2">
				<%= startDate %>
				</font>
				
			</td>
			<td>
				<font class="gamma" size="2">
				<%=creationDate %>
				</font>
				
			</td>

		</tr>
<%
 }
if(renderRequest.getWindowState() !=WindowState.MAXIMIZED ){
 // wide one
%>
<%if(!Boolean.TRUE.equals(session.getAttribute("allow_parent_frame"))){%>
<tr><td align='right' colspan=5><font class="gamma" size="2">
  [<a class="gamma" href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"/>">
 	<%= PortletUtils.getMessage(portletConfig, locale, "more",null)%>
 </a>]
</font>
</td></tr>
<%}%>
<%
 }else{
 // max one
 int totalCount=dao.getTotalCount(request);
%>
<tr><td align='right' colspan=5><font class="gamma" size="2">
[<% for(i=0 ;i< ((totalCount/recordCount)>15?15:(totalCount/recordCount));i++){ %>
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%=""+i*recordCount%>" /><portlet:param name="order" value="<%=""+orderColumnId%>" /><portlet:param name="asc" value="<%=""+asc%>" /></portlet:renderURL>" >
 	<%=(i*recordCount)+1%>,&nbsp;
 </a>
<%}%>
&nbsp;&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%="0"%>" /><portlet:param name="order" value="<%=""+orderColumnId%>" /><portlet:param name="asc" value="<%=""+asc%>" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "first-page",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%=""+(startIndex-recordCount)%>" /><portlet:param name="order" value="<%=""+orderColumnId%>" /><portlet:param name="asc" value="<%=""+asc%>" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "previous-page",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%=""+(startIndex+recordCount)%>" /><portlet:param name="order" value="<%=""+orderColumnId%>" /><portlet:param name="asc" value="<%=""+asc%>" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "next-page",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%=""+(totalCount-recordCount)%>" /><portlet:param name="order" value="<%=""+orderColumnId%>" /><portlet:param name="asc" value="<%=""+asc%>" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "last-page",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%="0"%>" /><portlet:param name="order" value="<%=""+manager.getColumn("u_note","docstatus").getId()%>" /><portlet:param name="asc" value="1" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "order-by-docstatus",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%="0"%>" /><portlet:param name="order" value="<%=""+manager.getColumn("u_note","creationdate").getId()%>" /><portlet:param name="asc" value="0" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "order-by-creationdate",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%="0"%>" /><portlet:param name="order" value="<%=""+manager.getColumn("u_note","startdate").getId()%>" /><portlet:param name="asc" value="0" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "order-by-startdate",null)%>
 </a>,&nbsp;
  <a class="gamma" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="startidx" value="<%="0"%>" /><portlet:param name="order" value="<%=""+manager.getColumn("u_note","priorityrule").getId()%>" /><portlet:param name="asc" value="1" /></portlet:renderURL>" >
 	<%= PortletUtils.getMessage(portletConfig, locale, "order-by-priorityrule",null)%>
 </a>
 
 ]
</font>
</td></tr> 
<%}
}%>

</table>
<%}//end if acitve
%>
