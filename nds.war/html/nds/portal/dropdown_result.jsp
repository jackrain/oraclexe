<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%!
	private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("dropdown_result_jsp");
%>

<%
    /**
     *  The things this page will use are
     *      1. "result" (QueryResult) attribute in HttpServletRequest
     *      1.1 "userExpr" (Expression) attribute in HttpServletRequest
     *      2. "urls"   (Hashtable) attribute in HttpServletRequest,
     *              key: columnIdx( start from 1, max is the display columns count)
     *                      if has columnIdx =0, that's for the mainTable record Id
     *              value: url( String, like: "/basicinfo/employee.jsp", must start from "/"
     *                     and root to ContextPath
     *  3. "return_type" can be "s" (single line of selected row)or "m"(multiple line of rows), or "n" (default) nothing will be return
     *  4. "accepter_id" the input box's id in window
     *  5.
     *     "multi_select" (Hashtable)attribute in HttpServletRequest
     *            if exists, will show form with param in multi_select:
     *                  htAtt.put("select_form", "form_list");
     *             		htAtt.put("next-screen",contextPath+"/objext/sheet_list.jsp?table="+ table.getName());
     *             		htAtt.put("command", "unknown");
     *             		htAtt.put("table", table.getId());
     *            will show checkbox in first column for selection
     *    (each row's id will be set in hidden input named "itemid", and checkbox will be named "selectedItemIdx"
     *    @see nds.control.event.DefaultWebEvent#getParameterValues
     *    (added by yfzhu at 2003-03-01 for MR POS-66 (批量提交、删除功能)
     *
     *  6. "status" (String but int value) in HttpRequest.attribute, means search range
     *  7. "query_page" if "sheet_list", the query page should be directed to "sheet_query.jsp",
     *                      else, just direct to "query.jsp";
     *
     *  9.  "small_page" in attribute, string- default to "true",or nothing, if true, will not display navigate bar in both up and down place
     *  10.    column      - the column id that will shown as dropdown list
     */
%>
<%!
    private final static int SELECT_NONE=1;
    private final static int SELECT_SINGLE=2;
    private final static int SELECT_MULTIPLE=3;

	private final static int MAX_COLUMNLENGTH_WHEN_TOO_LONG=30;//QueryUtils.MAX_COLUMN_CHARS -3
	private final static String[] LIST_ACCESS_KEY=new String[]{"1","2","3","4","5","6","7","8","9","0","!","@","#","$","%","^","&","*","(",")"};
	/**
	* if s.length()> maxLength, return it's first maxLength chars, else, return full
	*/
	private String getStringOfLimitLength(String s, int maxLength){
		return ( s.length()> maxLength)?s.substring(0,maxLength-1):s;
	}
    /**
     * Encode sql to html valid string, will be put into <input> tag
     */
    private String encode(String sql){
        String s=  nds.util.StringUtils.replace(sql,"\"", "\\\"");
//        s= nds.util.StringUtils.escapeHTMLTags(s);
        return s;
    }
