<%
 /**
 * nds/mainmenu/view.jsp
 */
%>
<%@ include file="/html/portlet/nds/init.jsp" %>
<%
	CreatePortal cp= new CreatePortal();
	Iterator it;
	String tableWidth="95%";
%>

<%
	if(!userWeb.isActive()){
%>
<table border="0" cellpadding="0" cellspacing="0" width="<%=tableWidth%>">
<tr><td align="center">
<font class="bg" size="2"><span class="bg-neg-alert">
<%= PortletUtils.getMessage(pageContext, "current-are-not-active",null)%>
</span></font>
</td></tr></table>

<%  }else{
%>

<table border="0" cellpadding="0" cellspacing="4" width="<%=tableWidth%>">
<tr>		
<td colspan=3 align='center'>
<%@ include file="/html/portlet/nds/mainmenu/inc_unread_notes.jsp" %>
</td>
</tr>
<%
	TableManager manager= TableManager.getInstance();
	Integer tb;
	Table tbl;

	Properties props= userWeb.getPreferenceValues("mainmenu",true);
	boolean bShowFrequent=("Y".equals(props.getProperty("show_frequent", "Y")));
	boolean bShowCategory=("Y".equals(props.getProperty("show_category", "Y")));
	if(bShowFrequent){
%>
<tr>
	 <td valign="top" align='left' width="50%">
	 <!-- visited one -->
	 <table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td valign="top" align='left'>
			<font class="beta"><b>&nbsp;&nbsp;
				<%= PortletUtils.getMessage(pageContext, "my-recent-visit",null)%>
				</b></font>
			</td>
			
		</tr>
		<tr>
		<td valign="top" align='left'>
				<font class="gamma" size="2">
<%
	it= userWeb.getVisitTables();
	while(it.hasNext()){
		tb=(Integer)it.next();
		tbl=manager.getTable(tb.intValue());
		if( tbl!=null){
%>	
		<a class='gamma' href="javascript:opt_(<%=tb%>)"><%=tbl.getDescription(locale)%></a><br>
<%		}
	}
%>
				</font>
						
		</td></tr>
		<tr>
		</table>
		<!-- end visited one -->
		</td>
		<td width="1" class="beta">
		<img border="0" width="1" hspace="0"  src="<%= COMMON_IMG %>/spacer.gif" vspace="0" >
		</td>		
		<td valign="top" align='left'  width="50%">
		<!-- frequent one -->
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td valign="top" align='left'>
			<font class="beta"><b>&nbsp;&nbsp;
				<%= PortletUtils.getMessage(pageContext, "my-frequent-visit",null)%>
				</b></font>
				
			</td>
		</tr>
		<tr>
		<td valign="top" align='left'>
				<font class="gamma" size="2">
<%
	it= userWeb.getFrequentTables();
	while(it.hasNext()){
		tb=(Integer)it.next();
		tbl=manager.getTable(tb.intValue());
		if( tbl!=null){
%>	
		<a class='gamma' href="javascript:opt_(<%=tb%>)"><%=tbl.getDescription(locale)%></a><br>
<%		}
	}
%>
				</font>
		</td></tr>
		<tr>
		</table>
		<!-- end frequent one -->
		</td>
	</tr>
<%} // end if bShowFrequent
%>	
	<!-- begin favorite-->
<%@ include file="/html/portlet/nds/mainmenu/inc_favorite.jsp" %>
<%
  if(bShowCategory){
%>  
	<!--begin categories-->
	<tr>
 	<td valign="top" align="center" colspan="3">
<table border="0" cellpadding="0" cellspacing="0" width='90%' align="center">
<tr><td nowrap><font class="beta"><b><%= PortletUtils.getMessage(pageContext, "categorys",null)%></b></font></td>
<td width="90%"><hr width="90%" size="1" noshade color="<%=colorScheme.getPortletBg()%>"></td>
</tr></table>

	</td>
	</tr>
	<tr><td valign="top" align='left'>
	  <font class="gamma" size="2">
<%
	List lst= cp.getTableCategoryIds(request);
	String ca;
	String caEnc;
	for(int i=0;i<(lst.size()/2 + lst.size()%2);i++){
		ca=manager.getTableCategory( ((Integer) lst.get(i)).intValue()).getDescription(locale);
		caEnc=ca;//Http.encodeURL(ca);
		
%>	
	<a class='gamma' href='javascript:opc_("<%=caEnc%>")'><%=ca%></a><br>
<% }
%> 
	</font></td>
	<td> </td>		
	<td valign="top" align='left'>
	<font class="gamma" size="2">
<%
	for(int i=(lst.size()/2 + lst.size()%2);i<lst.size();i++){
		ca= manager.getTableCategory( ((Integer) lst.get(i)).intValue()).getDescription(locale);
		caEnc=ca;//Http.encodeURL(ca);
		
%>	
	<a class='gamma' href='javascript:opc_("<%=caEnc%>")'><%=ca%></a><br>
<% }
%>
	</font>
	</td>
	</tr>
<%}//end bShowCategory%>
<tr>		
<td colspan=3 align='center'>
<table border="0" cellpadding="0" cellspacing="0" width='100%' align="center">
<form action="<%=NDS_PATH+"/sheet/objects.jsp"%>" method="get" name="<portlet:namespace />search_fm">
<tr><td align="left">	<br>
<input class="form-text" style="background-color:<%=colorScheme.getPortletBg()%>;" name="category" size="15" type="text">
	<a class='gamma' href="#"" onClick="document.<portlet:namespace />search_fm.submit();">[<%= LanguageUtil.get(pageContext, "search") %>]</a>
	<a class='gamma' href="javascript:popup_window('/help/Wiki.jsp?page=Help')">[<%= LanguageUtil.get(pageContext, "help") %>]</a>
</td></tr></form></table>
</td>
</tr>
</table>
<%}//end if acitve
%>
