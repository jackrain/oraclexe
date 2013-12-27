<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>

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
     * 10.  "one_page" in attribute, string- default to "false",or nothing, if false, will not allow sort on table head, and change page size
     */
%>
<%!
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
	boolean isOnePage=ParamUtils.getBooleanAttribute(request,"one_page",false);
    
    String return_type= request.getParameter("return_type");
    if( return_type==null || "".equals(return_type)) return_type="n";
    int returnType=1;// 1, no return, 3 mulitple(not supported yet), 3 single
    if( "n".equalsIgnoreCase(return_type)) returnType=SELECT_NONE;
    else if("s".equalsIgnoreCase(return_type)) returnType=SELECT_SINGLE;
    else if("m".equalsIgnoreCase(return_type)) returnType=SELECT_MULTIPLE;
    String accepter_id= request.getParameter("accepter_id");
    if("".equals(accepter_id) || "null".equalsIgnoreCase(accepter_id)) accepter_id=null;
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
		/*  加载安全过滤器 */
		SessionContextManager scmanager= WebUtils.getSessionContextManager(session);
		UserWebImpl usr=(UserWebImpl)scmanager.getActor(nds.util.WebKeys.USER);
		Expression sexpr= usr.getSecurityFilter(qRequest.getMainTable().getName(), 1);// read permission
		((QueryRequestImpl)qRequest).addParam(sexpr);
		/*  加载安全过滤器 */
        // 强行加载
        
        result= QueryEngine.getInstance().doQuery(qRequest);
    }else{
        qRequest = result.getQueryRequest();
    }
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
  String inc_table_id="modify_table";//"inc_table_"+ System.currentTimeMillis();
%>

 <Script language="javascript">
function unselectall()
{
    if(document.getElementById("myCheckBoxAll")==null ) return;
    if( document.getElementById("myCheckBoxAll").checked){
		document.getElementById("myCheckBoxAll").checked = document.getElementById("myCheckBoxAll").checked&0;
    }
}

