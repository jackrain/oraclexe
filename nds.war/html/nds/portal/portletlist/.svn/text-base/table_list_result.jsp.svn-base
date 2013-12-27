<%
    QueryResultMetaData meta=result.getMetaData();
    String[] columnAligns= new String[meta.getColumnCount()]; //  left, center,  right
    int type;
    int totalLength =10;// serial no length
    for( int i=0;i< meta.getColumnCount();i++){
        Column colmn=manager.getColumn(meta.getColumnId(i+1));
        totalLength += colmn.getLength();
        type= colmn.getType();
        columnAligns[i]= (( type== Column.DATE)? "left": (type== Column.NUMBER)? "right":"left");
    }
    // alway align first column ( always the object id) to left
    columnAligns[0]= "left";
%>

<table id="<%=namespace%>inc_table" width="99%" class="<%=uiConfig.getCssClass()%>">
<%if( uiConfig.isShowTitle()){%>
  <thead>
  <tr>
      <%for(int i=1;i<showColumns.length;i++){// escape PK column
        String orderArrow = "";
        if(orderColumns.compareTo(showColumnLinks[i]) == 0){
            if(query.isAscendingOrder())
                orderArrow = "<img src='"+ NDS_PATH+"/images/upsimple.png' border=0 width=8 height=7>";
            else
                orderArrow =  "<img src='"+ NDS_PATH+"/images/downsimple.png' border=0 width=8 height=7>";
        }
        %>
       <td align="<%=columnAligns[i]%>" onClick="javascript:ptc.reOrder('<%=namespace%>','<%=showColumnLinks[i]%>')">
       	<span name="<%=showColumnLinks[i]%>"><%=showColumns[i]+orderArrow%> </span>
      </td>
      <%}%>
  </tr>
  </thead>
<%}//end show title
if(result.getRowCount() == 0){
%>
  <tr class="even-row">
      <td colspan="<%=showColumns.length-1%>">
      <%= PortletUtils.getMessage(pageContext, "no-data",null)%>
      </td>
  </tr>
  <%
}// end getRowCount=0
    
    String queryPath= NDS_PATH+"/sheet/object.jsp?input=false&table=";
    String mainTablePath= dataConfig.getMainURL();
    String mainTarget=dataConfig.getMainTarget();
    if(mainTarget==null)mainTarget="_blank";
    int pkId= query.getMainTable().getPrimaryKey().getId();
    int akId=query.getMainTable().getAlternateKey().getId();
    if( mainTablePath ==null){
    	mainTablePath= queryPath+query.getMainTable().getId()+"&id=@ID@";
    }

    int serialno=startIndex -1, currentId; 
    boolean whiteBg= false;
    
    int pkValue;
   while(result.next()){
   		//if(serialno%5==0) whiteBg = (whiteBg==false);
   		whiteBg = (whiteBg==false);
        serialno ++;
        String itemId = "-1";
      %>
  <tr id='<%=namespace%>tr_<%=serialno%>' class='<%=(whiteBg?"even-row":"odd-row")%>'>
    <%
        String resPkId = null;
        String tdAttributes;
        Column colmn;
        String columnDataShort;
        pkValue= Tools.getInt(result.getObject(1),-1);
        for(int i=1;i< meta.getColumnCount();i++){ // first column should always be PK
			tdAttributes="";
            String columnData=result.getString(i+1, true);
            String originColumnData= result.getString(i+1, false);
            colmn=manager.getColumn(meta.getColumnId(i+1));
            String url=null;
            int objId= result.getObjectID(i+1);
			String target=null;
            if(objId!=-1){
                String s=(String)urls.get(new Integer(i+1)) ;
                if( s!=null) {
                    url= contextPath+ s+"?id="+objId;
                }else{
                    url=queryPath+ colmn.getTable().getId() +"&id="+objId;
                }
                url="javascript:showObject(\""+url+"\")";
            }
            if(i==1){
            	// alway set first column to PK url
            	objId=pkValue;
            	url= mainTablePath.replaceAll("@ID@",String.valueOf(pkValue));
            	tdAttributes="id='td_obj_"+ pkValue + "'";
            	if("_popup".equals(mainTarget))
            		url="javascript:showObject(\""+url+"\")";
            	else
            		target=mainTarget;
            }
            //Tools.isHTMLAnchorTag(columnData)
            if(uiConfig.getColumnLength()!=null && uiConfig.getColumnLength().length>=i){
				columnDataShort= StringUtils.shortenInBytes(columnData, uiConfig.getColumnLength()[i-1]);
            }else{
            	columnDataShort= StringUtils.shortenInBytes(columnData, MAX_COLUMNLENGTH_WHEN_TOO_LONG);
            }
            if(url!=null) columnData="<a "+ 
            	(columnDataShort.length()==columnData.length()?"": "title='"+columnData+"' ")
            	+(target==null?"":"target='"+target+"' ") +"href='"+ url+"'>"+ columnDataShort + "</a>";
            nds.web.alert.ColumnAlerter ca=(nds.web.alert.ColumnAlerter)colmn.getUIAlerter();
            if(ca!=null){
            	String rowCss=ca.getRowCssClass(result, i+1, colmn);
            	if(nds.util.Validator.isNotNull(rowCss ))tableAlertHolder.add(namespace+"tr_"+serialno, rowCss);
            }
      %>
    <td <%=(i==1?"class=\"first-td\"":"")%> nowrap align="<%=columnAligns[i]%>" width="<%= (int)(100* colmn.getLength()/ totalLength) %>%" <%=tdAttributes%>>
      <%=columnData%>
    </td>
    <%
        }// forÑ­»·
      %>
  </tr>
  <%
}//while
%>
</table>
<script type="text/javascript">
<%
for(Iterator it=tableAlertHolder.keySet().iterator();it.hasNext();){
	Object rowKey=it.next();
%>
	document.getElementById("<%=rowKey%>").className="<%=Tools.toString(tableAlertHolder.get(rowKey), " ")%>";
<%	
}
%>
</script><!--
<div id="<%=namespace%>result-filter-desc">
     <font color='red'>*</font><%= PortletUtils.getMessage(pageContext, "current-filter",null)%>:
     <span class="sqldesc">
     <%if(query.getParamDesc(true).trim().equals("")){%>
    	<%= PortletUtils.getMessage(pageContext, "none",null)%>
     <%}else{%>
     	<%=query.getParamDesc(true).trim()%>
     <%}%>
     </span>
