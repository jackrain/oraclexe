<%@page contentType= "text/html; charset=GBK"%>
<%@page import="nds.query.*,nds.query.web.*,nds.schema.*,nds.control.web.*,java.util.*,nds.util.*"%>
<%@ taglib uri="/WEB-INF/tld/input.tld" prefix="input" %>
<%@ taglib uri='/WEB-INF/tld/struts-tiles.tld' prefix='tiles' %>
<%@ page errorPage="../error.jsp"%>

<%
    /**
     * yfzhu added at 2003-9-26 to support adv security.
     * Request parameters:
     *  1. "retur_type" can be "s" (single line of selected row)or "m"(multiple line of rows), or "n" (default) nothing will be return
     *  2. "accepter_id" the input box's id in window
     */
%>
<%
    String return_type= request.getParameter("return_type");
    if( return_type==null || "".equals(return_type)) return_type="n";
    String accepter_id= request.getParameter("accepter_id");

    int tableId=nds.util.Tools.getInt(request.getParameter("table"),-1);
    TableManager tableManager=TableManager.getInstance();
    Table table=null;
    if(tableId==-1) {
        String tn= request.getParameter("table");
        table=tableManager.getTable(tn);
        if( table ==null)
        response.sendRedirect( "query_portal.jsp" );
        tableId= table.getId();
    }else{
        table= tableManager.getTable(tableId);
    }
    TableQueryModel model= new TableQueryModel(tableId,locale);

/**------check permission---**/
WebUtils.checkTableQueryPermission(table.getName(), request);
/**------check permission end---**/

    ArrayList columns=table.getShowableColumns(Column.QUERY_LIST);
%>
<tiles:insert page='/header.jsp'>
  <tiles:put name='title' value='<%=table.getDescription(locale)%>' direct='true'/>
</tiles:insert>
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
        window.open(url,window_name);
    }else{
        //clear
        document.getElementById(sObjectID + "_link").name="popup"; // reset to popup
        document.getElementById(sObjectID+"_sql").value="";
        document.getElementById(sObjectID+"_img").src="../images/find.gif";
        document.getElementById(sObjectID).readOnly =false;
        document.getElementById(sObjectID).style.borderWidth="0px 0px 1px";
        document.getElementById(sObjectID).style.backgroundColor='white';
        document.getElementById(sObjectID).value="";
    }

  }
  <%
    String internal_frame="ifm_"+System.currentTimeMillis();// the internal frame at last line
  %>
  function doSubmit(form){
    return selectNeeded(form);
  }
</script>

<br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td width="29%" background="../images/Nds_table_bg_1.gif">

      <div align="center"><font color="#6666FF"><%=table.getDescription(locale)%></font></div>
      </td>
      <td width="3%" background="../images/Nds_table_bg_1.gif">
        <div align="right"><img src="../images/corner.gif" width="20" height="24"></div>
      </td>

    <td width="68%" valign="bottom">
      <div align="right"><font color="#FF3300"><%=nds.control.web.WebUtils.getCompanyInfo()%></font></div>
    </td>
    </tr>
  </table>
  <table border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
    <tr bgcolor="#FFF2D9">

    <td >
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td width="8%"><img src="../images/company_mini.gif" width="59" height="35"></td>
          <td width="92%" valign="bottom">
            <div align="right"><font color="#FF3300"><a href="<%=request.getContextPath()%>/query/query_portal.jsp">[更多查询]</a></font></div>
          </td>
        </tr>
      </table>
      <%
        String form_name="form_search";
      %>
      <form name="<%=form_name %>" method="post" action="<%= request.getContextPath()+"/servlets/QueryInputHandler"%>" onSubmit="return doSubmit(document.<%=form_name %>);" >
        <input type='hidden' name='table' value='<%=tableId %>'>

        <input type='hidden' name='return_type' value='<%=return_type %>'>
        <input type='hidden' name='accepter_id' value='<%=accepter_id %>'>

        <input type='hidden' name='param_count' value='<%=columns.size() %>'>
        <input type='hidden' name='resulthandler' value='/query/result.jsp'>
        <input type='hidden' name='show_maintableid' value='true'>
        <%
        String uri = request.getRequestURI();
        %>
        <input type='hidden' name='formRequest' value='<%=uri.substring(request.getContextPath().length())+"?"+request.getQueryString()%>'>

                <table border="1" cellpadding="1" cellspacing="1" align='center' bordercolordark="#FFFFFF" bordercolorlight="#CCCCCC" width="98%" bgcolor="#FFFFFF">
                   <tr>
                    <td colspan=2 height="20" background="../images/Nds_table_bg_2.gif">