function selectall(theForm)
{
    var length = <%=count%>;
    document.getElementById("myCheckBoxAll").checked = document.getElementById("myCheckBoxAll").checked|0;

    if (length == 0 ){
          return;
    }
    if (length ==1 )
    {
       theForm.selectedItemIdx.checked=document.getElementById("myCheckBoxAll").checked ;
    }

    if (length>1)
    {
      for (var i = 0; i < length; i++)
       {
        theForm.selectedItemIdx[i].checked=document.getElementById("myCheckBoxAll").checked;
       }
    }

}
  function changeRange(range){
  	 doSubmit(document.form1, <%=startIndex%>,range);
  }
  function doSubmit(form, start,range){
   form.range.value=range;
   form.start.value=start;
   form.submit();
  }
  function setIndex(form,index){
    form.start.value=index;
    form.submit();

  }
  function refresh(form){
    form.submit();
  }
  function showFullSubTotal(form, ck){
  	if( ck | 0 == true){
  		form.fullrange_subtotal.value='true';
  	}else{
  		form.fullrange_subtotal.value='false';
  	}
  	form.submit();
  }
  function refreshPage(){
    document.form1.submit();
  }
  <%
    String internal_frame="ifm_"+System.currentTimeMillis();// the internal frame at last line
  %>
    function showObject(url,tname){
        var win;
        win= window.parent;
        if(win==null) win=window.top;
       	if (win.mainFrame!=null){
           	win.mainFrame.location=url;
           	try{
           		if(win.module.cols== "*,1"){
           			win.module.cols="*,<%=DEFAULT_TAB_WIDTH+40%>";
           		}
           	}catch(ex){}
        }else{
           	if(win==window) window.location=url;
           	else popup_window(url);
        }
    }
    //Hawke begin
    function layer(){
	var floatLayer = document.getElementById('floater');
	if(floatLayer.style.display == 'none')
		floatLayer.style.display='block';
	else
		floatLayer.style.display='none';
    }
    function viewLayer(){
        var floatLayer = document.getElementById('floater');
        floatLayer.style.display='block';
        ScrollToView();
        //ScrollToView();
    }
    function changeControlValue(control, value){
        control.value = value;
    }
    function reOrder(formName,columnValue){
        if(formName.elements["order/columns"].value == columnValue){
            if(formName.elements["order/asc"].value == 'true')
                formName.elements["order/asc"].value = 'false';
            else
                formName.elements["order/asc"].value = 'true';
        }else{
            formName.elements["order/columns"].value = columnValue;
            formName.elements["order/asc"].value = 'true';
        }
        setIndex(formName,1);
    }
    function createReport(form){
		var oldResultHanlder=form.resulthandler.value;
        changeControlValue(form.resulthandler,"<%=NDS_PATH%>/reports/create_report.jsp");
        
        form.submit();
        form.resulthandler.value=oldResultHanlder;
    }
    function createCxtabReport(form){
		var oldResultHanlder=form.resulthandler.value;
        changeControlValue(form.resulthandler,"<%=NDS_PATH%>/cxtab/create_cxtabrpt.jsp");
        form.submit();
        form.resulthandler.value=oldResultHanlder;
    }
    function createReport2(form,handlerURL ){
		var oldResultHanlder=form.resulthandler.value;
        changeControlValue(form.resulthandler,handlerURL);
        
        form.submit();
        form.resulthandler.value=oldResultHanlder;
    }
    function doExportSMS(){
    	var form=document.form1;
    	var oldTarget=form.target;
		if (window.top.mainFrame!=null){
            form.target="mainFrame";
         }else{
            form.target="_self";
        }    
    	createReport2(form, "<%=NDS_PATH%>/reports/create_sms_report.jsp");
    	form.target=oldTarget;
    }
    function doUpdate(){
    	var form=document.form1;
    	var oldTarget=form.target;
		if (window.top.mainFrame!=null){
            form.target="mainFrame";
         }else{
            form.target="_self";
        }    
		var oldResultHanlder=form.resulthandler.value;
        changeControlValue(form.resulthandler,"<%=NDS_PATH%>/objext/batchupdate.jsp");
        
        form.submit();
        form.resulthandler.value=oldResultHanlder;
    	form.target=oldTarget;
    }
    function doExport(){
    	var form=document.form1;
    	var oldTarget=form.target;
		if (window.top.mainFrame!=null){
            form.target="mainFrame";
         }else{
            form.target="_self";
        }    
    	createReport(form);
    	form.target=oldTarget;
    }
    function doCxtabReport(){
    	var form=document.form1;
    	var oldTarget=form.target;
		if (window.top.mainFrame!=null){
            form.target="mainFrame";
         }else{
            form.target="_self";
        }    
    	createCxtabReport(form);
    	form.target=oldTarget;
    }
    function printDocument(form){
    	var oldTarget=form.target;
		if (window.top.mainFrame!=null){
            form.target="mainFrame";
         }else{
            form.target="_self";
        }    
        s=form.resulthandler.value;
        changeControlValue(form.resulthandler,"<%=NDS_PATH%>/print/options.jsp");
        form.submit();
        form.target= oldTarget;
        changeControlValue(form.resulthandler,s);
    }

