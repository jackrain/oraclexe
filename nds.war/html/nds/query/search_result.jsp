<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%!
	/**
	 Copied from nds/portal/table_result.jsp with following modifications:
	 	tr row id is xxx_qtemplaterow, not xxx_templaterow
	 	
	*/
    private final static int SELECT_NONE=1;
    private final static int SELECT_SINGLE=2;
    private final static int SELECT_MULTIPLE=3;
    private final static int MAX_COLUMNLENGTH_WHEN_TOO_LONG=30;//QueryUtils.MAX_COLUMN_CHARS -3
	/**
	* if s.length()> maxLength, return it's first maxLength chars, else, return full
	*/
	private String getStringOfLimitLength(String s, int maxLength){
		return ( s.length()> maxLength)?s.substring(0,maxLength-1):s;
	}
%>
<%
/**
  Fetch "result" from HttpRequest.Attribute, and construct result data
  This page is used for client to request server constructing query result html code directly
  @param jsonobject the original request json object for query
  @see AjaxController.query for more details
 */
 QueryResult result=(QueryResult) request.getAttribute("result");
 JSONObject jo=(JSONObject) request.getAttribute("jsonobject");
 if(result==null) {
 	out.print("No data");
 	return;
 }
 QueryRequest qRequest =result.getQueryRequest();
  TableManager manager= TableManager.getInstance();

  String rt=jo.optString("returnType");
  int returnType= ("n".equals(rt)?SELECT_NONE: ("s".equals(rt)?SELECT_SINGLE:SELECT_MULTIPLE));
  //boolean isMultiSelectEnabled= !"s".equals( jo.opt("returnType"));
  int range = qRequest.getRange();


  String[] showColumns = qRequest.getDisplayColumnNames(false);
  int[] showColumnsIds = qRequest.getDisplayColumnIndices();
  String[] showColumnLinks = new String[showColumns.length];
  for(int i =0;i < showColumns.length;i++)
  {
    int[] tmp = qRequest.getSelectionColumnLink(showColumnsIds[i]);
    showColumnLinks[i] = "";
    for(int j=0;j < tmp.length;j++)
    {
      if(j > 0) showColumnLinks[i] += ",";
      showColumnLinks[i] += tmp[j];
    }
  }

  int count = result.getRowCount();
  int totalCount = result.getTotalRowCount();
  int startIndex = qRequest.getStartRowIndex()+1;// 0 is the begin
  int endIndex = startIndex + qRequest.getRange()-1;
  endIndex = (endIndex > totalCount)?totalCount:endIndex;
  if(startIndex > totalCount){startIndex=0;endIndex=0;}
  CollectionValueHashtable tableAlertHolder=new CollectionValueHashtable();
    QueryResultMetaData meta=result.getMetaData();
  if(result.getRowCount() == 0){
    out.print("<tr style='display: none;'><td colspan='"+ (meta.getColumnCount()+1) +"'></td></tr>");
	return;
  }
    
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

    //String queryPath= contextPath+"/servlets/viewObject?table=";//Hawke
    String queryPath= NDS_PATH+"/object/object.jsp?input=false&table=";//Hawke
    int pkId= qRequest.getMainTable().getPrimaryKey().getId();
	
    int serialno=startIndex -1, currentId; 
    boolean whiteBg= false;
    
    Object tmpAKValue;
    String akData;
    int rowIdx=-1;
   while(result.next()){
   		if(serialno%1==0) whiteBg = (whiteBg==false);
   		rowIdx++;
        serialno ++;
        // first column is id
        String itemId = result.getObject(1).toString();
        
%>
<tr id='<%=itemId%>_qtemplaterow' class='<%=(whiteBg?"even-row":"odd-row")%>'>
<%
    String resPkId = null; 
    String tdAttributes;
    Column colmn;
    // get AK first
    tmpAKValue = result.getAKValue();
    if(tmpAKValue ==null)akData="";
    else akData = tmpAKValue.toString();
    
for(int i=0;i< meta.getColumnCount();i++){
	tdAttributes="";
    String columnData=result.getString(i+1, true);
    String originColumnData= result.getString(i+1, false);
    colmn=manager.getColumn(meta.getColumnId(i+1));
    if(colmn.getMoney() != null)
        columnData = StringUtils.displayMoney(originColumnData, colmn.getMoney());
    String url=null,tname = colmn.getTable().getDescription(locale);
    int objId= result.getObjectID(i+1);

    if(objId!=-1){
        url=queryPath+ colmn.getTable().getId() +"&id="+objId;
    }
    if( objId != -1){
        String aUrl = "'javascript:oq.fk("+colmn.getTable().getId()+","+objId+")'";
        if( colmn.getLength()>QueryUtils.MAX_COLUMN_CHARS && columnData.length()>MAX_COLUMNLENGTH_WHEN_TOO_LONG ){
            columnData= "<a href="+aUrl+" title=\""+columnData+"\">"+getStringOfLimitLength(columnData,MAX_COLUMNLENGTH_WHEN_TOO_LONG)+"..."
                +"</a>";

        }else{
            columnData="<a href="+aUrl+">"+ columnData+"</a>";
        }
    }else{

        if( colmn.getLength()>QueryUtils.MAX_COLUMN_CHARS && columnData.length()>MAX_COLUMNLENGTH_WHEN_TOO_LONG){
            if( Tools.isHTMLAnchorTag(columnData)){
                // just return the columnData
            }else{
                columnData= "<a href='#' title=\""+columnData+"\">"+getStringOfLimitLength(columnData,MAX_COLUMNLENGTH_WHEN_TOO_LONG)+"...</a>";
            }
        }else if(colmn.getId() == pkId && meta.getColumnLink(i+1).length()==1){
            itemId = columnData;
            resPkId = columnData;
            tdAttributes="";
           	switch(returnType){
           		case SELECT_MULTIPLE:
           			columnData ="<input class='cbx' id='"+akData+"' type='checkbox' name='itemid' value='" + (itemId)+"' onclick='oq.unselectall(this);oq.dynamic_add(\""+akData+"\");'>";
           			break;
           		case SELECT_SINGLE:
           			columnData ="<input class='cbx' id='chk_obj_"+  itemId +"'  title='"+rowIdx+"' alt='"+akData+"' type='radio' name='itemid' value='" + (itemId)+"' onclick='oq.returnRow(this)'>";
           			break;
           		case SELECT_NONE:
           			columnData="";
           	}
           	//if(isMultiSelectEnabled)columnData ="<input class='cbx' id='"+akData+"' type='checkbox' name='itemid' value='" + (itemId)+"' onclick='oq.unselectall();oq.dynamic_add(\""+akData+"\");'>";
           	//else columnData ="<input class='cbx' id='chk_obj_"+  itemId +"'  title='"+rowIdx+"' alt='"+akData+"' type='radio' name='itemid' value='" + (itemId)+"' onclick='oq.returnRow(this)'>";
           	columnData +="<a href='javascript:oq.mo(\""+itemId+"\")' >"+ serialno+"</a>";
        }
    }
    nds.web.alert.ColumnAlerter ca=(nds.web.alert.ColumnAlerter)colmn.getUIAlerter();
    if(ca!=null){
    	String rowCss=ca.getRowCssClass(result, i+1, colmn);
    	if(nds.util.Validator.isNotNull(rowCss ))tableAlertHolder.add(itemId, rowCss);
    }
  %>
<td nowrap align="<%=columnAligns[i]%>" width="<%= (int)(100* colmn.getLength()/ totalLength) %>%" <%=tdAttributes%>><%=columnData%></td>

<%
 }// for columns
%>
</tr>
<%
   }//end row iteration
%>
<script type="text/javascript">
<%
// change row class according to alert setting 
for(Iterator it=tableAlertHolder.keySet().iterator();it.hasNext();){
	Object rowKey=it.next();
%>
	$("<%=rowKey%>_qtemplaterow").addClassName("<%=Tools.toString(tableAlertHolder.get(rowKey), " ")%>");
<%	
}
%>
</script>

