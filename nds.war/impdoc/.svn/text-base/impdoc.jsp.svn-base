<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="org.json.*" %>
<%@page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.web.config.*" %>
<% 
   String tableId=request.getParameter("tableid");
   String objectId=request.getParameter("objectid");
   HashMap attributeValues=new HashMap();
   QueryEngine engine=QueryEngine.getInstance();
   List v= engine.doQueryList("select g.value,g.description from AD_LIMITVALUE_GROUP t,ad_limitvalue g where t.name='BILLTYPE(ALL)' and g.ad_limitvalue_group_id=t.id order by g.orderno asc");
   //for(int j=0;j<v.size();j++){
   //     attributeValues.put(((List)v.get(j)).get(0),((List)v.get(j)).get(1));
   // 		}
   //String comp=String.valueOf(attributeValues);
   //out.print(comp);
   //tableObj = JSONObject(attributeValues);
  for(Iterator i = v.iterator();i.hasNext();){
	List a=(List)(i.next());
        //out.print(a.get(1));
        attributeValues.put(a.get(0),a.get(1));
	}
  org.json.JSONObject select_m=new org.json.JSONObject(attributeValues);
  //String comp=String.valueOf(attributeValues);
  //out.print(comp);
%>
<script type="text/javascript">
var newlist='--请选择--';
var newlist1="--请选择--";
var qtype={"B_PLAN":["QTY"],"B_PO":["QTYMODIFY","QTY","QTYREM","QTYINIT","QTYCONSIGN"],"B_SO":["QTYCONSIGN","QTY","QTYOCCU","QTYREM"],"M_INVENTORY":["QTYDIFF","QTYBOOK","QTYCOUNT"],"M_OTHER_INOUT":["QTY"],
"M_PURCHASE":["QTYIN","QTY"],"M_RETAIL":["QTY"],"M_RET_PUR":["QTYOUT","QTY"],"M_RET_SALE":["QTYIN","QTYOUT","QTY"],"M_SALE":["QTYOUT","QTYFCAN","QTY","QTYIN"],
"M_TRANSFER":["QTY","QTYOUT","QTYIN","QTYDIFF","QTYFCAN"]};
var dtype={"B_PLAN":["数量"],"B_PO":["调整数量","数量","剩余量","原始数量","已入量"],"B_SO":["已发量","数量","已配量","剩余量"],"M_INVENTORY":["差异数","帐面数","盘点数"],"M_OTHER_INOUT":["调整数量"],
"M_PURCHASE":["入库数量","采购数量"],"M_RETAIL":["数量"],"M_RET_PUR":["出库数量","数量"],"M_RET_SALE":["入库数量","出库数量","数量"],"M_SALE":["出库数量","可配量","数量","入库数量"],
"M_TRANSFER":["调拨数量","出库数量","入库数量","差异数量","可配量"]};
//alert(dtype);
function addList(){
var selectobj=<%=select_m.toString()%>;
var list = document.getElementById("list");
　　//alert(selectobj[key]);
for (var key in selectobj){
var newOption = document.createElement("option");
var i=key;
var y=selectobj[key];
newOption.setAttribute("value", i);
newOption.appendChild(document.createTextNode(y));
list.appendChild(newOption);
list.selected=2;

}
document.all("list").options.add(new Option(newlist,1));
document.all("list1").options.add(new Option(newlist1,1));
}


function jsSelectItemByValue(objSelect) {
//判断是否存在
var isExit = false;

objSelect.options[4].selected = true;
//alert(objSelect);
for (var i = 0; i < objSelect.options.length; i++) {
if (objSelect.options[i].value == "1") {
objSelect.options[i].selected = true;
isExit = true;
break;
}
}
}


function addLoadEvent(func) 
{
  var oldonload = window.onload; 
  if ((typeof window.onload )!= 'function')
   {
    window.onload = func;	
   } 
  else 
   {  
    window.onload = function()
 {
      //oldonload();
      func();
      //jsSelectItemByValue(document.getElementById("list"));
     }
   }
}


//addLoadEvent(jsSelectItemByValue(document.getElementById("list")));
//addLoadEvent(addList);
</script>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="单据导入" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="enable_context_menu" value="true" />	
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<script language="JavaScript" src="/html/nds/js/formkey.js"></script>
<script type='text/javascript' src='/html/nds/js/dw_scroller.js'></script>
<script language="javascript" src="<%=NDS_PATH%>/js/calendar.js"></script>
<script type='text/javascript' src='/html/nds/js/util.js'></script> 
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<script language="javascript" src="/html/nds/js/alerts.js"></script>
<script language="javascript" src="/impdoc/impdoc.js"></script>
<script type="text/javascript" src="/html/nds/js/init_object_query_zh_CN.js"></script>

<link type="text/css" rel="stylesheet" href="/impdoc/link.css">
<form id="cost_copy" name="cost_copy" method="post">


	<br>

<table width="780" border="0" cellspacing="0" cellpadding="0">

<input type="hidden" id="tableId" value="<%=tableId%>"/>
<input type="hidden" id="objectId" value="<%=objectId%>"/>

          <tr>
            <td width="780" valign="top">
            	<table width="550" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td align="center" valign="top"><div class="from_top_text_list2">从单据编号导入</div>
                	<div class="HackBox"/>
                	</td>
              </tr>
              <tr>
                <td align="center" valign="top">
				<ul class="Var-Index-width1">
				<li>
				<div class="right001">
				<input type="hidden" id="fund_balance" value="<%=objectId%>"/>
				<div class="left002">单据编号<font color="red">*</font>:</div>
                                 <div class="right002"><input type="text" id="docno" name="docno" class="Warning_copy"  /></div>
				</div>
				
			<div class="left001">
					
				<div class="left003">单据类型<font color="red">*</font>:</div>
				<div class="right003">
					<!--input type="text" id="dealer_query1" name="dealer_query1" class="Warning_copy"  title="如果目标用户组为多个，请用逗号隔开！"/-->
					<select name="list" id="list" onchange="bao(this.options[this.options.selectedIndex].value)"> </select>
                                        <script>
						function bao(s)
							{
							var list1 = document.getElementById("list1");
						        //alert(list1.length);
                                                        for (var i=list1.length-1;i>=0;i--) {
							//alert(list1.length);
							list1.remove(i);
								}
							for (var key in dtype){
							var newOption = document.createElement("option");
							var i=key;
							var y=dtype[key];
							var x=qtype[key];
							if (i == s) {
							for (var i = 0; i < y.length; i++) {
							//alert(y[i]);
							 //alert(x[i]);
							var d=y[i];
							document.all("list1").options.add(new Option(d,x[i]));
								}
							}
                                                         }
							}
					</script> 
				</div>
				
                                
			</div>
			<div class="HackBox"></div>
			<div class="left001">
				<div class="left003">导入类型<font color="red">*</font>:</div>
				<div class="right003">
					<select name="list1" id="list1"> </select>
                                        
				</div>
			</div>
			<div class="HackBox"></div>
			<div class="HackBox"></div>
				</li>
				<li>
				<div class="right01"><input id="importbutton" type="button" value="确认导入" onclick="cost.price_copy();" /></div>
				<div class="HackBox"/>
				</li>
				<li>
			  </li>
				</ul>
				</td> 
              </tr>
              <tr>
			  <td></td>
			  </tr>
            </table>
            </td>
          </tr>
</table>
<script>
addList();
jsSelectItemByValue(document.getElementById("list"));
</script>