<%
    if( accepter_id !=null){
%>
  function close_popup(return_string){
    // return_string is the ak, pkData is the pk id
    if(typeof(window.opener.name)!='unknown'){
           var e=window.opener.document.getElementById("<%=accepter_id%>");
           if (e==null) e=window.opener.document.<%=accepter_id%>;
           if(e==null){
           		alert("Internal error: accepter could not be found");
           		return false;
           }
           e.value=return_string;
           window.close();
    }else{
	       self.close();
    }
    return true;
  }
<%
}// end if accepter_id !=null
 if(isQueryMultiSelectEnabled){
     // 返回多个查询值或查询语句
%>
    
  function close_multiSelect(form){
    var sql,sqlDesc;
    sql = "" ;
    sqlDesc = "<%= PortletUtils.getMessage(pageContext, "contain",null)%>(";
    
    if(typeof(window.opener.name)!='unknown'){
    	
        var selectedIdx = getSelectedItemIdx();
        if (selectedIdx==null || selectedIdx.length ==0) {
            alert("<%= PortletUtils.getMessage(pageContext, "please-check-selected-lines",null)%>");
            return false;
        }
        var itemIdObjs=document.all.item("itemid");
        var itemIdObj;
        if (itemIdObjs.length ==null){
            // only one item found, and selected
            itemIdObj=itemIdObjs;
            sql= sql +  itemIdObj.value;
            sqlDesc=sqlDesc +itemIdObj.id;
        }else{
            for(i=0;i< selectedIdx.length;i++){
            	itemIdObj= itemIdObjs[selectedIdx[i]];
            	if(i!=0){ sql =sql + ","; sqlDesc =sqlDesc+",";}
            	sql = sql + itemIdObj.value;
            	sqlDesc=sqlDesc + itemIdObj.id;
            }
	}
        sqlDesc =  sqlDesc + ")";
        setOpenerParam(sql, sqlDesc);
        
    }else{
        self.close();
    }
    
    return true;
  }
  function close_sql(){
      var sql,sqlDesc,sqlExpr;
      if(typeof(window.opener.name)!='unknown'){
          sql="<%=encode( qRequest.toPKIDSQL(false))%>";
          sqlDesc="<%=encode(qRequest.getParamDesc(false))%>";
          if(document.form1.param_expr==null) sqlExpr="";
          else sqlExpr=document.form1.param_expr.value;
          setOpenerParam(sql, sqlDesc,sqlExpr);
      }else{
          self.close();
      }
      return true;
  }
  function setOpenerParam(sql, sqlDesc, sqlExpr){
 <%
    // since accepter has format like "form.objectid", while _link / _desc are not form element,
    // we will try to figer out objectid only
    // opener object may has two type accepter: one who recieved sql( in query.jsp), one who recieved expression( in security/sql_filter.jsp)
    String accepter_id_object= accepter_id.substring(accepter_id.indexOf(".")+1);
 %>
      window.opener.document.all.item("<%=accepter_id_object+ "_link"%>").name="clear"; // reset to popup
      window.opener.document.all.item("<%=accepter_id_object+"_img"%>").src="<%=NDS_PATH%>/images/clear.gif";
      window.opener.document.all.item("<%=accepter_id_object+"_img"%>").alt="<%= PortletUtils.getMessage(pageContext, "clear-current-condition-setting",null)%>";
      window.opener.document.all.item("<%=accepter_id_object%>").value=sqlDesc;
      //window.opener.document.all.item("<%=accepter_id_object%>").readOnly =true;
      //window.opener.document.all.item("<%=accepter_id_object%>").style.borderWidth="0px 0px 0px";
      //window.opener.document.all.item("<%=accepter_id_object%>").style.backgroundColor='beige';
      var obj=window.opener.document.all.item("<%=accepter_id_object+"_expr"%>") ;
      if( obj !=null){
      	  obj.value= sqlExpr;
      }
      obj=window.opener.document.all.item("<%=accepter_id_object+"_sql"%>");
      if( obj !=null){
      	  obj.value=" IN ("+sql+ ")";
      }

      window.close();
  }
<%} // if(isQueryMultiSelectEnabled)end
%>
</script>
<%
  // add button for selection multple rows or just return sql
  if ( isQueryMultiSelectEnabled ){
%>
   <input class="command6_button" type='button' name='MultiSelect'  value='<%= PortletUtils.getMessage(pageContext, "return-value",null)%>' onclick="javascript:close_multiSelect(<%=htMultiSelect.get("select_form")%>)" >
   <input class="command6_button" type='button' name='ReturnSelect' value='<%= PortletUtils.getMessage(pageContext, "return-sql",null)%>' onclick="javascript:close_sql()" >

<%
  }
%>
<% if (isMultiSelectEnabled == false ) {
	// when mulitselect is enabled ,the outside should create a form
%>
	<form name="noUseButForNS">
<% } %>

<table border="0" width="98%" align="center" cellspacing="0" cellpadding="0" >
  <tr valign="bottom">
    <td nowrap>
    <% if ( isMultiSelectEnabled && count > 0) { %>
    	<input type="checkbox" name="myCheckBoxAll" id="myCheckBoxAll" value=1 onclick=selectall(<%=htMultiSelect.get("select_form")%>)> <%= PortletUtils.getMessage(pageContext, "select-all",null)%>
    <% }%>

     <%  if (qRequest.getMainTable().isSubTotalEnabled() ){ %>
      <input type="checkbox" name="ckbox_FullRangeSubTotal" value='1' <%=qRequest.isFullRangeSubTotalEnabled()?"checked":""%> onclick="javascript:showFullSubTotal(document.form1, ckbox_FullRangeSubTotal.checked)"><%= PortletUtils.getMessage(pageContext, "show-total",null)%>
      <%}%>
      <%
