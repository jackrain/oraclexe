<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%
	
	int tableId=nds.util.Tools.getInt(request.getParameter("table"),-1);
    TableManager tableManager=TableManager.getInstance();
    Table table=null;
    if(tableId==-1) {
        String tn= request.getParameter("table");
        table=tableManager.getTable(tn);
        if( table ==null){
        	response.sendRedirect( NDS_PATH+ "/query/query_portal.jsp" );
        	return;
        }
        tableId= table.getId();
    }else{
        table= tableManager.getTable(tableId);
    }	
	String tabName= table.getDescription(locale) ;
	request.setAttribute("page_help", "ObjectQuery");
	int navTabTotalWidth=DEFAULT_TAB_WIDTH; //total table width
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=PortletUtils.getMessage(pageContext, "query",null)+" - "+table.getDescription(locale)%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="table_width" value="<%=String.valueOf(navTabTotalWidth)%>" />
</liferay-util:include>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * yfzhu added at 2003-9-26 to support adv security.
     * Request parameters:
     *  1. "retur_type" can be "s" (single line of selected row)or "m"(multiple line of rows), or "n" (default) nothing will be return
     *  2. "accepter_id" the input box's id in window
     *  3. "tab_count" integer, for count of tab control, default to 1
     */
%>
<%
    String return_type= request.getParameter("return_type");
    if( return_type==null || "".equals(return_type)) return_type="n";
    String accepter_id= request.getParameter("accepter_id");
    int tab_count= ParamUtils.getIntAttributeOrParameter(request, "tab_count", 1);// default has only on tab control


    TableQueryModel model= new TableQueryModel(tableId,locale);

// decide whether to add "create button" to redirect to creation page or not
String directory;
directory=table.getSecurityDirectory();
int perm= WebUtils.getDirectoryPermission(directory, request);
boolean isWriteEnabled= ( ((perm & 3 )==3));
boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled ;

/**------check permission---**/
WebUtils.checkTableQueryPermission(table.getName(), request);
/**------check permission end---**/


    ArrayList columns=table.getShowableColumns(Column.QUERY_LIST);
    String form_name="form_search";
%>

