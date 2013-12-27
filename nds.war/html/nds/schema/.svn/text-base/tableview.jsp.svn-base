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
</style>
<div  align="center" ><a name="001"><strong>---数据库结构设计---</strong></a></div>
<br>
<table  border="0"  width="550" class="table" cellpadding="0" cellspacing="1" bgcolor="#dddddd">
  <tr>
  	<td width="70" nowrap > 子系统 </td>
  	<td width="100" nowrap > 类别 </td>
  	<td width="150" nowrap > 表 </td>
  	<td width="330" nowrap align="left"> ID  表名称 </td>
  </tr>
<%
  for(int k=0;k<subsystems.size();k++){ 
      if(k>1) continue;
     subsystem=(SubSystem)subsystems.get(k); 
  %>
  <tr>
  	<td><%=subsystem.getDescription(locale)%></td>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
  </tr>
   <% 
     tabcategorylist=subsystemview.getTableCategories(request,subsystem.getId(),false);
     for(int x=0;x<tabcategorylist.size();x++){
       al= (List)tabcategorylist.get(x);
       tablecategory=(TableCategory)al.get(0);
        %>
   <tr>
  	<td>&nbsp;</td>
  	<td><%=tablecategory.getDescription(locale)%></td>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
   </tr>       
       <%
	   tablelist= (List) al.get(1);
	   for(int y=0;y<tablelist.size();y++){
	    table =(Table)tablelist.get(y); 
   %>

<tr> 
	<td>&nbsp;</td>
  	<td>&nbsp;</td>
	<td nowrap>
  <a href="#<%=table.getId()%>"> <%=table.getName()%></a>
   </td>	
     <td nowrap align="left"><span style="width:100px;padding-right:10px"><%=table.getId()%></span><%=table.getDescription(locale)%> </td>
   </tr>
 <%}}}%>
<table>
	<br>
 <table  border="0"  width="800" class="table" cellpadding="0"  cellspacing="1"  bgcolor="#dddddd">
	<%
for(int j=0;j<tableList.size();j++){
     table= (Table)tableList.elementAt(j);  
     ArrayList columns=table.getAllColumns(); 
%>

	<tr>
		<td colspan="6" class="td">
			<div id="Layer1"><div id="Layer2"><div id="<%=table.getId()%>" height="20"><b>
		表:<%=table.getName()%> &nbsp; <%=table.getDescription(locale)%></b>
      </div></div><div id="Layer3"><a href="#001">返回顶端</a></div></div>
       	<%if(nds.util.Validator.isNotNull(table.getComment())){%>
       	<br> 
       	<%=table.getComment ()%>
       	<%}%>
	    </td>  
     </tr>
       <tr>
            <td nowrap width="80" class="td1">字段名 </td>
  	        <td nowrap width="80" class="td1"> 字段描述</td>
  	        <td nowrap width="40" class="td1"> 类型 </td>
  	        <td nowrap width="40" class="td1"> 空值</td>
  	       	<td nowrap width="360" class="td1"> 下拉框选项/关联表</td>
  	        <td nowrap width="200" class="td1"> 备注 </td>
  	    </tr>
  	       	<%	if(columns.size()!=0){
  		     for(int i=0;i<columns.size();i++){
  			 Column col=(Column)(columns.get(i));
  	    %>
  	      	<%
  	     	if(col.getName().indexOf("(")==-1&&col.getName().indexOf(";")==-1&&col.getName().indexOf("+")==-1){	  	     	
  	     	%>
  	     	 <tr>
  	        <td class="td">
  	         <%=col.getName()%><%
  	         if(col.getId()==table.getAlternateKey().getId()){%>
  	          	&nbsp;<font color='red'><b>(AK)</b></font>
  	         <%}%>	
  	        </td>
  	        <td class="td">
  	        <%=col.getDescription(locale)%>	
  	        </td>
  	        <td class="td">
  	        	<%=col.getSQLType()%>
  	        	
  	        </td>
  	         <td class="td">
  	        	<%
  	        	if(col.isNullable()){ 
  	        	out.print("是");
  	        	 }else {
  	        	 	 out.print("否"); 
  	        	 }%>
  	        </td>	
  	          <td class="td">
  	           <%	if(col.getLimitValueGroupName()!=null){
  	               out.print(col.getLimitValueGroupName());
  	               paretable=(PairTable)col.getValues(locale);
  	               for(int m=0;m<paretable.size();m++){
  	                if(m%2==0){out.print("<br>&nbsp; &nbsp;");}
  	               out.print(paretable.getKey(m));
  	               out.print(":");
  	               out.print(paretable.getValue(m));
  	                out.print(",");
  	               }
  	             }else if(col.getReferenceTable()!=null){
  	                out.print("关联表:");
  	             %> 
  	             <a href="#<%=col.getReferenceTable().getId()%>">
  	             <%  
  	                out.print(col.getReferenceTable().getName());
  	              %>
  	            </a>
  	             <%
  	                out.print("&nbsp;");
  	                out.print(col.getReferenceTable().getDescription(locale));  
  	              }else{
  	              %>
  	              &nbsp; &nbsp;
  	               <%}%>	
  	        </td>   
  	      <td class="td">	
  	       	<%
  	       	if(col.getComment()!=null){ 
  	           out.print(col.getComment());
  	           }else{
  	           	out.print("&nbsp;");
  	    	}%>
  	        </td>
  	         </tr> 
  	        <%}}}%>	 
<tr>
	<td colspan="6" class="td">
		&nbsp; &nbsp; &nbsp; &nbsp;
	</td>
</tr>
<%}%>
</table>