%>
<%
    boolean isSmallPage=ParamUtils.getBooleanAttribute(request,"small_page",true);
    String return_type= request.getParameter("return_type");
    
    if( return_type==null || "".equals(return_type)) return_type="n";
    int returnType=1;// 1, no return, 3 mulitple(not supported yet), 3 single
    if( "n".equalsIgnoreCase(return_type)) returnType=SELECT_NONE;
    else if("s".equalsIgnoreCase(return_type)) returnType=SELECT_SINGLE;
    else if("m".equalsIgnoreCase(return_type)) returnType=SELECT_MULTIPLE;
    String accepter_id= request.getParameter("accepter_id");
    if("".equals(accepter_id) || "null".equalsIgnoreCase(accepter_id)) accepter_id=null;
	Column acceptorColumn=  TableManager.getInstance().getColumn(Tools.getInt(request.getParameter("column"),-1));
 	if(acceptorColumn==null)acceptorColumn= QueryUtils.getReturnColumn(accepter_id);
    
    
    String form1="fm_"+accepter_id;
    

    String query_page=(String) request.getAttribute("query_page");
    Object objRs=request.getAttribute("result");
    QueryResult result =null;
    if( objRs instanceof QueryResult){
        result= (QueryResult)objRs;
    }
    QueryRequest qRequest ;
    if(result == null){
        qRequest=(QueryRequestImpl)  request.getAttribute("query");
        if ( qRequest ==null){
            out.println("Internal Error: Can not find Query Result Set Object");
            return;
        }
		/*  加载安全过滤器 
		SessionContextManager scmanager= WebUtils.getSessionContextManager(session);
		UserWebImpl usr=(UserWebImpl)scmanager.getActor(nds.util.WebKeys.USER);
		Expression sexpr= usr.getSecurityFilter(qRequest.getMainTable().getName(), 1);// read permission
		//logger.debug("before:"+ qRequest.getParamExpression());
		((QueryRequestImpl)qRequest).addParam(sexpr);
		//logger.debug("after:"+ qRequest.getParamExpression());
        */
		//logger.debug("ffff:"+ qRequest.getParamExpression());
        result= QueryEngine.getInstance().doQuery(qRequest);
    }else{
        qRequest = result.getQueryRequest();
    }
	//logger.debug("qRequest====="+ qRequest.hashCode()+", result========="+ result.hashCode());
    
    //logger.debug("eeeee:"+ qRequest.getParamExpression());
    //System.out.println("[inc_result.jsp] "+ qRequest.toSQL()); 
    Hashtable urls= (Hashtable)request.getAttribute("urls");
    if( urls ==null) urls=new Hashtable();
    TableManager manager= TableManager.getInstance();


    Hashtable htMultiSelect= (Hashtable)request.getAttribute("multi_select");

    if (htMultiSelect ==null && returnType==SELECT_MULTIPLE){
        // multiple selection, and return
        htMultiSelect= new Hashtable();
        htMultiSelect.put("select_form", "form_list");
        htMultiSelect.put("table", ""+qRequest.getMainTable().getId());
    }
    // htMultiSelect !=null 表示返回值将被用于传递到后台服务器处理，如批量提交和删除
    // returnType==SELECT_MULTIPLE 表示返回值直接在几个页面间传递，如多重选择
    boolean isMultiSelectEnabled= (htMultiSelect !=null) || returnType==SELECT_MULTIPLE;
    //用于表示为查询时返回多个结果、或查询语句
    boolean isQueryMultiSelectEnabled= ( returnType==SELECT_MULTIPLE &&  accepter_id!=null && accepter_id.trim().length() >0 );

    int status= ParamUtils.getIntAttributeOrParameter(request, "status", -1);// default to 1 that means draft
    boolean isStatusEnabled= (status != -1);



  int range = qRequest.getRange();

  int[] selectRanges= QueryUtils.SELECT_RANGES;

  String[] showColumns = qRequest.getDisplayColumnNames(false);
  //Hawke begi
  boolean isIe = (request.getHeader("User-Agent").indexOf("MSIE") >= 0 )?true:false;
  String orderColumns = "";
  if(qRequest.getOrderColumnLink()!=null)for(int i=0;i< qRequest.getOrderColumnLink().length;i++)
  {
    if(i > 0)orderColumns += ",";
    orderColumns += qRequest.getOrderColumnLink()[i];
  }
  String orderAsc = "";
  if(qRequest.isAscendingOrder())
    orderAsc = "true";
  else
    orderAsc = "false";
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
  //Hawke end


  int count = result.getRowCount();
  int totalCount = result.getTotalRowCount();
  int startIndex = qRequest.getStartRowIndex()+1;// 0 is the begin
  int endIndex = startIndex + qRequest.getRange()-1;
  endIndex = (endIndex > totalCount)?totalCount:endIndex;
  if(startIndex > totalCount){startIndex=0;endIndex=0;}
  String inc_table_id="inc_table_"+ System.currentTimeMillis();
  int divHeight=(count== 0 ?40:(count>15?320:count*20+20));
%>

