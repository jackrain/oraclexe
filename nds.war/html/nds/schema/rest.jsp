<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%      
     /**显示接口定义
     @param table - table id  
     */
    TableManager manager=TableManager.getInstance();
    Table table=manager.getTable(Tools.getInt(request.getParameter("table"),-1));
    if(table==null) throw new NDSException("table id="+ request.getParameter("table") +" not found");
%>
<html><link type="text/css" rel="StyleSheet" href="/html/nds/schema/rest.css">
	<title><%=table.getDescription(locale)%> - REST for Portal</title>
<body>
<div  class="tle" ><a name="001">
	表：<b><%=table.getName()%> </b>, ID: <b><%=table.getId()%></b>,<p>
	描述：<b><%=table.getDescription(locale)%></b>
	<%if(table.isMenuObject()){%><a target="_blank" href="/html/nds/portal/portal.jsp?table=<%=table.getId()%>">进入ERP</a><%}%>
	<%
	if(table.isView()){
		Table rt=manager.getTable( table.getRealTableName());
	%> <p>
	实际表：<a href="rest.jsp?table=<%=rt.getId()%>"><%=rt.getDescription(locale)%></a>
	<%
	}
	if(nds.util.Validator.isNotNull(table.getComment())){%>
       	<p>
       	<%=table.getComment ()%>
    <%}%>	
	</a>
<p> 
PK 字段: <%=table.getPrimaryKey().getName()%><br>
AK 字段: <%=table.getAlternateKey().getName()+" "+ table.getAlternateKey().getDescription(locale)+" "+TableQueryModel.getInputBoxIndicator(table.getAlternateKey(),"",locale)%><br>
<br/>
<table border="0"  class="table" cellpadding="0"  cellspacing="10"  bgcolor="#ffffff">
<tr><td valign="top"><div class="ns">
允许操作:
<ul>
<%if(table.isActionEnabled(Table.ADD)){%>	
	<li><a href="#add">新增</a></li>
<%}%>		
<%if(table.isActionEnabled(Table.MODIFY)){%>	
	<li><a href="#modify">修改</a></li>
<%}%>
<%if(table.isActionEnabled(Table.DELETE)){%>	
	<li>删除</li>
<%}%>
<li><a href="#query">检索字段</a></li>
</ul> </div></td><td td valign="top"><div class="ns">
关联表：
<ul>
	<%
	ArrayList rbts=table.getRefByTables();
	for(int i=0;i<rbts.size();i++){
		RefByTable  rbt=(RefByTable)rbts.get(i); 
		Table rbtt= manager.getTable(rbt.getTableId());
	%> 
	<li><a href="rest.jsp?table=<%=rbt.getTableId()%>"><%=rbtt.getDescription(locale)%></a>(<%=(rbt.getAssociationType()==RefByTable.ONE_TO_MANY?"1:m":"1:1")%>) &nbsp;reftableid:<%=rbt.getId()%></li>
	<%	
	}%>
</ul></div> 
</td><td td valign="top"><div class="ns">
动作定义：名称+(ID)+描述
<ul>
	<%
	List<WebAction> actions=table.getWebActions(WebAction.DisplayTypeEnum.ObjButton);
  	List<WebAction> was=table.getWebActions(WebAction.DisplayTypeEnum.ObjMenuItem);
  	ArrayList actions2=new ArrayList();
  	for(int wasi=0;wasi<actions.size();wasi++){
  		WebAction wa=actions.get(wasi);
  		actions2.add(wa);
  	}
  	for(int wasi=0;wasi<was.size();wasi++){
  		WebAction wa=was.get(wasi);
  		actions2.add(wa);
  	}

	for(int i=0;i<actions.size();i++){
		WebAction  act=(WebAction)actions2.get(i); 
	%> 
	<li><%=act.getName()%> (<%=act.getId()%>) <%=act.getDescription()%></li>
	<%	
	}%>
</ul></div> 
</td></tr></table>	
</div>
<br/>  
<i>下列字段名称为红色表示不允许为空</i>
<table  border="0"  width="960" class="table" cellpadding="0"  cellspacing="1"  bgcolor="#dddddd">
<%
	String colName;
	Column col;
	ArrayList columns;
	PairTable  paretable ;
	boolean showMask=false;
if(table.isActionEnabled(Table.ADD)){
    columns=table.getColumns(new int[]{1}, true,userWeb.getSecurityGrade()); 

%>
<tr><td class="td" colspan="6">
<a name="add"><span class="anc">新增字段组织</span><br/></td></tr>
<%@ include file="inc_rest_cols.jsp"%>

<%
}
if(table.isActionEnabled(Table.MODIFY)){%>
<tr><td class="td" colspan="6"><br/>
<br/>
<a name="modify"><span class="anc">修改字段组织</span><br/>
</td></tr>
<%
    columns=table.getColumns(new int[]{3}, true,userWeb.getSecurityGrade()); 
%>
<%@ include file="inc_rest_cols.jsp"%>
<%}
ArrayList alc=table.getAllColumns();
columns=new ArrayList();
for(int j=0;j<alc.size();j++){
	columns.add(alc.get(j));
}

for(int i=columns.size()-1;i>=0;i-- ){
	col=(Column)columns.get(i);
	if(col.getDisplaySetting().isUIController() ) {
		columns.remove(i);
		continue;
	}
	int t=col.getDisplaySetting().getObjectType();
	if(t==DisplaySetting.OBJ_XML){
		columns.remove(i);
		continue;
	}
}
showMask =true;
%>
<tr><td class="td" colspan="6"><br/>
<br/>
<a name="query"><span class="anc">检索用字段</span><br/></td></tr>
<%@ include file="inc_rest_cols.jsp"%>	
</table>
</body></html>