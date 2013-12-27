<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	/**
     * Things needed in this page:
     *  table* - table id 
     */
	String tabName=PortletUtils.getMessage(pageContext, "switch-config",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<script language="JavaScript" src="/html/nds/js/formkey.js"></script>
<script type='text/javascript' src='/html/nds/js/util.js'></script> 
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<!--script language="javascript" src="/html/nds/js/application.js"></script>
<script language="javascript" src="/html/nds/js/alerts.js"></script-->
<script language="javascript" src="/html/nds/js/qlc.js"></script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    
	TableManager manager=TableManager.getInstance();
	int tableId= ParamUtils.getIntAttributeOrParameter(request, "table", -1);
	boolean isAdmin= userWeb.isAdmin();
	nds.web.config.QueryListConfig qlc=userWeb.getDefaultQueryListConf(tableId);	
	int myqlcId=qlc.getId();
%>
<br>
<table border="0" cellspacing="5" cellpadding="0" align="center" width="90%"><tr>
    <td align='left'><%=PortletUtils.getMessage(pageContext, "select-query-list-config",null)%></td></tr>
        	
<%		
	//key:id of QueryListConfig, value:Object[2] 1 is name of QueryListConfig, 2 is isDefault(boolean)
	PairTable pt=nds.web.config.QueryListConfigManager.getInstance().getQueryListConfigs(tableId,false);
	for(int i=0;i<pt.size();i++){
		int id=Tools.getInt( pt.getKey(i),-2);
		Object[] v= (Object[])pt.getValue(i);
		String name= (String)v[0];
		boolean isDefault= (Boolean)v[1];
%>
	 <tr><td align='left'>&nbsp; &nbsp;-- <%=(myqlcId==id?"<img src='/html/nds/images/ok.gif'>":"")%>&nbsp;<a href="javascript:qlc.switchView(<%=id%>)"><%=(isDefault?"<b>"+name+"</b":name)%></a>
	 	&nbsp;
	 	<%if(isAdmin){%>
	 		(<a href="javascript:qlc.modify(<%=id%>)"><%=PortletUtils.getMessage(pageContext, "modify",null)%></a>)
	 	<%}%>	
	 	</td></tr>
<%       
    }
%>
	 <tr><td align='left'>&nbsp; &nbsp;-- <%=(myqlcId==-1?"<img src='/html/nds/images/ok.gif'>":"")%>&nbsp;<a href="javascript:qlc.switchView(-1)">DEFAULT</a>
	 	&nbsp;
	 	</td></tr>
	 <tr><td>
	 	<input type="button" class="cbutton" value="<%=PortletUtils.getMessage(pageContext, "object.newobject",null)%>" onclick="javascript:qlc.modify(-1)"/>
	 	<input type="button" class="cbutton" value="<%=PortletUtils.getMessage(pageContext, "close",null)%>" onclick="javascript:qlc.tryClose('popup-iframe-0')"/>
	 </td></tr>	
</table>
    </div>
</div>
<script>
jQuery(document).ready(function(){
	qlc=new QueryListConfig();
	qlc.setTable(<%=tableId%>);
});		
</script>
<%@ include file="/html/nds/footer_info.jsp" %>
