<%@ page language="java" import="java.util.*,nds.fair.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<% 
   /*
    *该页面接收两个参数 pdtid和fairid
    *fairid 表示当前订货会的Id;
    *pdtid 表示显示商品的Id;
    */
     FairManager fairmanager =FairManager.getInstance();
    int pdtid= Tools.getInt(request.getParameter("pdtid"),-1);
    int fairid=Tools.getInt(request.getParameter("fairid"),-1);  
    if(pdtid==-1){
        throw new NDSException("您还没有选择商品！");	
     }
     if(fairid==-1){
       throw new NDSException("您还没有订货会！");
      }
 %>
  <%@ include file="/fair/top.jsp" %>
<div id="pageBody">
<div class="crumb">
<% 
   
   List CategoryOne =QueryEngine.getInstance().doQueryList("select m_dim3_id,value from m_product where id="+pdtid);
   int id=Tools.getInt(((List)CategoryOne.get(0)).get(0),-1);
   String attribname =(String)QueryEngine.getInstance().doQueryOne("select t.attribname from m_dim t where t.id="+id);
   String pdtvalue=(String)((List)CategoryOne.get(0)).get(1); 
    if(attribname==null){ 
    attribname="";
    }
    if(pdtvalue==null){
    pdtvalue ="";
     }
%>
<a target="_self" href="/fair/index.jsp?fairid=<%=fairid%>">首页</a>&gt;&gt;&nbsp;<a href="/fair/index.jsp?categoryid=<%=id%>&fairid=<%=fairid%>"><%=attribname%></a>&gt;&gt;&nbsp;<%=pdtvalue%>
</div>
<script type="text/javascript" src="jquery_002.js"></script>
<div id="all_view_detailx" style="visibility: visible;">
		<ul style="width: 1416px; left: 0pt;" id="mycarousel" class="jcarousel-list jcarousel-skin-tango">
	 </ul>
 </div>
	  <div id="product_list">
		<span class="de_logo">
							<a href="/fair/index.jsp?fairid=<%=fairid%>"><img src="images/company_logo.gif" width="179" height="73" /></a>
		</span>
		    <div class="list_inner">
						<h2 class="bold">商品搜索</h2>
						<p class="public_notic"><input id="srinfox" name="srinfox" type="text" maxlength="255" onKeyPress="javascript:fair.onReturn_order(event);"/></p>
						<p class="public_notic"><a href="javascript:fair.search_order();"><image src="/fair/images/search.gif" class="inputMain" border="0" /></a></p>
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
<li><a  target="_self" href="/fair/index.jsp?categoryid=<%=pci.getCategoryId()%>&fairid=<%=fairid%>" ><%=pci.getName()%> <span class="graytxt">(<%=pci.getCnt()%>款)</span></a></li>
<%
}}
%>
</ul>
</div>
		<span class="list_btm"></span>
</div>
<input type="hidden" id="fairid" name="fairid" value="<%=fairid%>">
<input type="hidden" id="range" name="range" value="24">  
<input type="hidden" id="categoryid" name="categoryid" value="">
<input type="hidden" id="querytype" name="querytype" value="all">
<input type="hidden" id="startidx" name="startidx" value="0">
<input type="hidden" id="tag" name="tag" value="">
<input type="hidden" id="pdtid" name="pdtid" value="">   
<div id="content">	  
<div id="detail_view_hint">
	<img src="images/viewitem_top_hint_left.gif" style="margin-right: -3px;" class="viewitem_top_hint_arrow" align="absmiddle">
	<span class="viewitem_top_hint_ce">
	<span id="customeinfo" style="color: rgb(122, 122, 122);"></span>
	</span>
	<img src="images/viewitem_top_hint_right.gif" class="viewitem_top_hint_arrow" align="absmiddle">		
</div>
<div id="detail_view">
	<span class="view_top"></span>
	   <div id="item_view_img">
		<div class="pro_view"><img src="" alt="" name="view_big" id="view_big"></div>
		  <input type="hidden" name="color_default" id="color_default" value="">
		   <div id="p_img">
		   </div>
		<div class="pro_small" id="pro_small">
	    </div>				