<div align="center">过滤条件 — 值 </div>
                    </td>
                  </tr>
                  <tr>
                    <td  colspan="2">
                      <table align="center" border="0" cellpadding="1" cellspacing="1" width="90%" >
                        <%
                           int columnsPerRow=2;// 2 field per row
                           int widthPerColumn= (int)(100/(columnsPerRow*2));

                          for(int i=0;i< columns.size();i++){
                          Column column=(Column)columns.get(i);
                          if( column.isVirtual()) continue;
                          String desc=  model.getDescriptionForColumn(column);
                          String fkDesc= model.getDescriptionForFKColumn(column);
                          if (! "".equals(fkDesc)) fkDesc= "("+ fkDesc+")";
                          String inputName=model.getNameForInput(column);
                          String cs= model.getColumns(column);
                          int inputSize=model.getSizeForInput(column);
                          String type=model.getTypeMeaningForInput(column);

                          nds.util.PairTable values = column.getValues(locale);
                          if(i%columnsPerRow == 0)out.print("<tr>");
                          String column_desc="column_"+column.getId()+"_desc"; // equals column_acc_Id + "_desc"
                        %>
                          <td height="18" width="<%=widthPerColumn*2/3%>%" nowrap align="left">
                                     <%=column.getDescription(locale)%><span STYLE='color: blue' id=<%=column_desc%> ><%=fkDesc%></span>:
                          </td>
                          <td height="18" width="<%=widthPerColumn*4/3%>%" nowrap align="left">

                              <input type="hidden" name="<%=inputName%>/columns" value="<%=cs%>" >
                           <%
                            if(values != null){// 显示combox或radio
                                //Hawke Begin
                                StringHashtable o = new StringHashtable();
                                o.put("--请选择--","0");
                                Iterator i1 = values.keys();
                                Iterator i2 = values.values();
                                while(i1.hasNext() && i2.hasNext())
                                {
                                    String tmp1 = String.valueOf(i2.next());
                                    String tmp2 = String.valueOf(i1.next());
                                    o.put(tmp1,tmp2);
                                }
                                java.util.HashMap a = new java.util.HashMap();
                                inputName += "/value";
                                //Hawke end
                           %>
                           <input:select name="<%=inputName%>" default="0" attributes="<%= a %>" options="<%= o %>" />
                           <%
                             //out.print(model.createValuesList(inputName+"/value",values));
                            }// end if(value != null)
                            else{
                                String column_acc_Id="column_"+column.getId();
                                String column_acc_name= inputName;
                                java.util.Hashtable h = new java.util.Hashtable();
                                   h.put("id",column_acc_Id);
                                   h.put("size", "20");
                                   h.put("maxlength", String.valueOf(inputSize));
                                   inputName += "/value";
                            %>
                              <input:text name="<%=inputName%>" attributes="<%= h %>" /><%= type%>
                           <%
                                if(column.getReferenceTable() !=null){
                                    // 放置存放SQL条件的隐藏INPUT
                                    // create link
                                    String url=request.getContextPath()+"/servlets/query?table="+column.getReferenceTable().getId()+"&return_type=m&accepter_id="+form_name+"."+column_acc_Id;
                                    %>
                                    <input type='hidden' name='<%=column_acc_name+"/sql"%>' id='<%=column_acc_Id + "_sql"%>' />
                                        <a id='<%=column_acc_Id+"_link"%>' href='#' name="popup" onclick=pop_up_or_clear(this,"<%=url%>","<%="T"+System.currentTimeMillis() %>","<%=column_acc_Id%>")>
                                          <img id='<%=column_acc_Id+"_img"%>' border=0 width=16 height=16 align=absmiddle src='../images/find.gif' alt='点击打开新页面查找本项内容'></a>
                                    <%
                                }
                            }%>
                          </td>
                        <%
                        if(i%columnsPerRow == (columnsPerRow -1))out.print("</tr>");
                        }%>
                      </table>
                    </td>
                  </tr>
                </table><br>
                <table align='center' border="1" cellpadding="1" cellspacing="1" bordercolordark="#FFFFFF" bordercolorlight="#CCCCCC" width="98%" bgcolor="#FFFFFF">
                  <tr>
                    <td height="20" width="48%" background="../images/Nds_table_bg_2.gif">
                      <div align="center">可选择的信息属性</div>
                    </td>
                    <td height="20" width="52%" background="../images/Nds_table_bg_2.gif">
                      <div align="center">要显示的信息属性</div>
                    </td>
                  </tr>
                  <tr>
                    <td height="176" colspan="2">
                      <div align="center">
                        <table border='0'  cellpadding='0' cellspacing='4'width='100%'>
                          <tr>
                            <td> <span class='subheading'>结果中显示的列</span>
                              <table width='100%' border='1' cellpadding='0' cellspacing='6' bgcolor='#FFCC00'>
                                <tr>
                                  <td bordercolor="#FFCC00" width="319"><span class='dialog-label'>可选列：</span></td>
                                  <td bordercolor='#DDDDDD' width="57"></td>
                                  <td bordercolor="#FFCC00" width="299"><span class='dialog-label'>显示列：</span></td>
                                  <td width="44"></td>
                                </tr>
                                <%
                                       for(int i=0;i<columns.size();i++){
                                            Column column=(Column)columns.get(i);
                                            String desc=  model.getDescriptionForColumn(column);
                                            String selectName = model.getNameForSelect(column);
                                            String cols= model.getColumns(column);
                                            out.println("<input type='hidden' name='"+selectName+
                                                "/columns' value='"+cols+"'>");
                                        }
                                      %>
                                <tr>
                                  <td align='center' bgcolor="#FFFFFF" >
                                    <select name='available_column_selection' onChange='selectionChanged(document.forms["form_search"].elements["available_column_selection"],document.forms["form_search"].elements["chosen_column_selection"]); ' size='6'  style='width:100%;' width='100%' multiple='true' >
                                    </select>
                                  </td>
                                  <td align='center' valign='middle'  bordercolor='#FFCC00' width="57">
                                    <img border='0' src='../images/arrowRight_disabled.gif'alt='Add selected items' onMouseDown='pushButton("movefrom_available_column_selection",true);'  onMouseUp='pushButton("movefrom_available_column_selection",false);'  onMouseOut='pushButton("movefrom_available_column_selection",false);'  onClick='moveSelected(document.forms["form_search"].elements["available_column_selection"],document.forms["form_search"].elements["chosen_column_selection"]); updateHiddenChooserField(document.forms["form_search"].elements["chosen_column_selection"],document.forms["form_search"].elements["column_selection"]); ' name='movefrom_available_column_selection' width="24" height="24" /><br>
                                    <br>
                                    <img border='0' src='../images/arrowLeft_disabled.gif'alt='Remove selected items' onMouseDown='pushButton("movefrom_chosen_column_selection",true);'  onMouseUp='pushButton("movefrom_chosen_column_selection",false);'  onMouseOut='pushButton("movefrom_chosen_column_selection",false);'  onClick='moveSelected(document.forms["form_search"].elements["chosen_column_selection"],document.forms["form_search"].elements["available_column_selection"]); updateHiddenChooserField(document.forms["form_search"].elements["chosen_column_selection"],document.forms["form_search"].elements["column_selection"]); ' name='movefrom_chosen_column_selection' width="24" height="24" /></td>
                                  <td align='center' bgcolor="#FFFFFF" >
                                    <input type='hidden' name='column_selection' value=''>
                                    <select name='chosen_column_selection' onChange='selectionChanged(document.forms["form_search"].elements["chosen_column_selection"],document.forms["form_search"].elements["available_column_selection"]); ' size='6'  style='width:100%;' width='100%' multiple='true' >
                                      <%
                                       String oci = "", ocDesc = "";
                                       oci = request.getParameter("order_select");
                                       if(oci == null) oci = "-1";
                                       for(int i=0;i<columns.size();i++){
                                            Column column=(Column)columns.get(i);
                                            String desc=  model.getDescriptionForColumn(column);
                                            String selectName = model.getNameForSelect(column);
                                            if(i==Integer.parseInt(oci)){
                                                oci = String.valueOf(i);
                                                ocDesc = desc;
                                            }
                                      %>
                                      <option value='<%=i%>'><%=desc%></option>
                                      <%}%>
                                    </select>
                                    <script>
                                        updateHiddenChooserField(document.forms["form_search"].elements["chosen_column_selection"],document.forms["form_search"].elements["column_selection"]);
                                    </script>
                                  </td>
                                  <td  width='44' align='center' valign='middle' bordercolor='#FFCC00'><img border='0' src='../images/arrowUp_disabled.gif' alt='Shift selected items down' name='shiftup_chosen_column_selection' onMouseDown='pushButton("shiftup_chosen_column_selection",true);'  onMouseUp='pushButton("shiftup_chosen_column_selection",false);'  onMouseOut='pushButton("shiftup_chosen_column_selection",false);'  onClick='shiftSelected(document.forms["form_search"].elements["chosen_column_selection"],-1); updateHiddenChooserField(document.forms["form_search"].elements["chosen_column_selection"],document.forms["form_search"].elements["column_selection"]);' width="24" height="24" /><br>
                                    <br>
                                    <img border='0' src='../images/arrowDown_disabled.gif' alt='Shift selected items up' name='shiftdown_chosen_column_selection' onMouseDown='pushButton("shiftdown_chosen_column_selection",true);'  onMouseUp='pushButton("shiftdown_chosen_column_selection",false);'  onMouseOut='pushButton("shiftdown_chosen_column_selection",false);'  onClick='shiftSelected(document.forms["form_search"].elements["chosen_column_selection"],1); updateHiddenChooserField(document.forms["form_search"].elements["chosen_column_selection"],document.forms["form_search"].elements["column_selection"]);' width="24" height="24" /></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td height="2">
                              <table width='100%' border='1' cellpadding='0' cellspacing='6' bgcolor='#FFCC00' align="right">
                                <tr>
                                  <td bordercolor="#FFCC00" width="43%" ><span class='dialog-label'>排序的列：</span></td>
                                  <td bordercolor='#FFCC00' valign='middle' align='center' width="57%">
                                    <div align="left">
                                      <input type="button" name="Submit2" value="&lt;&lt;" onClick=move(chosen_column_selection,order_select)>
                                      <span class='subheading'>选择排序列</span> </div>
                                  </td>
                                </tr>
                                <tr>
                                  <td align='center' width="43%" bgcolor="#FFFFFF" >
                                    <%
                                    StringHashtable os = new StringHashtable();
                                    if (oci !="-1" )os.put(ocDesc,oci);
                                    java.util.HashMap a = new java.util.HashMap();
                                    a.put("size","1");
                                    a.put("style","width:100%;");
                                    a.put("width","100%");
                                    a.put("multiple","false");
                                    %>
                                    <input:select name="order_select" options="<%= os %>" default="" attributes="<%= a %>"/>
                                  </td>
                                  <td align='center' valign='middle'  bordercolor='#FFCC00' width="57%" >
                                    <input:radio name="order/asc" value="true" default="true"/>升序
                                    <input:radio name="order/asc" value="false" default="true"/>降序
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td align='left' height="2">每页显示
                              <%
                              StringHashtable or = new StringHashtable();
                              int[] ranges= QueryUtils.SELECT_RANGES;
                              for( int k=0;k< ranges.length;k++){
                                  String tmp = String.valueOf(ranges[k]);
                                  or.put(tmp,tmp);
                              }
                              String tmp = String.valueOf(QueryUtils.DEFAULT_RANGE);
                              a.clear();
                              %>
                              <input:select name="range" options="<%= or %>" default="<%=tmp%>" attributes="<%= a %>" />

                              条记录 </td>
                          </tr>
                        </table>
                     </div>
                    </td>
                  </tr>
                </table>
        <div align="center">
          <table width="38%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="20%" align='right'>
                <select name="submit" >
                  <option value="" selected>开始查找</option>
                </select>
              </td>
              <td align='left' width="16%" height="2">
                <input type="image" name="Submit" value="Submit"  src="../images/exec_btm.gif" width="54" height="24" border="0" >
              </td>
            </tr>
          </table>

          <br>
        </div>
    </form>
      </td>
    </tr>
  </table>

<br><br>
</span>

<script language="javascript">
    addKeyCatcher(this.window,document.forms[0]);
</script>
<tiles:insert page='/footer.jsp'>
</tiles:insert>