<div id="<%="tdv_"+accepter_id%>" style="height:<%=divHeight%>px;position: relative; z-index: 11;overflow-y: scroll; overflow-x:visible;padding:0px"> 
<%
CollectionValueHashtable tableAlertHolder=new CollectionValueHashtable();
%>
<table id="<%="table_"+accepter_id%>" border="0" cellspacing="0" cellpadding="0" align="center" onselectstart="if(window.event.ctrlKey || window.event.shiftKey) return false;else return true;">
		              
              <%
              if(result.getRowCount() == 0){

              %>
              <tr class="even-row">
                      <td align="center" colspan="<%=showColumns.length%>">
                      <%= PortletUtils.getMessage(pageContext, "no-data",null)%>
                      </td>
              </tr>
              <%
              }
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

                    
                    String ifmTmp = (isIe)?"ifm=true&":"";
                    //String queryPath= contextPath+"/servlets/viewObject?"+ifmTmp+"table=";//Hawke
                    String queryPath= NDS_PATH+"/object/object.jsp?input=false&table=";//Hawke
                    String mainTablePath=(String)urls.get(new Integer(0));
                    int pkId= qRequest.getMainTable().getPrimaryKey().getId();
                    int akId= -1;
                    boolean mainTablePathChanged=false;
                    boolean mainTablePathIsFunction=false;
                    if(qRequest.getMainTable().getAlternateKey() !=null)
                        akId=qRequest.getMainTable().getAlternateKey().getId();
                    if( mainTablePath ==null){
                    	mainTablePath= queryPath+qRequest.getMainTable().getId()+"&id=";
                    }else{
                    	// add support for funcation input, format like: javascript:new_dialog(:ID)
                    	mainTablePathIsFunction=( mainTablePath.indexOf("javascript:")>-1);
                        if(!mainTablePathIsFunction) 
                        	mainTablePath =contextPath+ mainTablePath+ "&id=";
                        mainTablePathChanged=true;
                    }

                    int serialno=startIndex -1, currentId; 
                    boolean whiteBg= false;
                    int counter=0;
                    String accessKeyAttribute;
                    Object tmpAKValue;
                    String akData;
                   while(result.next()){
                   		if(serialno%1==0) whiteBg = (whiteBg==false);
                        serialno ++;
                        counter++;
                        String itemId = "-1";
                  %>
              <tr height=20 id='tr_<%=serialno%>' class='<%=(whiteBg?"even-row":"odd-row")%>'>
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
                            String s=(String)urls.get(new Integer(i+1)) ;
                            if( s!=null) {
                                url= contextPath+ s+"?id="+objId;
                            }else{
                                url=queryPath+ colmn.getTable().getId() +"&id="+objId;
                            }
                        }
                        if( objId != -1){
                            if( colmn.getLength()>QueryUtils.MAX_COLUMN_CHARS && columnData.length()>MAX_COLUMNLENGTH_WHEN_TOO_LONG ){
                                columnData= "<a href='"+url+"'  title=\""+columnData+"\">"+getStringOfLimitLength(columnData,MAX_COLUMNLENGTH_WHEN_TOO_LONG)+"..."
                                    +"</a>";

                            }else{
                                columnData="<a href='"+url+"'>"+ columnData+"</a>";
                            }
                        }else{
							
                            if( colmn.getLength()>QueryUtils.MAX_COLUMN_CHARS && columnData.length()>MAX_COLUMNLENGTH_WHEN_TOO_LONG){
                                if( Tools.isHTMLAnchorTag(columnData)){
                                    // just return the columnData
                                }else{
                                    if(colmn.getId() == pkId && meta.getColumnLink(i+1).length()==1) {
                                        if(!mainTablePathIsFunction)
                                        	url= mainTablePath+columnData;
                                        else
                                        	url=mainTablePath.replaceAll(":ID",columnData);
                                        columnData= "<a href='"+url+"'>"+getStringOfLimitLength(columnData,MAX_COLUMNLENGTH_WHEN_TOO_LONG)+"...</a>";
                                        
                                    }else{
                                        columnData= "<a href='#' title=\""+columnData+"\">"+getStringOfLimitLength(columnData,MAX_COLUMNLENGTH_WHEN_TOO_LONG)+"...</a>";
                                    }
                                }
                            }else if(colmn.getId() == pkId && meta.getColumnLink(i+1).length()==1){
                                itemId = columnData;
                                resPkId = columnData;
                                columnData="";
                                tdAttributes="id='td_obj_"+ itemId + "'";
                                accessKeyAttribute=(counter<21?"accessKey='"+LIST_ACCESS_KEY[counter-1]+"'":"");
                                
                                if ( isMultiSelectEnabled == true ) {
                                	// add checkbox here
                                	columnData +="<input type='hidden' id='"+akData +"' name='itemid' value='" + itemId + "'  >";
                                	columnData +="<input class='cbx' type='checkbox' "+accessKeyAttribute+" id='chk_obj_"+  itemId +"' name='selectedItemIdx' value='" + (serialno-startIndex)+"' onclick=ajax_unselectall()>";

                                }else if( returnType==SELECT_SINGLE ){
                                
                                	columnData += "<input type='hidden' name='itemid' value='" + itemId + "'  >";
                                    columnData +="<input "+accessKeyAttribute+" class='cbx' type='radio' id='chk_obj_"+  itemId +"' name='selectedItemIdx' value='"+(serialno-startIndex)+"' onclick='ajax_close_popup(\""+ akData+"\")'>";
                                    tdAttributes +=" title=\""+ akData+"\"";
                                }
                                columnData +="&nbsp;";
                               /*if(!mainTablePathIsFunction)
                                	url=  mainTablePath+itemId;
                                else
                                	url=mainTablePath.replaceAll(":ID",itemId);
                               	columnData +="&nbsp;<a href='"+url+"'>"+ serialno+"</a>&nbsp;";
                               	*/
                               	
                            }
                        }
                        nds.web.alert.ColumnAlerter ca=(nds.web.alert.ColumnAlerter)colmn.getUIAlerter();
                        if(ca!=null){
                        	String rowCss=ca.getRowCssClass(result, i+1, colmn);
                        	if(nds.util.Validator.isNotNull(rowCss))tableAlertHolder.add("tr_"+serialno, rowCss);
                        }
                  %>
                <td height=20 nowrap align="<%=columnAligns[i]%>" <%=tdAttributes%>>
                  <%
                    out.print(columnData);
                  %>

                </td>
                <%
                    }// for循环
                  %>
              </tr>
              <%
		   }//while
                   %>