</div>
<form id="p_form" name="p_form" method="post">
				<div class="item_view_content">
				 <h1 id="p_name"></h1>
					<h3>货号：<span id="p_code"></span></h3>
											<div class="content_line"></div>
						<h3>价格：<span id="p_price" class="cost"></span>元<span id="p_discount"></span><span class="decount_price" id="p_marketprice"></span> 
						</h3>
										<div class="content_line"></div>
					<h3>材质：<span id="p_material"></span></h3>
										<div class="content_line"></div>
										<h3>数量：<span id="cnt" class="cost"></span></h3>
										<h3>金额：<span id="totamt" class="cost"></span>元</h3>
										<div>
	<p class="graytxt relative" style="padding: 2px 0px 0px 10px; top: 10px; text-align: left; width: 310px; text-indent: 0pt;">
		<ul class="outline">              	
            <li style="cursor: pointer;font-size:13px;font-weight:bold;color: rgb(122, 122, 122);">该商品的信息
                 <ul style="display: block;font-size:12px;font-weight:normal;color: rgb(122, 122, 122); ">
                	 <li id="desc" style="padding: 0px 0px 0px 23px;">
                       </li>
                 </ul>
	        </li>
       </ul>		
		</p>
</div>
				</div>			
</form>
										<div class="relative02" >
											<form id="p_form" name="p_form" method="post">
										    <div id="p_matrix" style="overflow-x:auto;width:100%;text-algin:center;"></div>
										   </form>
										  <br/><div align="right"><a onclick="fair.saveorder();"><img src="images/btn_news.gif" width="72" height="24"  border="0"/></a></div>
										  </div>
				<span class="view_btm clear"></span>
			
			</div>

<div class="crumb_view">
	建议搭配
</div>
<div id="all_view_detail" style="visibility: visible;">
		<ul style="width: 1416px; left: 0pt;" id="mycarouse2" class="jcarousel-list jcarousel-skin-tango01">
		</ul>
 </div>
<div id="detail_view_match" style="display:none">
				<span class="view_top"></span>
				<div id="item_view_img">
					<div class="pro_view"><img src="images/color_image_577_thumb_01.jpg" alt="" name="view_big_match" width="273" height="351" id="view_big_match"></div>
					<input type="hidden" name="color_default_match" id="color_default_match">
					<div id="p_img_match">
		   </div>
				<div class="pro_small" id="pro_small_match"><img src="images/images_d_thumb.jpg" alt="" width="49" height="63" onmouseover="javascript:document.getElementById('view_big_match').src='images/images_a_thumb.jpg'" onmouseout="javascript:document.getElementById('view_big_match').src=document.getElementById('color_default_match').value;">						
				  </div>			
				</div>
       <form  name="p_form_match" id="p_form_match" method="post" >
				<div class="item_view_content">
				   <h1 id="p_name_match"></h1>
				    <input type="hidden" id="match_id" name="match_id">
					<h3>货号：<span id="p_code_match"></span></h3>
											<div class="content_line"></div>
						<h3>价格：<span id="p_price_match" class="cost"></span>元<span id="p_discount_match"></span><span class="decount_price" id="p_marketprice_match"></span> 
						</h3>
										<div class="content_line"></div>
					<h3>材质：<span id="p_material_match"></span></h3>
										<div class="content_line"></div>
											<h3>数量：<span id="cnt_match" class="cost"></span></h3>
											<h3>金额：<span id="totamt_match" class="cost"></span>元</h3>
										<div>
	<p class="graytxt relative" style="padding: 2px 0px 0px 10px; top: 10px; text-align: left; width: 310px; text-indent: 0pt;">
		<ul class="outline">              	
            <li style="cursor: pointer;font-size:13px;font-weight:bold;color: rgb(122, 122, 122);">该商品的信息
                 <ul style="display: block;font-size:12px;font-weight:normal;color: rgb(122, 122, 122); ">
                	 <li id="desc_match" style="padding: 0px 0px 0px 23px;">
                       </li>
                 </ul>
	        </li>
       </ul>		
		</p>
</div>
				</div>
 </form>
  <div class="relative02">
											<div id="p_matrix_match" style="overflow-x:auto;width:670px;"></div>
								
										  <br/><div align="right"><a onclick="javascript:fair.saveorder_match();"><img src="images/btn_news.gif" width="72" height="24" /></a></div>
										</div>
				<span class="view_btm clear"></span>
</div>

</div>
</div>	
</div>
<table>
	<tr>
		<td>
		  <script>
		   	jQuery(document).ready(function(){
		   		fair.loadOneFairObject(<%=pdtid%>);
		   		outlineInit();
		   		});
           </script>	
		</td>
	</tr>
</table>
<%@ include file="/fair/bottom.jsp" %>