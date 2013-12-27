<%@ page language="java"  pageEncoding="utf-8"%>
<%@ page import="nds.control.web.*,com.liferay.portal.util.ShutdownUtil" %>
<%
	UserWebImpl userWeb =null;
	if(ShutdownUtil.isShutdown()){
		session.invalidate();
	}
	try{
		userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	}catch(Throwable userWebException){
		System.out.println("########## found userWeb=null##########"+userWebException);
	}
    String idS=request.getParameter("id");
    int id=-1;
    if (idS != null) {
        id=Integer.parseInt(idS);
    }
     if(userWeb==null || userWeb.getUserId()==userWeb.GUEST_ID){
 	/*session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,PrincipalException.class.getName());
 	response.sendRedirect("/login.jsp");*/
 	response.sendRedirect("/c/portal/login");
 	return;
 }
 if(!userWeb.isActive()){
 	session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,"USER_NOT_ACTIVE");
 	response.sendRedirect("/login.jsp");
 	return;
 }
 String m_allot_id=request.getParameter("m_allot_id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>已配明细</title>
<link href="mingxi.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="/html/nds/js/prototype.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script>
<script>
jQuery.noConflict();
</script>
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<script type="text/javascript" src="/distribution/showitem.js"></script> 
<script type="text/javascript" src="/html/nds/js/init_object_query_zh_CN.js"></script>
<script language="javascript" src="/html/nds/js/init_objcontrol_zh_CN.js"></script>

</head>
<body>
<script language="javascript">
	jQuery(document).ready(function(){si.fundQuery(<%=m_allot_id%>);});
	jQuery(document).ready(function(){si.showItem(<%=m_allot_id%>);});
</script>
<div id="mingxi-container">
	<div id="mingxi-tabs">
	  <ul>
	    <li><a onclick='jQuery("#custom-fand").show();jQuery("#dist-item").hide();'  title="客户金额"><span>客户金额</span></a></li>
	    <li><a onclick='jQuery("#dist-item").show();jQuery("#custom-fand").hide();' title="配货明细"><span>配货明细</span></a></li>
	  </ul>
	</div>
	
	<div id="mingxi-table" >
		<div id="dist-item" style="display:none">
		<div class="mingxi-search">
			  <div class="mingxi-search-left">是否未配
			  	<select name="isundist" id="isundist">
				  	<option value="-1">全部</option>
				  	<option value="0">否</option>
				  	<option value="1">是</option>
					</select>
				</div>
				<div class="mingxi-search-right">条件&nbsp;&nbsp;
					<select name="con1" id="con1">
				  	<option value="pdt">款号</option>
				  	<option value="col">色号</option>
				  	<option value="size">尺寸</option>
				  	<option value="cus">客户</option>
				  	<option value="qtyrem">订单未配量</option>
					</select>
					&nbsp;&nbsp;满足&nbsp;&nbsp;<input id="v1" name="" type="text" class="mingxi-60" />
					<select name="rel" id="rel">
				  	<option value=""></option>
				  	<option value="and">且</option>
				  	<option value="or">或</option>
					</select>
					&nbsp;&nbsp;条件&nbsp;&nbsp;
					<select name="con2" id="con2">
				  	<option value="pdt">款号</option>
				  	<option value="col">色号</option>
				  	<option value="size">尺寸</option>
				  	<option value="cus">客户</option>
				  	<option value="qtyrem">订单未配量</option>
					</select>
					&nbsp;&nbsp;满足&nbsp;&nbsp;<input id="v2" name="" type="text" class="mingxi-60" />&nbsp;&nbsp;
					<input type="button" value="查找" onclick="si.showItem(<%=m_allot_id%>,jQuery('#isundist').val())" class="cbutton" />  
			  </div>
	  </div>
	
	<div class="mingxi-height"></div>
	
	<div class="mingxi-head">
		<div class="span-1">款号</div><div class="span-1">色号</div><div class="span-1">尺寸</div><div class="span-2">客户</div><div class="span-1">订单未配量</div><div class="span-11">是否未配</div>
	</div>
	
	<div id="mingxi-main" class="main_content" style="height: 232px; width: 860px; visibility: visible; opacity: 1;">
	 </div>
	</div>



<!--
客户金额
-->
<div id="custom-fand">
<div class="mingxi-page">
<div class="mingxi-head">
<div class="span-8">经销商</div><div class="span-7">总标准金额</div><div class="span-7">总销售金额</div><div class="span-10">总数量</div>
</div>

<div id="fund-main" class="main_content" style="height: 232px; width: 800px; visibility: visible; opacity: 1;">
</div>
</div>
</div>
</div>
</div>
</body>
</html>
