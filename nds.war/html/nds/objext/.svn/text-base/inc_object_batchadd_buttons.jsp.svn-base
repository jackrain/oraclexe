<%   
	/**
	*  validCommands, fixedColumns, table
	*/
	ArrayList validCommands=new ArrayList();//element: String
    validCommands.add("ListCreate");	
    validCommands.add("CopyFrom");	
    request.setAttribute("validCommands",validCommands);
    
%>    
<%@ include file="/html/nds/objext/inc_command.jsp" %>
<%@ include file="/html/nds/objext/inc_checkoptions.jsp" %>

<script>
function doCopyFrom(){
	window.location="<%=NDS_PATH+"/sheet/copyfrom.jsp?"+WebUtils.getMainTableLink(request)+"dest_table="+tableId+"&action=input&fixedcolumns="+
	java.net.URLEncoder.encode(fixedColumns.toURLQueryString(""))%>";
}

function doListCreate(){
	form=document.<%=form_name%>;
	form.command.value="<%=table.getName()%>ListCreate";
	if( checkOptions(form) !=false){
       	showProgressWnd(); 
       	submitForm(form);
    }
}

function checkOptions(form){
    <%
    
    for( int i=0;i< columns.size();i++){
        Column col=(Column) columns.get(i);
        String colName= col.getName().toLowerCase();
        String colDesc=col.getDescription(locale);
        Column col2=col;
        if( col.getReferenceTable()!=null) {
            col2= col.getReferenceTable().getAlternateKey();
            colName =colName +"__"+ col2.getName().toLowerCase();
            colDesc += col2.getDescription(locale);
        }

        if( col.isModifiable(Column.ADD)){
        	if( col.getValues(locale) !=null && !col.isNullable()){
                out.println(" if(!checkSelectedArray(form."+colName+",\""+colDesc+"\")) return false;");
            }else{
                    switch( col2.getType()){
                        case Column.DATE:
                            out.println(" if(!checkIsDateArray(form."+colName+",\""+colDesc+"\", "+ col.isNullable() +")) return false;");
                            break;
                        case Column.DATENUMBER:
                            out.println(" if(!checkIsDateArray(form."+colName+",\""+colDesc+"\", "+ col.isNullable() +")) return false;");
                            break;
                        case Column.NUMBER:
                            if(col.getLimit() != null && col.getLimit().toLowerCase().compareTo("pz") == 0)
                                out.println(" if(!checkPzNumberArray(form."+colName+",\""+colDesc+"\", "+ col.isNullable() +")) return false;");
                            else if(col.getLimit() != null && col.getLimit().toLowerCase().compareTo("paz") == 0)
                                out.println(" if(!checkPazNumberArray(form."+colName+",\""+colDesc+"\", "+ col.isNullable() +")) return false;");
                            else
                                out.println(" if(!checkIsNumberArray(form."+colName+",\""+colDesc+"\", "+ col.isNullable() +")) return false;");
                            break;
                         case Column.STRING:
                         	if (!col.isNullable()){
                         		out.println(" if(!checkNullableArray(form."+colName+",\""+colDesc+"\", "+ col.isNullable() +")) return false;");
                         	}
                    }
            }
        }
    }
    
   %>
   return true;
}


  
</script>

