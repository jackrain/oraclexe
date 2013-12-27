<%@ include file="/html/nds/common/init.jsp" %>
<%@page errorPage="/html/nds/error.jsp"%>
<%@ page import="nds.control.util.*" %>
<%@ page import="nds.web.config.*" %>
<%
/**
	@param cxtab - if set, will directly loading that cxtab search form
*/
		if(userWeb==null || userWeb.isGuest()){
			String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
			response.sendRedirect("/login.jsp?redirect="+redirect);
			return;
		}

			
   String cxtab= request.getParameter("cxtab");
   int cxtabCategoryTableId=TableManager.getInstance().getTable("ad_cxtab_category").getId();
   int cxtabTableId=TableManager.getInstance().getTable("ad_cxtab").getId();
   String func="pc.qrpt";
   String istree=userWeb.getUserOption("ISTREE","Y");
%>	
<div id="page-table-query">
	<div id="page-table-query-tab">
		<ul><li><a href="#tab1"><span><%=PortletUtils.getMessage(pageContext, "rpt-filter-setting",null)%></span></a></li></ul>
		<div id="tab1" class="ui-tabs-panel">
			<div id="rpt-search">
			<div id="rpt-search-note"><%= PortletUtils.getMessage(pageContext, "pls-select-rpt-template",null)%></div>
			</div>
		</div>
  </div>
</div>
<script type="text/javascript">
//jQuery('#rpt-search-tab ul').tabs();
jQuery('#page-table-query-tab ul').tabs();
jQuery('#page-table-query-tab ul').attr('class','ui-tabs-nav');
jQuery('#page-table-query-tab li').attr('class','ui-tabs-selected');
var istree="<%=istree%>";
 if(istree=="Y"){
webFXTreeConfig.autoExpandAll=false;
pc.createTree("<%= PortletUtils.getMessage(pageContext, "report-center",null)%>", "/html/nds/common/tree2.xml.jsp?tbstruct=<%=cxtabCategoryTableId%>&tbdata=<%=cxtabTableId%>&fnc=<%=func%>");
}else{
	 jQuery.post("/html/nds/common/rptaccord.jsp?tbstruct=<%=cxtabCategoryTableId%>&tbdata=<%=cxtabTableId%>&fnc=<%=func%>",
   function(data){
     var result=data;
     jQuery("#tree-list").html(result.xml);
     jQuery("#tree-list").css("padding","0");
     jQuery("#tab_accordion").accordion({ header: "h3",collapsible:true,autoHeight:false,navigation:true});
   });
}
<%
  if(nds.util.Validator.isNotNull(cxtab)){
%>
	pc.qrpt("<%=cxtab%>");
<%}%>
</script>