if(!isOnePage){
if(!isSmallPage){
      if(request.getAttribute("creationLink") != null){
        String creationLink = (String)request.getAttribute("creationLink");
      %>
      <a href="<%= creationLink%>">[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "add",null)%></span> ]</a>
      <%
      }
      if(request.getAttribute("querylink") == null || ((String)request.getAttribute("querylink")).equalsIgnoreCase("yes")){
      %>
      <a href="<%= NDS_PATH+"/query/"+ (query_page==null?"query.jsp":query_page)%>?action=input&return_type=t&table=<%=qRequest.getMainTable().getId()+(isStatusEnabled?"&status="+status:"")%>">
      [<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "query",null)%></span>]</a>
      <%
      }
      if(request.getAttribute("report") == null || ((String)request.getAttribute("report")).equalsIgnoreCase("yes")){
        if(result.getRowCount()>0){
      %>
      <a href='javascript:createReport(document.form1)'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "export",null)%></span>]</a>
      <%
        }
      }
      %>
      <a href='javascript:printDocument(document.form1)'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "print",null)%></span>]</a>
      <a href='javascript:refresh(document.form1)'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "refresh",null)%></span>]</a>
      &nbsp;-&nbsp;
<%}
%>
      <%if(startIndex > 1){%>
      <a href="javaScript:setIndex(document.form1,1)"><img src="<%=NDS_PATH%>/images/begin.gif" align="absmiddle" border=0></a>
      <a href="javaScript:setIndex(document.form1,<%=((startIndex - range)<0?1:(startIndex-range))%>)"><img src="<%=NDS_PATH%>/images/back.gif" align="absmiddle" border=0></a>
      <%}else{%>
      <img src="<%=NDS_PATH%>/images/begin_gray.gif" align="absmiddle" border=0 > 
      <img src="<%=NDS_PATH%>/images/back_gray.gif" align="absmiddle" border=0>
      <%}
      if((endIndex)< totalCount){%>
      <a href="javaScript:setIndex(document.form1,<%=(startIndex+range)>totalCount?(totalCount-range): (startIndex+range)%>)"><img src="<%=NDS_PATH%>/images/next.gif" align="absmiddle" border=0></a>
      <a href="javaScript:setIndex(document.form1,<%=totalCount -count+1%>)"><img src="<%=NDS_PATH%>/images/end.gif" align="absmiddle" border=0></a>
      <%}else{%>
      <img src="<%=NDS_PATH%>/images/next_gray.gif" align="absmiddle" border=0> 
      <img src="<%=NDS_PATH%>/images/end_gray.gif" align="absmiddle" border=0>
      <%}%>
      &nbsp;
	  <%if(!isSmallPage){
      %>
      -&nbsp;
        <%if(result.getRowCount()>0){%>
        <%= PortletUtils.getMessage(pageContext, "show-page-number",null)%><select style="font-size:8pt;" size="1" name="range" onChange="javascript:doSubmit(document.form1, <%=startIndex%>, this.value)">
          <%
                          for(int i =0;i<selectRanges.length;i++)
                          {
                            int t1=selectRanges[i];
                          %>
          <option value="<%=t1%>" <%=(t1==range)?"selected":"" %>><%=t1%></option>
          <%
                          }
                          %>
        </select><%= PortletUtils.getMessage(pageContext, "show-page-number-end",null)%>,
        <%}
        }
        %>
        <%=startIndex %>-<%=endIndex%>/<%=totalCount%>
<%}// end if(!isOnePage)
%>        
    </td>
  </tr>
</table>
<script language="JavaScript">
	function resizeDiv_div1(div){
		// this function will be called when window resize
		//@param div is the div control
		div.style.width=DEFAULT_TAB_WIDTH-20;
		/*
		if(document.body.clientWidth>40) 
			div.style.width=document.body.clientWidth-30;
		else 
			div.style.width=30;
		*/	
	}