<tfoot>
<tr><td colspan="<%=showColumns.length%>" nowrap>
      <a href="javascript:DropdownQuery.reloadForm(document.<%=form1%>,'<%=accepter_id%>')"><img src="<%=NDS_PATH%>/images/tb_refresh.gif" align="absmiddle" border=0></a>
      <%if(qRequest.getMainTable().isActionEnabled(Table.ADD)){%>
      <a href="javascript:popup_window('<%=QueryUtils.getTableRowURL(qRequest.getMainTable())+"&action=input"%>')"><img src="<%=NDS_PATH%>/images/tb_new.gif" align="absmiddle" border=0></a>
      <%}%>
       <%/*if(qRequest.getMainTable().isMenuObject()){%>
      <a href="javascript:popup_window('<%=NDS_PATH+"/objext/objects.jsp?table="+(qRequest.getMainTable().getId())%>')"><img src="<%=NDS_PATH%>/images/open_folder.gif" align="absmiddle" border=0></a>
      <%}*/%>
      &nbsp;&nbsp;
      <%if(startIndex > 1){%>
      <a href="javaScript:DropdownQuery.reloadForm(document.<%=form1%>,'<%=accepter_id%>',1)"><img src="<%=NDS_PATH%>/images/begin.gif" align="absmiddle" border=0></a>
      <a href="javaScript:DropdownQuery.reloadForm(document.<%=form1%>,'<%=accepter_id%>',<%=((startIndex - range)<0?1:(startIndex-range))%>)"><img src="<%=NDS_PATH%>/images/back.gif" align="absmiddle" border=0></a>
      <%}else{%>
      <img src="<%=NDS_PATH%>/images/begin_gray.gif" align="absmiddle" border=0 > 
      <img src="<%=NDS_PATH%>/images/back_gray.gif" align="absmiddle" border=0>
      <%}
      if((endIndex)< totalCount){%>
      <a href="javaScript:DropdownQuery.reloadForm(document.<%=form1%>,'<%=accepter_id%>',<%=(startIndex+range)>totalCount?(totalCount-range): (startIndex+range)%>)"><img src="<%=NDS_PATH%>/images/next.gif" align="absmiddle" border=0></a>
      <a href="javaScript:DropdownQuery.reloadForm(document.<%=form1%>,'<%=accepter_id%>',<%=totalCount -count+1%>)"><img src="<%=NDS_PATH%>/images/end.gif" align="absmiddle" border=0></a>
      <%}else{%>
      <img src="<%=NDS_PATH%>/images/next_gray.gif" align="absmiddle" border=0> 
      <img src="<%=NDS_PATH%>/images/end_gray.gif" align="absmiddle" border=0>
      <%}%>			
</td></tr>
</tfoot>       
</table>     
</div>

<div id="justForNS" style="position:absolute; left:0px; top:0px; width:14px; height:1px; z-index:1; visibility: hidden">
<form name= "<%=form1%>" method="post" action="<%=contextPath+"/servlets/QueryInputHandler" %>">
<%
 	//filter
	/*Expression sexpr= userWeb.getSecurityFilter(qRequest.getMainTable().getName(), 1);// read permission
 	
 	Expression expr=QueryUtils.getDropdownFilter(acceptorColumn);
 	if( expr!=null ){
 		sexpr= expr.combine(sexpr, SQLCombination.SQL_AND, null);
 	};*/
 	Expression sexpr =(Expression) request.getAttribute("userExpr");
 	//logger.debug("userExpr:"+ sexpr);
    out.print(QueryUtils.toHTMLControlForm(qRequest, sexpr));
    //Hawke begin
    //解决查询中丢失accepter_id和return_type
    if(request.getParameter("accepter_id") != null)
      out.println("<input type=\"hidden\" name=\"accepter_id\" value=\""+request.getParameter("accepter_id")+"\">");
    if(request.getParameter("return_type") != null)
      out.println("<input type=\"hidden\" name=\"return_type\" value=\""+request.getParameter("return_type")+"\">");
    
%>
	<input type='hidden' name="quick_search_data" value="">
    <input type='hidden' name="quick_search_column" value="">
    <input type='hidden' name="quick_search" value="false">

</form>
</div>

