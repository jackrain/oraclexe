<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%      
    TableManager manager=TableManager.getInstance();
    Vector tableList=(Vector)manager.getAllTables();
    PairTable paretable=null;
    List subsystems=manager.getSubSystems();
    SubSystemView subsystemview=new SubSystemView();
    List tabcategorylist,al;
    List tablelist=null;
    SubSystem subsystem=null;
    TableCategory tablecategory=null;
    Table table=null;
    int pos=0;
%>
<html>
<style type="text/css">
<!--
.table{
  font-size:13px;
  line-height:20px;
}
.td{
   background-color:#fff;
 }
 .td1{
  background-color:#999999;
  color:#FFFFFF;
  text-align:center;
  font-weight: bold;
   }
#Layer1 {
	width:778px;
	height:22px;
}
#Layer2 {
    float:left;
	width:560px;

}
#Layer3 {
	width:200px;
	float:right;
	text-align:right;
	padding-right:10px;
}
-->
</style><title>Index - REST for Portal</title><body>
<div  align="center" ><a name="001"><strong>---数据库结构设计---</strong></a></div>
<br>
<table  border="0"  width="550" class="table" cellpadding="0" cellspacing="1" bordercolor="#dddddd">
  <tr>
  	<td width="70" nowrap > 子系统 </td>
  	<td width="100" nowrap > 类别 </td>
  	<td width="150" nowrap > 表 </td>
  	<td width="330" nowrap align="left"> ID  表名称 </td>
  </tr>
<%
  for(int k=0;k<subsystems.size();k++){ 
     subsystem=(SubSystem)subsystems.get(k); 
  %>
  <tr>
  	<td><%=subsystem.getDescription(locale)%></td>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
  </tr>
   <% 
     tabcategorylist=subsystem.getTableCategories();
     
     for(int x=0;x<tabcategorylist.size();x++){
       tablecategory=(TableCategory)tabcategorylist.get(x);
       tablelist= tablecategory.getTables();
   %>
   <tr>
  	<td>&nbsp;</td>
  	<td><%=tablecategory.getDescription(locale)%></td>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
   </tr>       
       <%
	   for(int y=0;y<tablelist.size();y++){
	    table =(Table)tablelist.get(y); 
   %>

<tr> 
	<td>&nbsp;</td>
  	<td>&nbsp;</td>
	<td nowrap>
  <a target="_blank" href="rest.jsp?table=<%=table.getId()%>"> <%=table.getName()%></a>
   </td>	
     <td nowrap align="left"><span style="width:100px;padding-right:10px"><%=table.getId()%></span><%=table.getDescription(locale)%> </td>
   </tr>
 <%}}}%>
<table>
	<br>
</body></html>