<%@include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%@page import="nds.web.config.*"%>
<%
/**
  Manage query selection template,working as dialog
  User should be Users.isAdmin=1 and has read permission on that table
  param 
	 id   - ad_querylist.id, -1 for new
	 table - (int) table id, to which main table this query will work on.
*/
int qdId= nds.util.Tools.getInt( request.getParameter("id"),-1);
int tableId=nds.util.Tools.getInt( request.getParameter("table"),-1);
TableManager manager=TableManager.getInstance();
QueryEngine engine =QueryEngine.getInstance();
QueryListConfig qlc=null;
if(qdId!=-1)qlc=QueryListConfigManager.getInstance().getQueryListConfig(qdId);
else qlc=QueryListConfigManager.getInstance().getMetaDefault(tableId,userWeb.getSecurityGrade());

Table table=manager.getTable(qlc.getTableId());
String title= PortletUtils.getMessage(pageContext, "query-define",null);

// check write permission
//User should be Users.isAdmin=1 and has read permission on that table
if(!userWeb.isPermissionEnabled(table.getSecurityDirectory(),nds.security.Directory.READ) || Tools.getInt(engine.doQueryOne("select isadmin from users where id="+userWeb.getUserId()),-1)!=1 ){
	throw new NDSException("@no-permission@");
}

String tabName=title;
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=title%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="enable_context_menu" value="true" />
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<script language="javascript">
document.bgColor="<%=colorScheme.getPortletBg()%>";
</script>
<script type="text/javascript" src="<%=NDS_PATH+"/js/xloadtree111/xtree.js"%>"></script>
<script type="text/javascript" src="<%=NDS_PATH+"/js/xloadtree111/xmlextras.js"%>"></script>
<script type="text/javascript" src="<%=NDS_PATH+"/js/xloadtree111/xloadtree.js"%>"></script>
<script language="javascript" src="/html/nds/js/artDialog4/jquery.artDialog.js?skin=chrome"></script>
<script language="javascript" src="/html/nds/js/artDialog4/plugins/iframeTools.js"></script>
<link type="text/css" rel="stylesheet" href="<%=NDS_PATH+"/js/xloadtree111/xtree.css"%>" />
<script language="JavaScript" src="/html/nds/js/formkey.js"></script>
<script type='text/javascript' src='/html/nds/js/util.js'></script> 
<script language="javascript" src="/html/nds/js/init_querydef_<%=locale.toString()%>.js"></script>
<script language="javascript" src="/html/nds/js/querydef.js"></script>
<link href="/html/nds/css/querydef.css" rel="stylesheet" type="text/css" />

<table width="98%" cellspacing="0" cellpadding="0" border="0" align="left">
<tr><td>
<%=PortletUtils.getMessage(pageContext, "current-table",null)%>: <%=table.getDescription(locale)%>&nbsp;&nbsp;
</td><td> &nbsp;&nbsp;<%=PortletUtils.getMessage(pageContext, "switch-template",null)%>:
<select id="seltemplate" class="objsel1" tabindex="2" name="seltemplate" onchange="qd.changeSelection()">
<%
PairTable pt=QueryListConfigManager.getInstance().getQueryListConfigs(table.getId(),false);

if(pt.size()>0){
	
	for(Iterator it=pt.keys();it.hasNext();){
		Integer qlid=(Integer)it.next();
		Object[] vs= (Object[])pt.get(qlid);
		String name=(String)vs[0];
		boolean isSelected=(qlid.intValue()==qdId);
%>
<option value="<%=qlid%>"><%=name%></option>
<%	
	}%>
	<option value="-1">DEFAULT</option>
<%
}else{
%>
<option value="-1">DEFAULT</option>
<%
}
%>
</select></td></tr>
<tr><td valign="top" width="200"><div id="tree"><!--tree-->
<%= PortletUtils.getMessage(pageContext, "available-columns",null)%>:
<div class="ctree"> 	
<script type="text/javascript">
/// XP Look
webFXTreeConfig.rootIcon		= "/html/nds/images/table.gif";
webFXTreeConfig.openRootIcon	= "/html/nds/images/table.gif";
webFXTreeConfig.folderIcon		= "/html/nds/images/table.gif";
webFXTreeConfig.openFolderIcon	= "/html/nds/images/table.gif";
webFXTreeConfig.fileIcon		= "/html/nds/images/column.gif";