</script>
<script type="text/javascript" src="<%=NDS_PATH%>/js/selectableelements.js"></script>
<script type="text/javascript" src="<%=NDS_PATH%>/js/selectabletablerows.js"></script>
<!--<div id="resizableDiv" name="div1" style="width:240px; height=600px;z-index:1; overflow: scroll;">-->
<div id="resizableDiv" name="div1">
<% if ( isMultiSelectEnabled) {
%>
<table border="0" width="100%" align="center" cellspacing="0" cellpadding="0" ><tr><td>
<form name="<%=htMultiSelect.get("select_form")%>" method='post' action='<%=contextPath+ "/control/command"%>'>
<%String sAttName;
for (Iterator it= htMultiSelect.keySet().iterator();it.hasNext();){
	sAttName=(String)it.next();
	out.println("<input type='hidden' name='" +sAttName + "' value='" + htMultiSelect.get(sAttName)+"'>");
}
//(each row's id will be set in hidden input named "itemid", and checkbox will be named "selectedItemIdx"
//    @see nds.control.event.DefaultWebEvent#getParameterValues
out.println("<input type='hidden' name='arrayItemSelecter' value='selectedItemIdx'>");
} 
CollectionValueHashtable tableAlertHolder=new CollectionValueHashtable();

%>
<!--<table id="<%=inc_table_id%>" width="98%" border="1" cellspacing="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#999999" class="sort-table" onselectstart="if(window.event.ctrlKey || window.event.shiftKey) return false;else return true;">
	-->
