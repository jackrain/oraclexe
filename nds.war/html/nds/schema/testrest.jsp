<%@ page language="java" import="nds.rest.*,org.json.*,java.net.*,java.io.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<html><body>
<h3>测试REST数据封装格式</h3>
在本页面进行JSON数据格式的测试，您可以查看<a target="_blank" href="rest.demo.txt">各个命令的示例JSON对象格式</a>，可复制到params里运行
<%
	String command=request.getParameter("command");
	String cmdparam=  request.getParameter("params");
	String appkey=  request.getParameter("appkey");
	String pwd=  request.getParameter("pwd");
	String serverUrl=null;
	ValueHolder vh= null;
	JSONArray ja=null;
if(	command !=null){
	SimpleDateFormat a=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
	a.setLenient(false);
	
	HashMap<String, String> params =new HashMap<String, String>();
	params.put("sip_appkey",appkey);
	params.put("sip_timestamp", a.format(new Date()));
	params.put("sip_sign",pwd);
/*
tranaction - 单个Transaction的内容，不能与transactions 同时存在
transactions -[transaction,...] //多个Transaction, 一个transaction里的多个操作将全部成功，或全部失败，每个Transaction对象的定义见下
transaction:{
	id: <transaction-id> // 通过ID使得客户端能获取transaction的执行情况
	command:"ObjectCreate"|"ObjectModify"|"ObjectDelete"|"ObjectSubmit"|"WebAction"|"ProcessOrder"|"Query"|"Import",//Transaction的操作命令
	params:{ //操作命令的参数
		<command-param>:<command-value>,
		...
	}*/
	JSONObject tra=new JSONObject();
	tra.put("id", 112);
	tra.put("command",command);
	
	tra.put("params",  new JSONObject(cmdparam));
	
	ja=new JSONArray();
	ja.put(tra);
	
	params.put("transactions", ja.toString());

	Enumeration  enu=request.getHeaders("Origin");
	if(enu.hasMoreElements()){ 
		serverUrl=(String)enu.nextElement(); 
	}
	vh=RestUtils.sendRequest(serverUrl+"/servlets/binserv/Rest", params,"POST");
}	
%>
<form name="p" method="post" action="testrest.jsp">
	<table border=0>
		<tr><td>appkey:</td><td><input type="text" id="appkey" name="appkey"></input></td></tr>
		<tr><td>password:</td><td><input type="text" id="pwd" name="pwd"></input></td></tr>
		<tr><td>
	command:</td><td><select id="command" name="command"><option value="ObjectCreate">ObjectCreate </option>
		<option value="ObjectModify">ObjectModify </option> 
		<option value="ObjectDelete">ObjectDelete </option> 
		<option value="ObjectSubmit">ObjectSubmit </option> 
		<option value="ProcessOrder">ProcessOrder </option>
		<option value="ExecuteWebAction">ExecuteWebAction </option> 
		<option value="Import">Import </option> 
		<option value="Query">Query </option> 
		<option value="GetObject">GetObject </option> 
	</select> </td></tr>
<td>params<br>(json format):</td><td><textarea name="params" rows="12" cols="80"><%=(cmdparam==null?"":cmdparam)%></textarea></td></tr>
<tr><td>&nbsp;</td><td>
<input type="submit" value="Submit"/></td></tr>
</table>	
</form>	
<script>
function sel(ele, val) {
  var found  = false;
  var i;
  var j;
  for (i = 0; i < ele.options.length; i++) {
    ele.options[i].selected = false;
    if (ele.options[i].value == val) {
        ele.options[i].selected = true;
    }
  }
}  

sel(document.getElementById("command"),"<%=(command==null?"ProcessOrder":command)%>");
</script>
<p>
<%if(vh!=null){%>
<h3>运行结果</h3>
return code:<%=vh.get("code")%> <p>
return message:<%=vh.get("message")%><p>
transactions:<%=ja.toString() %><p>
query:<%=vh.get("queryString")%><p>
<%}%> 
</body></html>