webFXTreeConfig.lMinusIcon		= "/html/nds/js/xloadtree111/images/xp/Lminus.png";
webFXTreeConfig.lPlusIcon		= "/html/nds/js/xloadtree111/images/xp/Lplus.png";
webFXTreeConfig.tMinusIcon		= "/html/nds/js/xloadtree111/images/xp/Tminus.png";
webFXTreeConfig.tPlusIcon		= "/html/nds/js/xloadtree111/images/xp/Tplus.png";
webFXTreeConfig.iIcon			= "/html/nds/js/xloadtree111/images/xp/I.png";
webFXTreeConfig.lIcon			= "/html/nds/js/xloadtree111/images/xp/L.png";
webFXTreeConfig.tIcon			= "/html/nds/js/xloadtree111/images/xp/T.png";
webFXTreeConfig.blankIcon		= "/html/nds/js/xloadtree111/images/xp/blank.png";
var tree = new WebFXLoadTree("<%=table.getDescription(locale)%>", "<%=NDS_PATH+"/query/querydefxml.jsp?table="+table.getId()%>");
tree.setBehavior("classic");
document.write(tree);
</script>       	
</div>	
		<!--end tree--></div>
<div id="info">
</div>		
</td>
<td valign="top"><div id="cls">
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<table cellpadding="4" cellspacing="0" width="600" height="316">
<tr><td colspan="6"><div class="defq"><input type="checkbox" id="defquery" <%=qlc.isDefault()?"checked":""%>><%= PortletUtils.getMessage(pageContext, "set-as-default-dcq",null)%></td></tr>
<tr>
	<td width="25" valign="top"><div class="mv">
		<input type="button" value=">" onclick="qd.addColumn('d')"/> 
		<input type="button" value="<" onclick="qd.removeColumn('d')"/> <p>
		<span id='d_moveup' onaction="qd.moveUp('d')"><img border=0 width=16 height=16 align=absmiddle src='/html/nds/images/moveup.gif'></span><br>
		<span id='d_movedown' onaction="qd.moveDown('d')"><img border=0 width=16 height=16 align=absmiddle src='/html/nds/images/movedown.gif'></span>
		</div>
	</td>
	<td width="173"  height="117">
		<%=PortletUtils.getMessage(pageContext, "display-columns",null)%><br>	
		<SELECT id="col_d" class="selectbox" MULTIPLE size="25" title="<%=PortletUtils.getMessage(pageContext, "display-columns",null)%>" ondblclick="qd.editColumn('d')" onfocus="qd.setCurrentList('d')"></SELECT>
	</td>
	<td width="25" valign="top"><div class="mv">
		<input type="button" value=">" onclick="qd.addColumn('f')"/> 
		<input type="button" value="<" onclick="qd.removeColumn('f')"/> <p>
		<span id='f_moveup' onaction="qd.moveUp('f')"><img border=0 width=16 height=16 align=absmiddle src='/html/nds/images/moveup.gif'></span><br>
		<span id='f_movedown' onaction="qd.moveDown('f')"><img border=0 width=16 height=16 align=absmiddle src='/html/nds/images/movedown.gif'></span></div>
	</td>
	<td width="173"  height="117">
		<%=PortletUtils.getMessage(pageContext, "filter-columns",null)%><br>
		<SELECT id="col_f" class="selectbox" MULTIPLE size="25" title="<%=PortletUtils.getMessage(pageContext, "filter-columns",null)%>" ondblclick="qd.editColumn('f')" onfocus="qd.setCurrentList('f')"></SELECT>
	</td>
	<td width="25" valign="top"><div class="mv">
		<input type="button" value=">" onclick="qd.addColumn('o')"/> 
		<input type="button" value="<" onclick="qd.removeColumn('o')"/> <p>
		<span id='o_moveup' onaction="qd.moveUp('o')"><img border=0 width=16 height=16 align=absmiddle src='/html/nds/images/moveup.gif'></span><br>
		<span id='o_movedown' onaction="qd.moveDown('o')"><img border=0 width=16 height=16 align=absmiddle src='/html/nds/images/movedown.gif'></span><br><br>
		<span id='o_orderby' onaction="qd.chkasc()"><img border=0 width=16 height=16 title="<%=PortletUtils.getMessage(pageContext, "querydef-orderby",null)%>" align=absmiddle src='/html/nds/images/orderby.gif'></span>
		</div>
	</td>
	<td width="173"  height="117">
		<%=PortletUtils.getMessage(pageContext, "orderby-columns",null)%><br>
		<SELECT id="col_o" class="selectbox" MULTIPLE size="25" title="<%=PortletUtils.getMessage(pageContext, "orderby-columns",null)%>" ondblclick="qd.editColumn('o')" onfocus="qd.setCurrentList('o')"></SELECT>
	</td>