<table id="<%=inc_table_id%>" width="98%" border="1" cellspacing="0" cellpadding="0"  align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFFFFF">
	
              <thead>
              <tr>
                      <%for(int i=0;i<showColumns.length;i++){%>
                      <td align="center" nowrap>
                        <%
                        String orderArrow = "";
                        if(orderColumns.compareTo(showColumnLinks[i]) == 0){
                            if(qRequest.isAscendingOrder())
                                orderArrow = "<img src='"+ NDS_PATH+"/images/upsimple.png' border=0 width=8 height=7>";
                            else
                                orderArrow =  "<img src='"+ NDS_PATH+"/images/downsimple.png' border=0 width=8 height=7>";
                        }
                        if(!isOnePage){
                        %>
                        <span name="<%=showColumnLinks[i]%>" onClick="javascript:reOrder(form1,'<%=showColumnLinks[i]%>')"><%=showColumns[i]+orderArrow%> </span>
						<%}else{%>
						<span name="<%=showColumnLinks[i]%>"><%=showColumns[i]+orderArrow%> </span>
						<%}%>
                      </td>
                      <%}%>
              </tr>
              </thead>
              <%
              if(result.getRowCount() == 0){

              %>
              <tr class="even-row">
                      <td align="center" colspan="<%=showColumns.length + qRequest.getMainTable().getFlinks().size()%>">
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
                    
                    Object tmpAKValue;
                    String akData;
                   while(result.next()){
                   		if(serialno%1==0) whiteBg = (whiteBg==false);
                        serialno ++;
                        String itemId = "-1";
                  %>
              <tr id='tr_<%=serialno%>' class='<%=(whiteBg?"even-row":"odd-row")%>'>
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
                            //String aUrl = isIe?"'javascript:showObject(\""+url+"\",\""+tname+"\")'":"'"+url+"'";//Hawke
                            String aUrl = "'javascript:showObject(\""+url+"\",\""+tname+"\")'";
                            if( colmn.getLength()>QueryUtils.MAX_COLUMN_CHARS && columnData.length()>MAX_COLUMNLENGTH_WHEN_TOO_LONG ){
                                columnData= "<a target='_blank' href="+aUrl+"  title=\""+columnData+"\">"+getStringOfLimitLength(columnData,MAX_COLUMNLENGTH_WHEN_TOO_LONG)+"..."
                                    +"</a>";

                            }else{
                                columnData="<a href="+aUrl+">"+ columnData+"</a>";
                            }
                        }else{

                            if( colmn.getLength()>QueryUtils.MAX_COLUMN_CHARS && columnData.length()>MAX_COLUMNLENGTH_WHEN_TOO_LONG){
                                if( Tools.isHTMLAnchorTag(columnData)){
                                    // just return the columnData
                                }else{
                                    if(colmn.getId() == pkId && meta.getColumnLink(i+1).length()==1) {
                                        if(!mainTablePathIsFunction)
                                        	url= "javascript:showObject(\""+ mainTablePath+columnData+"\")";
                                        else
                                        	url=mainTablePath.replaceAll(":ID",columnData);
                                        columnData= "<a href='"+url+"' title=\""+columnData+"\">"+getStringOfLimitLength(columnData,MAX_COLUMNLENGTH_WHEN_TOO_LONG)+"...</a>";
                                    }else{
                                        columnData= "<a href='#' title=\""+columnData+"\">"+getStringOfLimitLength(columnData,MAX_COLUMNLENGTH_WHEN_TOO_LONG)+"...</a>";
                                    }
                                }
                            }else if(colmn.getId() == pkId && meta.getColumnLink(i+1).length()==1){
                                itemId = columnData;
                                resPkId = columnData;
                                columnData="";
                                tdAttributes="id='td_obj_"+ itemId + "'";
                                if ( isMultiSelectEnabled == true ) {
                                	// add checkbox here
                                	columnData +="<input type='hidden' id='"+akData +"' name='itemid' value='" + itemId + "'  >";
                                	columnData +="<input class='cbx' type='checkbox' id='chk_obj_"+  itemId +"' name='selectedItemIdx' value='" + (serialno-startIndex)+"' onclick=unselectall()>";

                                }else if( returnType==SELECT_SINGLE ){
                                	columnData += "<input type='hidden' name='itemid' value='" + itemId + "'  >";
                                    columnData +="<input class='cbx' type='radio' id='chk_obj_"+  itemId +"' name='selectedItemIdx' value='"+(serialno-startIndex)+"' onclick='close_popup(\""+ akData+"\")'>";
                                    tdAttributes +=" title=\""+ akData+"\"";
                                }
                                if(!mainTablePathChanged)
                                	columnData +="<a href='javascript:showObject2(\""+itemId+"\")' >"+ serialno+"</a>";
                                else{ 
                                    if(!mainTablePathIsFunction)
                                    	url= "javascript:showObject(\""+ mainTablePath+itemId+"\")";
                                    else
                                    	url=mainTablePath.replaceAll(":ID",itemId);
                                	columnData +="<a href='"+url+"' >"+ serialno+"</a>";
                                }
                            }
                        }
                        nds.web.alert.ColumnAlerter ca=(nds.web.alert.ColumnAlerter)colmn.getUIAlerter();
                        if(ca!=null){
                        	String rowCss=ca.getRowCssClass(result, i+1, colmn);
                        	if(nds.util.Validator.isNotNull(rowCss))tableAlertHolder.add("tr_"+serialno, rowCss);
                        }
                  %>
                <td nowrap align="<%=columnAligns[i]%>" width="<%= (int)(100* colmn.getLength()/ totalLength) %>%" <%=tdAttributes%>>
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

            // add page subtotal
            Table mainTable=qRequest.getMainTable();
            if ( mainTable.isSubTotalEnabled()){
            	out.println("<tr>");
            	boolean hasFirstSum=false;
            	for(int i=0;i< meta.getColumnCount();i++){
                	String columnData=result.getSubTotalValue(i+1, false); // no &nbsp;
                	if(columnData !=null && !columnData.trim().equals("")){
                		if(hasFirstSum==false){
                			if(i>0)out.println("<td colspan='"+(i)+"' align='right' height='20' bgcolor='#eeeeee'><b><font color='red'>"+PortletUtils.getMessage(pageContext, "page-sum",null)+"</font></b></td>");
                			hasFirstSum=true;
                		}
                		out.println("<td nowrap align='right' height='20' bgcolor='#eeeeee'><b><font color='red'>"+ columnData + "</font></b></td>");

                	}else if( hasFirstSum==true){
                		out.println("<td>&nbsp;</td>");
                	}

            	}
            	out.println("</tr>");
            }
            if ( qRequest.isFullRangeSubTotalEnabled()){
            	out.println("<tr>");
            	boolean hasFirstSum2=false;
            	for(int i=0;i< meta.getColumnCount();i++){
                	String columnData=result.getFullRangeSubTotal(i+1, false);
                	if(columnData !=null && ! columnData.trim().equals("")){
                		if(hasFirstSum2==false){
                			if(i>0)out.println("<td colspan='"+(i)+"' align='right' height='20' bgcolor='#eeeeee'><b><font color='red'>"+ PortletUtils.getMessage(pageContext, "total-sum",null)+"</font></b></td>");
                			hasFirstSum2=true;
                		}
                		out.println("<td nowrap align='right' height='20' bgcolor='#eeeeee'><b><font color='red'>"+ columnData + "</font></b></td>");

                	}else if( hasFirstSum2==true){
                		out.println("<td>&nbsp;</td>");
                	}
            	}
            	out.println("</tr>");

            }

                   %>
            </table>
<% if ( isMultiSelectEnabled) { %>
	</form>
</td></tr></table>
<%}%>
</div><!--end list scroll -->
<script type="text/javascript">
<%
// change row class according to alert setting 
for(Iterator it=tableAlertHolder.keySet().iterator();it.hasNext();){
	Object rowKey=it.next();
%>
	document.getElementById("<%=rowKey%>").className="<%=Tools.toString(tableAlertHolder.get(rowKey), " ")%>";
<%	
}
%>
var selTb;
selTb= new SelectableTableRows(document.getElementById("<%=inc_table_id%>"), <%=isMultiSelectEnabled%>);
<%
if(isMultiSelectEnabled ){
%>
	var prevSelected;
	prevSelected=selTb.getSelectedItems();
    selTb.onchange = function () {
        	// remove previous selected on
        	var i,j,bUnSelected,bSelected, idx;
        	var curSelected=  selTb.getSelectedItems();
        	
        	for(i=0;i<prevSelected.length;i++){
        		bUnSelected=true;
        		for(j=0;j<curSelected.length;j++){
        			if(prevSelected[i]==curSelected[j]){
        				bUnSelected=false;
        				break;
        			}
        		}
        		if(bUnSelected){
        			// if multiple choice, find first column's checkbox and unset
        			try{
        			idx=prevSelected[i].cells[0].id;
        			prevSelected[i].all("chk_obj_"+idx.replace(/td_obj_/g, "")).checked=0;
        			}catch(ex){}
        		}
        	}
        	for(i=0;i<curSelected.length;i++){
        		bSelected = false;
        		for(j=0;j<prevSelected.length;j++){
        			if(prevSelected[j]==curSelected[i]){
        				bSelected=true;
        				break;
        			}
        		}
        		if(!bSelected){
        			try{
        			idx=curSelected[i].cells[0].id;
        			curSelected[i].all("chk_obj_"+idx.replace(/td_obj_/g, "")).checked=1;
        			}catch(ex){}
        		}
        	}
        	unselectall();
        	prevSelected=curSelected;
        };
<%
}// end if(isMultiSelectEnabled )
if(returnType==SELECT_SINGLE){
%>		
		selTb.ondoubleclick=function(trElement){
			try{
			idx=trElement.cells[0].title;
			if(idx!="")close_popup(idx);
			}catch(ex){}
		};
<%
}else{ // multiple selection of select none(just display)
%>
		selTb.ondoubleclick=function(trElement){
			idx=trElement.cells[0].id;
			try{
			idx=idx.replace(/td_obj_/g, "");
			if(idx!="")showObject2(idx);
			}catch(ex){}
		};
<%}%>
  function showObject2(s){
    	showObject("<%=mainTablePath%>"+s,"");
    }

</script>

<table border="0" width="98%" align="center">
  <tr><td>
     <font color='red'>*</font><%= PortletUtils.getMessage(pageContext, "current-filter",null)%>:
     <span class=sqldesc id=filter_setting>
     <%if(qRequest.getParamDesc(true).trim().equals("")){%>
    	<%= PortletUtils.getMessage(pageContext, "none",null)%>
     <%}else{%>
     	<%=qRequest.getParamDesc(true).trim()%>
     <%}%>
     
     </span>
  </td></tr>
<%if(!isOnePage){%>  
  <tr valign="top">
    <td>
      <%
      if(!isSmallPage){
      if(request.getAttribute("creationLink") != null){
        String creationLink = (String)request.getAttribute("creationLink");
      %>
      <a href="<%= creationLink%>">[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "add",null)%></span>]</a>
      <%
      }
      if(request.getAttribute("querylink") == null || ((String)request.getAttribute("querylink")).equalsIgnoreCase("yes")){
      %>
      <a href="<%= NDS_PATH%>/query/query.jsp?action=input&return_type=t&table=<%=qRequest.getMainTable().getId()+(isStatusEnabled?"&status="+status:"")%>">
      [<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "query",null)%></span>]</a>
      <%
      }
      if(request.getAttribute("report") == null || ((String)request.getAttribute("report")).equalsIgnoreCase("yes")){
        if(result.getRowCount()>0){
      %>
      <a href='javascript:createReport(document.form1)'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "export",null)%></span>]</a>
      <%
        }
      }
      %>
      <a href='javascript:refresh(document.form1)'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "refresh",null)%></span>]</a>
      <a href='javascript:printDocument(document.form1)'>[<span class="link_cn"><%= PortletUtils.getMessage(pageContext, "print",null)%></span>]</a>

      &nbsp;-&nbsp;
      <%}
      
      if(startIndex > 1){%>
      <a href="javaScript:setIndex(document.form1,1)"><img src="<%=NDS_PATH%>/images/begin.gif" align="absmiddle" border=0></a>
      <a href="javaScript:setIndex(document.form1,<%=((startIndex - range)<0?1:(startIndex-range))%>)"><img src="<%=NDS_PATH%>/images/back.gif" align="absmiddle" border=0></a>
      <%}else{%>
      <img src="<%=NDS_PATH%>/images/begin_gray.gif" align="absmiddle" border=0 > <img src="<%=NDS_PATH%>/images/back_gray.gif" align="absmiddle" border=0>
      <%}
      if((endIndex)< totalCount){%>
      <a href="javaScript:setIndex(document.form1,<%=(startIndex+range)>totalCount?(totalCount-range): (startIndex+range)%>)"><img src="<%=NDS_PATH%>/images/next.gif" align="absmiddle" border=0></a>
      <a href="javaScript:setIndex(document.form1,<%=totalCount -count+1%>)"><img src="<%=NDS_PATH%>/images/end.gif" align="absmiddle" border=0></a>
      <%}else{%>
      <img src="<%=NDS_PATH%>/images/next_gray.gif" align="absmiddle" border=0> <img src="<%=NDS_PATH%>/images/end_gray.gif" align="absmiddle" border=0>
      <%}%>
      &nbsp;-&nbsp;
        <%if(result.getRowCount()>0){%>
        <%= PortletUtils.getMessage(pageContext, "show-page-number",null)%><select style="font-size:8pt;" size="1" name="range" onChange="javascript:doSubmit(document.form1, <%=startIndex%>, this.value)">
          <%
                          for(int i =0;i<selectRanges.length;i++)
                          {
                            int t1=selectRanges[i];
                          %>
          <option value="<%=t1%>" <%=(t1==range)?"selected":"" %>><%=t1%></option>
          <%
                          }
                          %>
        </select><%= PortletUtils.getMessage(pageContext, "show-page-number-end",null)%>,
        <%}%>

        <%=startIndex %>-<%=endIndex%>/<%=totalCount%>
    </td>
  </tr>
