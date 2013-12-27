<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	String tabName=PortletUtils.getMessage(pageContext, "sql_filter",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Things needed in this page:
     *  table - int the table id which to be filtered
     */
    TableManager tm= TableManager.getInstance();
    int tableId= ParamUtils.getIntParameter(request, "table", -1);
    Table table = tm.getTable(tableId);
%>

<style>
.expfav		{font-size: 80%; text-align: Right; margin-top: -1em; margin-bottom: 0; }

.expanded	{font-weight: normal;color:navy; background:#ECEFF8 }	

.collapsed	{display: none;}	
			 	
.def		{margin-top: 40pt;}	

.PreferSelect { font-family: ËÎÌו; FONT-SIZE: 8pt;}
</style>
<script language="JavaScript" src="/html/nds/js/ExpCollapse.js"></script>
<br>
<script>
    function saveFilter(){
        if (prefer_form.filter.value==null || prefer_form.filter.value.length <1) {
            alert("<%=PortletUtils.getMessage(pageContext, "must-input-description",null)%>");
            return false;
        }
        if ( prefer_form.filter_expr.value==null ||  prefer_form.filter_expr.value.length < 1) {
            alert("<%=PortletUtils.getMessage(pageContext, "please-click-query-button-to-set-filter",null)%>");
            return false;
        }
        window.opener.document.filter_dir.sqldesc.value= prefer_form.filter.value;
        window.opener.document.filter_dir.sql.value= prefer_form.filter_sql.value;
        window.opener.document.filter_dir.expr.value= prefer_form.filter_expr.value;
        var hier=prefer_form.hier.options[prefer_form.hier.selectedIndex].value;
        window.opener.document.filter_dir.hier.value= hier;
        window.opener.document.filter_dir.submit();
        window.close();
    }

    function pop_up_or_clear(src, url, window_name, sObjectID){
              var oWorkItem = src;

              if ( oWorkItem.name=="popup"){
                  // open new query window for anothter object
                  popup_window(url,window_name);
              }else{
                  //clear
                  document.getElementById(sObjectID + "_link").name="popup"; // reset to popup
                  document.getElementById(sObjectID+"_expr").value="";
                  document.getElementById(sObjectID+"_img").src="<%=NDS_PATH%>/images/find.gif";
                  document.getElementById(sObjectID+"_img").alt="<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>";
                  document.getElementById(sObjectID).value="";
              }
     }
	function search_relatetables(){
		var hier=prefer_form.hier.options[prefer_form.hier.selectedIndex].value;
		popup_window('relate_table.jsp?table=<%=tableId%>&hier='+hier);
	}
</script>
<table border="0" cellspacing="0" cellpadding="0" align="center" width="90%">
  <tr>
    <td rowspan=2>&nbsp;</td>
          <td>
          </td>
          <td rowspan=2>&nbsp;</td>
        </tr>
        <tr>
          <td colspan=3>
		<table border="0" cellspacing="0" cellpadding="0" align="center" width="100%">
          <tr >
            <td> <table border="0" cellspacing="0" cellpadding="0" align="center" width="90%"><tr><td>
              <br>
         <%=PortletUtils.getMessage(pageContext, "setting-filter-pre",null)%><%=table.getDescription(locale) %>
         <%=PortletUtils.getMessage(pageContext, "setting-filter-last",null)%>
<form name="prefer_form" method="post">
  <%=PortletUtils.getMessage(pageContext, "filter",null)%>:
<%
     String column_acc_Id="filter";
     String url="/html/nds/query/search.jsp?table="+tableId+"&return_type=m&accepter_id="+column_acc_Id;
%>
<input readonly='on' type="text" name="<%=column_acc_Id%>" id="<%=column_acc_Id%>" value='' size="80" maxlength="1500">
<input type="hidden" name="security" id="security" value="security">
<span id='<%=column_acc_Id+"_link"%>'  title="popup" onaction='oq.toggle("<%=url%>","<%=column_acc_Id%>")'><img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='../images/find.gif' alt='<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>'></span>
<script>createButton(document.getElementById("<%=column_acc_Id+"_link"%>"));</script>	
&nbsp;&nbsp;&nbsp;<a href="#" class="DropDown" onclick="Outline2()"><img border=0 src="../images/blueup.gif" ><%=PortletUtils.getMessage(pageContext, "suggest",null)%></a>
            <DIV id="ExpCol"  class="collapsed" border="0" ><font color=red>*</font>
           <%=PortletUtils.getMessage(pageContext, "filter-suggest",null)%>
          </DIV>
<input type="hidden" name="<%=column_acc_Id+"_expr"%>" id="<%=column_acc_Id+"_expr"%>"  value=''>
<input type="hidden" name="<%=column_acc_Id+"_sql"%>" id="<%=column_acc_Id+"_sql"%>" value=''>
<p> <%=PortletUtils.getMessage(pageContext, "relate-level",null)%>
<select name="hier">
 <option value=0> 0 </option>
 <option value=1> 1  </option>
 <option value=2> 2  </option>
 <option value=3> 3  </option> 
 <option value=4> 4  </option> 
 <option value=5> 5  </option> 
 <option value=6> 6  </option> 
 <option value=7> 7  </option> 
 <option value=8> 8  </option> 
 <option value=9> 9  </option> 
 <option value=99> 99  </option> 
</select>&nbsp;&nbsp;<a href="#" class="DropDown" onclick="Outline2()"><img border=0 src="../images/blueup.gif" ><%=PortletUtils.getMessage(pageContext, "suggest",null)%></a>
&nbsp;&nbsp;<%=PortletUtils.getMessage(pageContext, "filter.review",null)%><a href='javascript:search_relatetables()'><%=PortletUtils.getMessage(pageContext, "filter-related-tables",null)%></a>
            <DIV id="ExpCol"  class="collapsed" border="0" ><font color=red>*</font>
          <%=PortletUtils.getMessage(pageContext, "filter-suggest2",null)%>
          </DIV>
<p>
<input  type='button' name='saveDesc' value='<%=PortletUtils.getMessage(pageContext, "object.modify",null)%>' onclick="javascript:saveFilter();" >
<input  type='button' name='Cancle' value='<%=PortletUtils.getMessage(pageContext, "close-window",null)%>' onclick="javascript:window.close();" >

</form></td></tr></table>
 </td></tr></table>
 <br>
 </td></tr></table>
		
    </div>
</div>			
<%@ include file="/html/nds/footer_info.jsp" %>