</div>-->
<%
if(count!=totalCount){
%>
<div id="<%=namespace%>result-scroll" class="linkbtn">
 <%@ include file="/html/nds/portal/portletlist/inc_result_scroll.jsp" %>
</div>
<%
}//end count!=totalCount	
%>
<div class="hidden-form">
	<form id="<%=namespace%>list_form" target="_blank" method="post" action="/servlets/QueryInputHandler">
		<input type='hidden' name="namespace" value="<%=namespace%>">
		<input type='hidden' name="listdataconf" value="<%=dataconf%>">
		<input type='hidden' name="listuiconf" value="<%=uiconf%>">
		<input type='hidden' id="<%=namespace%>quick_search_filterid" name="quick_search_filterid" value=''>
		<input type='hidden' id="<%=namespace%>quick_search_data" name="quick_search_data" value="">
	    <input type='hidden' id="<%=namespace%>quick_search_column" name="quick_search_column" value="">
	    <input type='hidden' id="<%=namespace%>quick_search" name="quick_search" value="false">
	<%
	    out.print(QueryUtils.toHTMLControlForm(query, (Expression)request.getAttribute("userExpr"), namespace));
	%>
	
	</form>
	<input type='hidden' id="<%=namespace%>list_form_totalrowcount" name="list_form_totalrowcount" value="<%=totalCount%>">
</div>     

