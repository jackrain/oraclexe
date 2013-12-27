<%@ page language="java" import="java.util.*,nds.fair.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
   FairManager fairmanager =FairManager.getInstance();
  int fairid=Tools.getInt(request.getParameter("fairid"),-1); 
   if(fairid==-1){
       throw new NDSException("您还没有选择商品！");
   }
%>
  <%@ include file="/html/nds/fair/top.jsp" %>
   <from>
<input type="hidden" id="fairid" name="fairid" value="<%=fairid%>">
<input type="hidden" id="startidx" name="startidx" value="0">
<input type="hidden" id="range" name="range" value="24">
</from>
<div id="pageBody">
<div id="home_order_tag"><font color="red"><span id="totamt"></span></font>
</div>
  <div id="order_bg"> 
	<span class="order_top"></span>
	 <div id="order_inner">
			<div class="relative01">
			 <div id="pageSum">
			 <span>每页显示数量:</span>
				<a title="每页显示数量:12" href="javascript:fair.displaymyorder(12)" id="per_12">12</a>
				<a title="每页显示数量:24" href="javascript:fair.displaymyorder(24)" class="now_page" id="per_24">24</a>
				<a title="每页显示数量:36" href="javascript:fair.displaymyorder(36)" id="per_36">36</a></div>
			<div class="page_out"><div class="page" id="pagechoosetop"></div></div>
						</div>
			<div class="clear"></div>
			<div id="myorder"></div>
			<div class="clear"></div> 
			<div class="page page1" id="pagechoosebottom"></div></div>
	<span class="order_btm clear"></span>	
</div>
</div>	
<table>
	<tr>
		<td>
		  <script>
		   	jQuery(document).ready(function(){
		   		   fair.myorder();
		   		});
           </script>	
		</td>
	</tr>
</table>
<%@ include file="/html/nds/fair/bottom.jsp" %>
