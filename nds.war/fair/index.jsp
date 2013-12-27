<%@ page language="java" import="java.util.*,nds.fair.*" pageEncoding="utf-8"%> 
<%@ include file="/html/nds/common/init.jsp" %><% 
 /*
  *该页面接收两个参数 fairid 和categoryid;
  *fairid 是当前订货会的Id;
  *categoryid 是第二个页面传递选择大类的时候将其参数传递进来;
  *如果categoryid 为-1的话就会按照订货会的Id显示，默认会取最近修改的那个;
 */
  FairManager fairmanager =FairManager.getInstance();
  int fairid= Tools.getInt(request.getParameter("fairid"),-1);
  int categoryid= Tools.getInt(request.getParameter("categoryid"),-1);
  String srinfo=(String)request.getParameter("srinfo");
%>
<%@ include file="/fair/top.jsp" %>
<% 	
   String	fairdec =(String)QueryEngine.getInstance().doQueryOne("select des from b_fair where id="+fairid);
%>
<form>
<input type="hidden" id="fairid" name="fairid" value="<%=fairid%>">
<input type="hidden" id="categoryid" name="categoryid" value="">
<input type="hidden" id="querytype" name="querytype" value="all">
<input type="hidden" id="startidx" name="startidx" value="0">
<input type="hidden" id="tag" name="tag" value="">  
<input type="hidden" id="range" name="range" value="24"> 
</form>
<div id="pageBody">
<div id="news" class="fright">
				  	<h2>订货会主题</h2>
		<ul>
			
		<li id="fairdesc"><%=fairdec%></li>
		</ul>
		<div id="post">
		<!--<div class="post1"><img src="images/ln_buttom_1202.gif" width="104" height="87" /></div>
		<div class="post2"><img src="images/christmas_gift.gif" width="94" height="87" /></div>-->
		</div>	
</div>
<div id="leadspace_container">
<img style="display: none; opacity: 0.9999;" src="/fair/images/40_1228383443.jpg" usemap="#js_home_banner_map3" width="650" height="192">
<a href="/fair/index.jsp" target="_blank"><img style="display: block; opacity: 0.9999;" class="js_home_banner" id="js_home_banner_2" src="images/40_1228383443.jpg" width="650" height="192"></a>
</div>
<div><span>&nbsp;
</span></div>
<div id="product_pageBody">
	  <div id="product_list">
		 <span class="de_logo">
		     <a href="/fair/index.jsp?fairid=<%=fairid%>"><img src="images/company_logo.gif" width="179" height="73" /></a>
		</span>
    				<div class="list_inner">
						<h2 class="bold">商品搜索</h2>
						<p class="public_notic"><input id="srinfo" name="srinfo" type="text" maxlength="255" onKeyPress="fair.onReturn_index(event);"/></p>
						<p class="public_notic"><a href="javascript:fair.search_index();"><image src="/fair/images/search.gif" class="inputMain" border="0" /></a></p>
						</div> 
						<span class="list_btm"></span>
						<span class="de_logo1">按分类选择</span>
	  <div class="list_inner">
<ul class="main">
<%
 List productcatagory=fairmanager.getProductCategoryList(fairid);
 ProductCategoryItem pci=null;
  if(productcatagory.size()!=0){
   for(int j=0;j<productcatagory.size();j++){
    pci=(ProductCategoryItem)productcatagory.get(j); 
%>
<li><a href="javascript:fair.productcategory(<%=pci.getCategoryId()%>)" ><%=pci.getName()%> <span class="graytxt">(<%=pci.getCnt()%>款)</span></a></li>
<%
}}
%>
<li>
</ul>
</div>
	<span class="list_btm"></span>
</div>	
<div id="brand_view">
<ul id="brand_menu">
			<li><a href="javascript:fair.fasionproduct();" id="hotproduct">最热商品</a></li>
			<li><a href="javascript:fair.allproduct();" id="allproduct" class="current">所有商品</a></li>
			<li><a href="javascript:fair.leastproduct();" id="leastproduct">最少订货</a></li>
</ul>
</div>	
<div id="detail_view"> 
	<span class="view_top"></span>
	 <div id="detail_view_inner"></div>
	  <span class="view_btm clear"></span>
   </div>
</div>	
</div>
<table>
	<tr>
		<td>
			<%if(categoryid!=-1){%>	
			 <script>	  
			  	 jQuery(document).ready(function(){fair.productcategory(<%=categoryid%>)});
           </script>
            <%}else if(srinfo!=null&&!srinfo.equals("")){%>
              <script>		
              jQuery(document).ready(function(){fair.searchproduct("<%=srinfo%>")});
              </script>	
             <%}else{%>
              <script>	  
			 	         	jQuery(document).ready(function(){fair.loadFairObject()});
              </script>
           <%}%>
		</td>
	</tr>
</table>
<%@ include file="/fair/bottom.jsp" %>
