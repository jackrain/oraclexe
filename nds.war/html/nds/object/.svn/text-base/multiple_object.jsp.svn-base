<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%@ page import="nds.control.util.*" %>
<%! 
    /**
      列出 table 指明的表的多条记录，满足条件 fixedcolumns
      之前已经检查了用户的写权限，由于status 字段的存在，导致列表中的
      部分数据可能是不允许修改的，必须进行过滤。方法：
	   首先查询条件需要满足  fixedcolumns， 其次需要在用户可修改的条件下，
	   再次需要满足status 字段(=1可修改), 
      
     * Things needed in this page (attributes) :
     *  1.  itemtable     String|id of table that queried on, 
        2.  mastertable   String|id of master table, 
        3.  masterid	  id of master table record
        4.  refbytable    ref by table of main table (RefByTable)
        5.  fixedcolumns  (PairTable)
        6.  ismodify        "true" | "false" 
     */
%>

<%!
    TableManager manager= TableManager.getInstance();
    String urlOfThisPage="";
	private nds.log.Logger logger= nds.log.LoggerManager.getInstance().getLogger("jsp_multiple_object_modify");
%>
<%
int tableId= ParamUtils.getIntAttribute(request,"itemtable", -1);
int masterTableId=ParamUtils.getIntAttribute(request,"mastertable", -1);
int masterId=ParamUtils.getIntAttribute(request,"masterid", -1);
Table table= manager.getTable(tableId);
Table masterTable= manager.getTable(masterTableId);
RefByTable refbyTable=(RefByTable)request.getAttribute("refbytable");
PairTable fixedColumns=(PairTable)request.getAttribute("fixedcolumns");
boolean isModify= "true".equals(request.getAttribute("ismodify"));

/**------check permission---**/
String directory;
directory=table.getSecurityDirectory();

int perm= WebUtils.getDirectoryPermission(directory, request);

boolean isWriteEnabled= ( ((perm & 3 )==3)) && isModify ;
boolean isSubmitEnabled= ( ((perm & 5 )==5)) ;
boolean canDelete= table.isActionEnabled(Table.DELETE) && isWriteEnabled ;
boolean canModify= table.isActionEnabled(Table.MODIFY) && isWriteEnabled;
boolean canSubmit= table.isActionEnabled(Table.SUBMIT) && isSubmitEnabled ;
boolean canAdd= table.isActionEnabled(Table.ADD) && isWriteEnabled;

/**------check permission end---**/

%>
<script language="javascript">
<%@ include file="inc_multiple_object_init.js.jsp" %>
</script>
<%@ include file="inc_multiple_object.jsp" %>