</tr>
</table>

<div class="btns">
<input class="cbutton" type='button' id="btn_save" size="20" name='executeCxrpt' value='<%=PortletUtils.getMessage(pageContext, "save",null)%>' onclick="javascript:qd.save()" >&nbsp;&nbsp;
<input class="cbutton" type='button' id="btn_saveas" size="20" value='<%=PortletUtils.getMessage(pageContext, "save-as",null)%>' onclick="javascript:qd.openSaveDialog();" >
<input class="cbutton" type='button' id="btn_delete" size="20" value='<%=PortletUtils.getMessage(pageContext, "delete-current-template",null)%>' onclick="javascript:qd.del();" >
<input class="cbutton" type='button' id="btn_close" size="20" value='<%=PortletUtils.getMessage(pageContext, "close",null)%>' onclick="javascript:qd.tryClose();" >
</div>
	</div>
</div></div><!--cls-->
</td></tr></table>

<!--following is div used for dialogs-->
<div id="dlg_clink" style="display:none">
<div id="TMPLdlg_clink_content" class="clinkdlg"> 	
	<table cellpadding="4" cellspacing="0" border="0" width="400" height="140">
		<tr><td width="15%" nowrap ><%=manager.getColumn("ad_cxtab_dimension","COLUMNLINK").getDescription(locale)%><font color="red">*</font>:</td>
			<td width="85%" align="left"><input title="<%=manager.getColumn("ad_cxtab_dimension","COLUMNLINK").getDescription(locale)%>" type="text"  id="TMPLcolumnlink" value="" size="60" maxlength="255" /></td>
		</tr><tr>
			<td width="15%" nowrap><%=manager.getColumn("ad_cxtab_dimension","DESCRIPTION").getDescription(locale)%><font color="red">*</font>:</td>
			<td width="85%" align="left"><input title="<%=manager.getColumn("ad_cxtab_dimension","DESCRIPTION").getDescription(locale)%>" type="text"  id="TMPLdescription" value="" size="60" maxlength="80" /></td>
		</tr><tr>	
			<td colspan="2">
				<input class="command2_button" type='button' id="TMPLbtn_save_dim" size="20" value='<%=PortletUtils.getMessage(pageContext, "command.ok",null)%>' onclick="javascript:qd.saveColumn();" > &nbsp;&nbsp;
				<input class="command2_button" type='button' id="TMPLbtn_cancel_dim" size="20" value='<%=PortletUtils.getMessage(pageContext, "command.cancel",null)%>' onclick="javascript:qd.art_close('art_dlg_clink_content');" > 
				<input type="hidden"  id="TMPLlisttag" value=""/>
				<br><br>
			</td>
		</tr>		
	</table>
</div>
</div>
<div id="dlg_save" style="display:none">
<div id="TMPLdlg_save_content" class="savedlg"> 
	
	<%=PortletUtils.getMessage(pageContext, "input-template-name",null)%>:
	<input type="text"  id="TMPLtemplatename" value="" size="60" maxlength="255" onkeydown="javascript:qd.onNameReturn(event);" />
	<br><br>
	<input class="command2_button" type='button' id="TMPLbtn_save_name" size="20" value='<%=PortletUtils.getMessage(pageContext, "command.ok",null)%>' onclick="javascript:qd.saveNew();" > &nbsp;&nbsp;
	<input class="command2_button" type='button' id="TMPLbtn_cancel_name" size="20" value='<%=PortletUtils.getMessage(pageContext, "command.cancel",null)%>' onclick="javascript:qd.art_close('art_dlg_save_content');">
	<br>
</div>
</div>
<br><br>
<script>
	setTimeout("qd.setSelected(<%=qdId%>,<%=tableId%>);",500);
</script>	
<%@ include file="/html/nds/footer_info.jsp" %>
