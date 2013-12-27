<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
	/**
	* Attributes:
	*     tab_content | page to show tab content (String), start from "/", relative to "html/nds"
	*     tab_name	  | tab name ( description)
	*     tab_href    | tab href (url)
	      context_menu| true| false
	*/

String tabContent= (String)request.getAttribute("tab_content");
String tabName = (String)request.getAttribute("tab_name");
String tabHREF = (String)request.getAttribute("tab_href");
boolean enableContextMenu=nds.util.Tools.getBoolean(request.getAttribute("enable_context_menu"), false);
if(tabHREF !=null) tabHREF=NDS_PATH + tabHREF;
else tabHREF="#";
%>

<%
int navTabTotalWidth=DEFAULT_TAB_WIDTH; //total table width
%>
<%if(!enableContextMenu){%>
<script>
try{document.attachEvent( "oncontextmenu", showContextMenu );
	document.attachEvent( "onkeyup", rememberKeyCode );
}catch(e){}
</script>
<%}%>
<table border="0" cellpadding="0" cellspacing="0" width="<%= navTabTotalWidth %>">
<tr>
<%
String borderColor = "class=\"alpha\"";
//Set the maximum length to display a tab name.
int tabNameMaxLength =14; // in bytes
//Set the maximum number of tabs per row.
int tabsPerRow =6;

int tabPixels = (int)(navTabTotalWidth * (((double)1 / tabsPerRow) - .01));
int tabSeparationPixels = 2;

int totalTabs = 1;
int leftOverPixels = (tabsPerRow < totalTabs) ? (navTabTotalWidth - (tabsPerRow * tabPixels) - (tabsPerRow * tabSeparationPixels)) : (leftOverPixels = navTabTotalWidth - (totalTabs * tabPixels) - (totalTabs * tabSeparationPixels));

int layoutCounter = 0;
int layoutBreak = totalTabs	% tabsPerRow;

int selectedTabColIdx=0;
int selectedTabWidth=tabPixels;
int tabColIdx=-1;

	layoutCounter++;
	tabColIdx++;
	boolean isSelectedTab =true;
	
%>
	<%@ include file="/html/nds/object_tab.jsp" %>

	<c:if test="<%= (totalTabs > tabsPerRow) && (layoutCounter % tabsPerRow == layoutBreak) && (layoutCounter != totalTabs)  %>">
		</tr><tr>
	</c:if>
	<td nowrap width="<%= leftOverPixels %>"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="<%= leftOverPixels %>"></td>
</tr>
</table>

<table id="object_table" border="0" cellpadding="0" cellspacing="0" width="<%= navTabTotalWidth %>">
		<tr>
		<td colspan=5>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
			<td <%=borderColor%> width="<%=1+selectedTabColIdx*(tabSeparationPixels+tabPixels)%>"><img border="0" height="1" hspace="0"  src="<%= COMMON_IMG %>/spacer.gif" vspace="0" ></td>
			<td class="gamma" width="<%=selectedTabWidth-1>0?selectedTabWidth-1:0%>"><img border="0" height="1" hspace="0"  src="<%= COMMON_IMG %>/spacer.gif" vspace="0" ></td>
			<td <%=borderColor%> ><img border="0" height="1" hspace="0"  src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="<%=navTabTotalWidth-selectedTabColIdx*(tabSeparationPixels+tabPixels)-selectedTabWidth %>"></td>
			</tr>
		</table>
		</td>
		</tr>

	<tr>
		<td class="alpha"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
		<td class="gamma"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="4"></td>
		<td class="gamma" width="<%= navTabTotalWidth - 10 %>">
		<% 
		request.setAttribute("internal_table_width", ""+(navTabTotalWidth - 10));
		%>
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
			<tr><td>
	<liferay-util:include page="<%= NDS_PATH + tabContent %>"/>
			</td></tr>
			</table>
		
		</td>
		<td class="gamma"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="4"></td>
		<td class="alpha"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>
	</tr>

			<tr>
				<td colspan=5 class="alpha"><img border="0" height="1" hspace="0" src="<%= COMMON_IMG %>/spacer.gif" vspace="0" width="1"></td>				
			</tr>
	</table>
	