<%}//end if(!isOnePage)
%>  
</table>
<% if (isMultiSelectEnabled == false ) {
	// when mulitselect is enabled ,the outside should create a form
%>
	</form> <!-- end form for noUseButForNS -->
<% } %>

<div id="justForNS" style="position:absolute; left:0px; top:0px; width:14px; height:1px; z-index:1; visibility: hidden">
<form name= "form1" method="post" action="<%=contextPath+"/servlets/QueryInputHandler" %>">
<%
    out.print(QueryUtils.toHTMLControlForm(qRequest, (Expression)request.getAttribute("userExpr")));
    //Hawke begin
    //解决查询中丢失accepter_id和return_type
    if(request.getParameter("accepter_id") != null)
      out.println("<input type=\"hidden\" name=\"accepter_id\" value=\""+request.getParameter("accepter_id")+"\">");
    if(request.getParameter("return_type") != null)
      out.println("<input type=\"hidden\" name=\"return_type\" value=\""+request.getParameter("return_type")+"\">");
    //Hawke end
%>
	<input type='hidden' name="quick_search_filterid" value=''>
	<input type='hidden' name="quick_search_data" value="">
    <input type='hidden' name="quick_search_column" value="">
    <input type='hidden' name="quick_search" value="false">

</form>
</div>

