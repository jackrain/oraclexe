<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="nds.excel.*"%>
<%
    /**
     * Things needed in this page:
     *  table* - (int) table id
     *  objectid - (int) if table is sheetItem, then sheet's id will be set here
        mainobjecttableid - sheet table' tableId, may exists in param or attribute
        fixedcolumns - fixed colums of the import
     */
%><html>
<head>
<%@ include file="/html/common/themes/top_meta.jsp" %>
<%@ include file="/html/common/themes/top_meta-ext.jsp" %>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico">
<script language="javascript" src="/html/nds/js/prototype.js"></script>
<script language="javascript" src="/html/nds/js/jquery-1.3.2.min.js"></script>
<script language="javascript" src="/html/nds/js/swfobject.js"></script>
<script language="javascript" src="/html/nds/js/jquery.uploadify.v2.0.3.min.js"></script>
<script language="javascript" src="/pandian/import_posfile.js"></script>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal.css" media="screen" />
<link type="text/css" rel="StyleSheet" href="/html/nds/css/importexcel.css" media="screen" />
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/nds_portal.css" media="screen" />
<link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/custom-ext.css" media="screen" />
<link rel="stylesheet" type="text/css" href="/html/nds/css/importexcel_prt.css" media="print" /> 
<title>Import</title>
</head>
<body id="maintab-body">
<%
	TableManager tableManager=TableManager.getInstance();
	int tableId= ParamUtils.getIntAttributeOrParameter(request, "table", -1);
	int objectId= ParamUtils.getIntAttributeOrParameter(request, "objectid", -1);
	PairTable fixedColumns=PairTable.parseIntTable(request.getParameter("fixedcolumns"), null);	
	Table table;
	if( tableId == -1) {
    	String tableName=  request.getParameter("table") ;
    	table= tableManager.getTable(tableName);
    	if( table !=null) tableId= table.getId();
    	else {
        	out.println(PortletUtils.getMessage(pageContext, "object-type-not-set",null));
        	return;
    	}
	}else{
    	table= tableManager.getTable(tableId);
	}

	String tabName= PortletUtils.getMessage(pageContext, "import",null)+" - "+ table.getDescription(locale);
%>
<fieldset id="setting">
  <legend><%=tabName%></legend>
  <div id="tab1">
<%
	// make sure the file has been created
	ExcelTemplateManager etm=new ExcelTemplateManager();
	Configurations conf=(Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
	String downloadPath=conf.getProperty("web.root", "/aic/beaSp2/wls61/config/mizuno/applications/nds")+"/download";
	etm.init(downloadPath);
	etm.getTemplate(tableId);
/**------check permission---**/
String directory= table.getSecurityDirectory();
WebUtils.checkDirectoryWritePermission(directory, request);
/**------check permission end---**/

%>

<form id="form1" name="form1" method="post" enctype="multipart/form-data">
<input type="hidden" name="table" value="<%=tableId %>">
<input type="hidden" name="objectid" value="<%=objectId %>">
<input type="hidden" name="next-screen" value="<%=NDS_PATH%>/info.jsp">
<input type="hidden" name="best_effort" value="true">
<input type="hidden" name="nds.control.ejb.UserTransaction" value="N">
<input type='hidden' name="mainobjecttableid" value="<%= ParamUtils.getIntAttributeOrParameter(request, "mainobjecttableid",-1)%>">
<input type='hidden' name="fixedcolumns" value="<%= fixedColumns.toURLQueryString("")%>">  

<table cellspacing="0" cellpadding="0" border="0" class="documentation">
<tbody>
<tr>
<td valign="top"><strong><%=PortletUtils.getMessage(pageContext, "import-select-file",null)%></strong><br>
	(<%=PortletUtils.getMessage(pageContext, "file-size-max",null)%>: <%=Tools.getInt( conf.getProperty("import.excel.maxsize", "1"),1)%>MB)
	</td>
<td valign="top" align="left">
	<%=PortletUtils.getMessage(pageContext, "posfile-txt",null)%><br>
	<div id="flashcontent"><input id="fileInput1" name="excel" size="35" type="file"/></div></td>
</tr>
</tbody>
</table>	
</form>
 </div>
</fieldset>
<div id="btn">
<input class="command2_button" type='button' id="btnImport" name='ImportExcel' value='<%=PortletUtils.getMessage(pageContext, "import-file",null)%>' onclick="javascript:impxls.beginImport();" >
<input class="command2_button" type='button' id="btnPrint" name='print' value='<%=PortletUtils.getMessage(pageContext, "print",null)%>' onclick="javascript:window.print();" >
<span id="tag_close_window"></span>
<Script language="javascript">
 // check show close window button or not
 if(  self==top){
 	document.getElementById("tag_close_window").innerHTML=
 	 "<input class='command_button' type='button' name='Cancle' value='<%= PortletUtils.getMessage(pageContext, "close-window" ,null)%>' onclick='javascript:window.close();' >";
 }
 

	var upinit={"sizeLimit": <%=(1024*1024 * Tools.getInt( conf.getProperty("import.excel.maxsize", "1"),1))%>,
		'fileDesc'      : 'Text(*.txt)'
		};
	var para={"table":<%=table.getId()%>, "objectid":<%=objectId%>,
		"formRequest":"/html/nds/msg.jsp",
		"next-screen":"/html/nds/text.jsp",
		"best_effort":"true","nds.control.ejb.UserTransaction":"N",
		"mainobjecttableid":"<%= ParamUtils.getIntAttributeOrParameter(request, "mainobjecttableid",-1)%>",
		"fixedcolumns":"<%= fixedColumns.toURLQueryString("")%>",
		"JSESSIONID":"<%=session.getId()%>"
		};
	jQuery(document).ready(function(){
		impxls.initForm(upinit,para);
	});
	
</script>
</div>
<fieldset id="output">
  <legend><%=PortletUtils.getMessage(pageContext, "import-result",null)%></legend>
<div id="whole">
</div>
</fieldset>
</body>
</html>

