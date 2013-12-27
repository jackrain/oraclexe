<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
	<tr>
            <td nowrap width="80" class="td1">JSON字段名 </td>
  	        <td nowrap width="80" class="td1"> 字段描述</td>
  	        <td nowrap width="200" class="td1"> 类型 </td>
  	        <td nowrap width="40" class="td1"> 缺省值</td>
  	       	<td nowrap width="360" class="td1"> 下拉框选项/关联表</td>
  	        <td nowrap width="200" class="td1"> 备注 </td>
  	    </tr>
	<%	
		for(int i=0;i<columns.size();i++){
  			 col=(Column)(columns.get(i));
  			  if(col.isVirtual())continue;
  			 if(col.getReferenceTable()!=null && !showMask){
  			 	colName= col.getName()+"__"+ col.getReferenceTable().getAlternateKey().getName();
  			 }else{
  			 	colName=  col.getName();
  			 }
  			 if(!col.isNullable() ) colName="<font color='red'><b>"+ colName+"</b></font>" ;
    %>
	<tr>
  	        <td class="td">
  	         <%=colName%>
  	         <%
  	         if(col.getId()==table.getAlternateKey().getId()){%>
  	          	&nbsp;<font color='red'><b>(AK)</b></font>
  	         <%}%>	
  	        </td>
  	        <td class="td">
  	        <%=col.getDescription(locale)%>	
  	        </td>
  	        <td class="td">
  	        	<%=TableQueryModel.getInputBoxIndicator(col,"",locale)%>
  	        </td>
  	         <td class="td" nowrap>
  	        	<%String defv=col.getDefaultValue();
  	        	%>
  	        	<%=(nds.util.Validator.isNotNull(defv)?defv:"&nbsp;")%>
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
  	             <a href="rest.jsp?table=<%=col.getReferenceTable().getId()%>">
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
  	    	}
  	    	if(showMask){
  	    	%>
  	    	<%}%>
  	        </td>
  	         </tr> 
	<%}//END COLUMNS
	%>	 
