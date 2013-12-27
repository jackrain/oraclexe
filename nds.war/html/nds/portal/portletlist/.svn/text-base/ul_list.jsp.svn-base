<%
/**
 if only one column displayed, will not add div to the element//13052221905
*/
try{
%>
<%@ include file="/html/nds/portal/portletlist/data_list.jsp" %>
<table class="<%=uiConfig.getCssClass()%>" border="0" cellpadding="0" cellspacing="0" width="95%" align="center">
<%if( uiConfig.isShowTitle()){%>
<tr><td><div class="<%=uiConfig.getCssClass()%>">
<%for(int i=1;i<showColumns.length;i++){// escape PK column
    String orderArrow = "";
    if(orderColumns.compareTo(showColumnLinks[i]) == 0){
        if(query.isAscendingOrder())
            orderArrow = "<img src='"+ NDS_PATH+"/images/upsimple.png' border=0 width=8 height=7>";
        else
            orderArrow =  "<img src='"+ NDS_PATH+"/images/downsimple.png' border=0 width=8 height=7>";
    }
    %>
   <div class="ulheaddiv" onClick="javascript:ptc.reOrder('<%=namespace%>','<%=showColumnLinks[i]%>')">
   		<span name="<%=showColumnLinks[i]%>"><%=showColumns[i]+orderArrow%> </span>
  </div>
  <%}%>
</div></td></tr>
<%}//end uiConfig.isShowTitle()
%>
<tr><td><ul class="<%=uiConfig.getCssClass()%>">
<%
if(result.getRowCount() == 0){
%>
  <li class="even-row">
      <%= PortletUtils.getMessage(pageContext, "no-data",null)%>
  </li>
  <%
}// end getRowCount=0
    QueryResultMetaData meta=result.getMetaData();
    
    int totalLength =10;// serial no length
    String[] columnAligns= new String[meta.getColumnCount()]; //  left, center,  right
    int type;
    for( int i=0;i< meta.getColumnCount();i++){
        Column colmn=manager.getColumn(meta.getColumnId(i+1));
        totalLength += colmn.getLength();
        type= colmn.getType();
        columnAligns[i]= (( type== Column.DATE)? "left": (type== Column.NUMBER)? "right":"left");
    }
    // alway align first column ( always the object id) to left
    columnAligns[0]= "left";
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
    boolean showDiv=(meta.getColumnCount()>2);
   while(result.next()){
   		//if(serialno%5==0) whiteBg = (whiteBg==false);
   		whiteBg = (whiteBg==false);
        serialno ++;
        String itemId = "-1";
      %>
  <li id='<%=namespace%>li_<%=serialno%>' class='<%=(whiteBg?"even-row":"odd-row")%>'>
    <%
        String resPkId = null;
        String tdAttributes;
        Column colmn;
        pkValue= Tools.getInt(result.getObject(1),-1);
        String columnDataShort;
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
            if(uiConfig.getColumnLength()!=null){
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
            	if(nds.util.Validator.isNotNull(rowCss ))tableAlertHolder.add(namespace+"li_"+serialno, rowCss);
            }
            if(showDiv){
      %>
			    <div class="lidiv_<%=i%>">
			      <%=columnData%>
				</div>	
			<%}else{%>
				<%=columnData%>
			<%}
        }// forÑ­»·
      %>
  </li>
  <%
}//while
%>
</ul></td></tr>
<%
	// more link
	if(!"NONE".equals(uiConfig.getMoreStyle())  && !"TITLE".equals(uiConfig.getMoreStyle())  ){
		String moreURL= uiConfig.getMoreURL();
		if(nds.util.Validator.isNull(moreURL)){
			moreURL=portletDisplay.getURLMax();
		}
		String cls="text-more";
		if("TEXT_RIGHT".equals(uiConfig.getMoreStyle())) cls="text-more-right";
%>
<tr><td><div class="<%=cls%>"><a class="action" href="<%=moreURL%>"><%=LanguageUtil.get(pageContext, "text-more")%></a></div></td></tr>
<%				
	}
%>
<script type="text/javascript">
<%
for(Iterator it=tableAlertHolder.keySet().iterator();it.hasNext();){
	Object rowKey=it.next();
%>
	document.getElementById("<%=rowKey%>").className="<%=Tools.toString(tableAlertHolder.get(rowKey), " ")%>";
<%	
}
%>
</script>
</table>
<%
}catch(Exception expd){
	expd.printStackTrace();
%>
<p><font color='red'><%= MessagesHolder.getInstance().translateMessage(expd.getMessage(),locale)%></font>
<%	
}
%>
	