<style>
.expfav		{font-size: 80%; text-align: Right; margin-top: -1em; margin-bottom: 0; }
.expanded	{font-weight: normal;color:navy; background:#ECEFF8 }	
.collapsed	{display: none;}	
.def		{margin-top: 40pt;}	
</style>
<script language="JavaScript" src="<%=NDS_PATH%>/js/ExpCollapse.js"></script>
<script language="JavaScript" src="<%=NDS_PATH%>/js/xp_progress.js"></script>


<%@ include file="js/functions.js" %>
 <Script language="javascript">
  // objectid - is string, the correspondant object are as:
  // sObjectID + "_link"  the anchor href id, (changes it's name will will popup or clear content(a)
  // sObjectID + "_img"  the image when popup, it's find img, else, the clear image (img)
  // sObjectID + "_sql" contains sql string (input hidden)
  // sObjectID + "_desc" column description (span)
  // sObjectID + ""  the input box (input)
  function pop_up_or_clear(src, url, window_name, sObjectID){
    var oWorkItem = src;

    if ( oWorkItem.name=="popup"){
        // open new query window for anothter object
        popup_window(url,window_name);
    }else{
        //clear
        document.getElementById(sObjectID + "_link").name="popup"; // reset to popup
        document.getElementById(sObjectID+"_sql").value="";
        document.getElementById(sObjectID+"_img").src="<%=NDS_PATH+"/images/find.gif"%>";
        document.getElementById(sObjectID+"_img").alt="<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>";
        document.getElementById(sObjectID).readOnly =false;
        document.getElementById(sObjectID).style.borderWidth="0px 0px 1px";
        document.getElementById(sObjectID).style.backgroundColor='white';
        document.getElementById(sObjectID).value="";
    }

  }
  <%
    String internal_frame="ifm_"+System.currentTimeMillis();// the internal frame at last line
  %>
  var waitTime=0;
  function doSubmit(form){
    toggleButtons(form,true);
	progressBar.showBar();
	progressBar.togglePause();
    if(parent.listFrame==null){
    	form.resulthandler.value="<%=NDS_PATH%>/query/result.jsp";
    }else{
    	form.target="listFrame";
    	form.resulthandler.value="<%=NDS_PATH%>/objext/list.jsp";
		waitTime=0;    	
	    setTimeout("checkFinish();",2 * 1000);
    }
    return true;//selectNeeded(form);
  }
  function changeTabCount(cnt){
    window.location="<%=NDS_PATH%>/query/query.jsp?table=<%=table.getName()%>&return_type=<%=return_type%>&accepter_id=<%=accepter_id%>&tab_count="+cnt;
  }
  function checkFinish(){
  	if(parent.listFrame!=null){
  		if(parent.listFrame.isLoaded==true || waitTime>15 || parent.listFrame.document.readyState=="complete"){
			progressBar.togglePause(); 
			progressBar.hideBar();
  			toggleButtons(<%=form_name%>,false);
  		}else{
  			waitTime=waitTime+1;
  			setTimeout("checkFinish();",2 * 1000);
  		}
  	}
  }	
</script>
<br>
  
  <table border="0" cellspacing="0" cellpadding="0" align="center"  width="95%">
    <tr >

    <td >
        <table border="0" cellpadding="0" cellspacing="0" align='center' width="98%"><tr><td>
         <%= PortletUtils.getMessage(pageContext, "set-page",null)%>
        <%
                               StringHashtable otab_count = new StringHashtable();
                               for(int iTab_count=1;iTab_count< 10;iTab_count++){
                                   otab_count.put(iTab_count+PortletUtils.getMessage(pageContext, "page",null), ""+iTab_count);
                               }
                               HashMap atab_count=new java.util.HashMap();
                               atab_count.put("onChange", "javascript:changeTabCount(this.value)");
        %>
            <input:select name="tab_count" default="1" attributes="<%=atab_count  %>" options="<%= otab_count %>" />
          </td></tr></table>
      <form name="<%=form_name %>" method="post" action="<%= request.getContextPath()+"/servlets/QueryInputHandler"%>" onSubmit="return doSubmit(document.<%=form_name %>);" >
        <input type='hidden' name='table' value='<%=tableId %>'>
        <input type='hidden' name='tab_count' value='<%=tab_count%>'>
        <input type='hidden' name='return_type' value='<%=return_type %>'>
        <input type='hidden' name='accepter_id' value='<%=accepter_id %>'>
        <input type='hidden' name='param_count' value='<%=columns.size() %>'>
        <input type='hidden' name='resulthandler' value='<%=NDS_PATH%>/query/result.jsp'>
        <input type='hidden' name='show_maintableid' value='true'>
        <%
        String uri = request.getRequestURI();
                           int columnsPerRow=2;// 2 field per row
                           int widthPerColumn= (int)(100/(columnsPerRow*2));
        %>
        <input type='hidden' name='formRequest' value='<%=uri.substring(request.getContextPath().length())+"?"+request.getQueryString()%>'>
		  <%
		  	for(int tabIdx=0;tabIdx< tab_count;tabIdx ++){
		  		// page setting
		  %>
				<div id="tabIdx<%=tabIdx%>">
							<ul><li><a href="#tabct<%=tabIdx%>"><span>
						<%= PortletUtils.getMessage(pageContext, "page",null)%><%=tabIdx+1%>&nbsp;&nbsp;&nbsp;
                    	</span></a></li></ul>
                  	<div id="tabct<%=tabIdx%>"  class="ui-tabs-panel">
                      <table align="center" border="0" cellpadding="1" cellspacing="1" width="90%" >
						   	<% if( tabIdx !=0){
						   		StringHashtable osql_comb = new StringHashtable();
						   		osql_comb.put(  PortletUtils.getMessage(pageContext, "and-condition",null),""+SQLCombination.SQL_AND);
						   		osql_comb.put(  PortletUtils.getMessage(pageContext, "or-condition",null),""+SQLCombination.SQL_OR);
						   		osql_comb.put(  PortletUtils.getMessage(pageContext, "andnot-condition",null),""+SQLCombination.SQL_AND_NOT);
						   		osql_comb.put(  PortletUtils.getMessage(pageContext, "ornot-condition",null),""+SQLCombination.SQL_OR_NOT);
						   		HashMap aosql_comb=new java.util.HashMap();
						   		String nosql_comb="tab"+tabIdx+"_sql_combination";
						   	%>
                      	<tr><td align="center" colspan="<%=columnsPerRow*2%>">
						<input:select name="<%=nosql_comb%>" default="2" attributes="<%=aosql_comb%>" options="<%= osql_comb %>" />
						</td></tr>
                    		<%}/*--end if tabIdx !=0 */%>
                        <%

                          for(int i=0;i< columns.size();i++){
                          Column column=(Column)columns.get(i);
                          if( column.isVirtual()==true) {
            				if(!column.isColumnLink()){
	            				continue;
            				}
            			  }
                          String desc=  model.getDescriptionForColumn(column);
                          String fkDesc= model.getDescriptionForFKColumn(column);
                          if (! "".equals(fkDesc)) fkDesc= "("+ fkDesc+")";
                          String inputName="tab"+tabIdx+"_"+model.getNameForInput(column);
                          String cs= model.getColumns(column);
                          int inputSize=model.getSizeForInput(column);
                          String type=model.getTypeMeaningForInput(column);

                          nds.util.PairTable values = column.getValues(locale);
                          if(i%columnsPerRow == 0)out.print("<tr>");
                          String column_desc="column_"+column.getId()+"_desc"; // equals column_acc_Id + "_desc"
                        %>
                          <td height="18" width="<%=widthPerColumn*2/3%>%" nowrap align="left">
                                     <%=column.getDescription(locale)%><span STYLE='color: blue' id=the_tabIdx/<%=column_desc%> ><%=fkDesc%></span>:
                          </td>
                          <td height="18" width="<%=widthPerColumn*4/3%>%" nowrap align="left">

                              <input type="hidden" name="<%=inputName%>/columns" value="<%=cs%>" >
                           <%
                            if(values != null){// ÏÔÊ¾combox»òradio
                                //Hawke Begin
                                StringHashtable o = new StringHashtable();
                                o.put(PortletUtils.getMessage(pageContext, "combobox-select",null),"0");
                                Iterator i1 = values.keys();
                                Iterator i2 = values.values();
                                while(i1.hasNext() && i2.hasNext())
                                {
                                    String tmp1 = String.valueOf(i2.next());
                                    String tmp2 = String.valueOf(i1.next());
                                    // add = so will match identically
                                    o.put(tmp1,"="+tmp2); // tmp1 is limit-description, tmp2 is limit-value
                                }
                                java.util.HashMap a = new java.util.HashMap();
                                inputName += "/value";
                               
                                // special handling "isactive" field
                                if("isactive".equalsIgnoreCase(column.getName()) && !"n".equals(return_type)){
                                // not attributesText="disabled", so user can still change it,especially in security filter setting
                           %>
                           <input:select name="<%=inputName%>" default="=Y" attributes="<%= a %>" options="<%= o %>" />
                           <input type="hidden" name="<%=inputName%>" value="=Y">
                           <%	}else{
                           %>
                           <input:select name="<%=inputName%>" default="0" attributes="<%= a %>" options="<%= o %>" />
                           <%
                           		}
                            }// end if(value != null)
                            else{
                                String column_acc_Id="tab"+tabIdx+"_column_"+column.getId();
                                String column_acc_name= inputName;
                                java.util.Hashtable h = new java.util.Hashtable();
                                   
                                   h.put("size", "25");
					            if((column.getReferenceTable()!=null && column.getReferenceTable().getAlternateKey().isUpperCase())||
					            	column.isUpperCase()){
					            	h.put("class","inputline ucase");
					            }else
					            	h.put("class","inputline");
                                   
                                   //h.put("maxlength", String.valueOf(inputSize));
                                   inputName += "/value";
	                            if(column.getReferenceTable() !=null){                                   
		                                h.put("id",column_acc_Id);
	                                    String url=request.getContextPath()+"/servlets/query?table="+column.getReferenceTable().getId()+"&return_type=m&accepter_id="+"list_query_form"+"."+column_acc_Id;
	                            %>
                              		<input:text name="<%=inputName%>" attributes="<%= h %>" /><%= type%>
                                    <input type='hidden' name='<%=column_acc_name+"/sql"%>' id='<%=column_acc_Id + "_sql"%>' />
                                        <span id='<%=column_acc_Id+"_link"%>' name="popup" onaction=pop_up_or_clear(this,"<%=url%>","<%="T"+System.currentTimeMillis() %>","<%=column_acc_Id%>")><img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='<%=NDS_PATH%>/images/find.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
										<script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script>	
                                    <%
                            	}else{
                            		//will check type first, for number, construct operator, for date, two fields, for string, contains or equal
                            		if(column.getType()==Column.DATE||column.getType()==Column.DATENUMBER ){
										String showTime = column.getType() == Column.DATE?"Y":"N";
                            		%>
                            		<input:daterange id="<%=column_acc_Id%>" name="<%=inputName%>" attributes="<%= h %>" showTime="<%=showTime%>"/>
                            		<%
                            		}else if(column.getType()==Column.NUMBER){
                            		%>
                            		<input:text name="<%=inputName%>" attributes="<%= h %>" /><%= type%>
                            		<%
                            		}else if(column.getType()==Column.STRING){
                            		%>
                            		<input:text name="<%=inputName%>" attributes="<%= h %>" /><%= type%>
                            		<%
                            		}
                            	}
                            }%>
                          </td>
                        <%
                        if(i%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
                        }%>
                      </table>
                </div></div>
                <%}// end for(int tabIdx=0;tabIdx< tab_count;tabIdx ++)
                %>
 <%
String columnTitles= ""; 
for(int i=0;i<columns.size();i++){
	Column column=(Column)columns.get(i);
	String desc=  model.getDescriptionForColumn(column);
	String selectName = model.getNameForSelect(column);
	columnTitles += (i>0?",":"")+ column.getDescription(locale);
	String cols= model.getColumns(column);
	out.println("<input type='hidden' name='"+selectName+"/columns' value='"+cols+"'>");
}
  %>                
<input type='hidden' name='select_desc' value='<%=columnTitles%>'>
                
        <div align="center"><br>
<%
if (table.isActionEnabled(Table.ADD) && userWeb.isPermissionEnabled(table.getSecurityDirectory(),nds.security.Directory.WRITE)){
String creationLink;
if(Validator.isNotNull(table.getRowURL())) creationLink=NDS_PATH+table.getRowURL()+"?action=input";
else creationLink=NDS_PATH+"/object/object.jsp?table="+tableId+"&action=input";
%>
        	<input class="cbutton" name="addbutton" type="button" value="<%=PortletUtils.getMessage(pageContext, "object.add",null)%>" onClick="window.location='<%=creationLink%>';" >
<%}%>        	
        	<input  class="cbutton"name="submitbutton" type="submit" value="<%=PortletUtils.getMessage(pageContext, "object.search",null)%>">
<%@ include file="/html/nds/common/helpbtn.jsp"%>
<span id="closebtn"></span>
<Script language="javascript">
if( window.self==window.top){
	$("closebtn").innerHTML="<input class='cbutton' type='button' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>(C)' accessKey='C' onclick='window.close();' name='Close'>";
}
</script>
        </div>
    </form>
      </td>
    </tr>
  </table>
<DIV id=ProgressWnd style="position: absolute; left:200px; top:5px;z-index: 100;display:block;">
<script>
	var progressBar = createBar(300, 20, "#FFFFFF", 1, "#000000", "<%=colorScheme.getPortletTitleBg()%>", 150, 10, 3, "");
	progressBar.togglePause();
	progressBar.hideBar();
	var i;
	for(i=0;i<<%= tab_count%>;i++){
		jQuery('#tabIdx'+i+' ul').tabs();
		jQuery('#tabIdx'+i+' ul').attr('class','ui-tabs-nav');
		jQuery('#tabIdx'+i+' li').attr('class','ui-tabs-selected');
		
	}
</script>
</div>
    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %>
