<%@ include file="/html/nds/common/init.jsp" %>

<%
/**
  @param 
  	optiononly - default to false, when "true", will hide "color", "password", "cancle" setting
*/
boolean optionOnly=  "true".equals(request.getParameter("optiononly"));
int userid=userWeb.getUserId();
List params1= QueryEngine.getInstance().doQueryList("select name,value from ad_user_pref where ad_user_id="+userid+" and module='ad_option'");
ArrayList validCommands=new ArrayList();
String name,desc,comments, valuetype, nullable, url,type, inputType,valuedefault, value,description;
int orderno, columnId, valuelength,limitvalueGroupId,flag;
%> 
<%
 if(userWeb==null || userWeb.getUserId()==userWeb.GUEST_ID){
 	out.print("Please login as authenticated user");
 	return;
 }
TableManager manager=TableManager.getInstance();
QueryEngine engine =QueryEngine.getInstance();
String title= PortletUtils.getMessage(pageContext, "user_option_setting",null);
List params= QueryEngine.getInstance().doQueryList("select name,description,comments,orderno,ad_column_id,valuetype,valuelength,nullable,valuedefault,ad_limitvalue_group_id from ad_option  order by orderno asc");
%>
<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=title%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="enable_context_menu" value="true" />	
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<!--iframe id=CalFrame name=CalFrame frameborder=0 src=<%=NDS_PATH%>/common/calendar.jsp style=display:none;position:absolute;z-index:99999></iframe-->
<script language="javascript">
document.bgColor="<%=colorScheme.getPortletBg()%>";
</script>
<script>
function optionsave(){
	var form=form1;	
<%
	if(params!=null)for(int i=0;i<params.size();i++){
		boolean isMandatory=(!"Y".equals( (String)((List)params.get(i)).get(7)));
		name= (String)((List)params.get(i)).get(0);
		desc= (String)((List)params.get(i)).get(1);
	    columnId= Tools.getInt(((List)params.get(i)).get(4),-1);
		valuetype=(String)((List)params.get(i)).get(5);
		if (Validator.isNull(valuetype)) valuetype="S";
		limitvalueGroupId= Tools.getInt(((List)params.get(i)).get(9),-1);
		if(isMandatory){
			if(limitvalueGroupId==-1){
			   if(columnId!=-1){
			      out.println(" if(!checkNotNull(document.getElementById(\"column_"+columnId+"\"),\""+desc+"\")) return false;");
			    }else{
		    	out.println(" if(!checkNotNull(document.getElementById(\""+name+"\"),\""+desc+"\")) return false;");
		    	}
			}else{
				out.println(" if(!checkSelected(document.getElementById(\""+name+"\"),\""+desc+"\")) return false;");
			}
		}
		
		if("N".equals(valuetype)){
		 if(columnId!=-1){
		    out.println(" if(!checkIsNumber(document.getElementById(\"column_"+columnId+"\"),\""+desc+"\")) return false;");
			    }else{
			out.println(" if(!checkIsNumber(document.getElementById(\""+name+"\"),\""+desc+"\")) return false;");
			}	
		}else if("D".equals(valuetype)){
			 if(columnId!=-1){
			 out.println(" if(!checkIsDate(document.getElementById(\"column_"+columnId+"\"),\""+desc+"\")) return false;");	
			    }else{
			out.println(" if(!checkIsDate(document.getElementById(\""+name+"\"),\""+desc+"\")) return false;");	
			}
		}	
	}
%>    
    
	
}
</script>
<!--script language="JavaScript" src="/html/nds/js/formkey.js"></script-->
<!--script language="javascript" src="<%=NDS_PATH%>/js/calendar.js"></script-->
<script language="JavaScript" src="/html/nds/js/option.js"></script>
<!--script type='text/javascript' src='/html/nds/js/util.js'></script> 
<script type="text/javascript" src="/html/nds/js/dwr.Controller.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.engine.js"></script>
<script type="text/javascript" src="/html/nds/js/dwr.util.js"></script>
<script language="javascript" src="/html/nds/js/application.js"></script>
<script language="javascript" src="/html/nds/js/alerts.js"></script-->
<script language="javascript" src="/html/nds/js/init_optioncontrol_<%=locale.toString()%>.js"></script>
<%if(optionOnly){%>
<div style="padding:20px 20px 10px 15px;">
	<%= PortletUtils.getMessage(pageContext, "welcome-to-option",null) %>
</div>	
<%}%>
<form name="form1" id="form1" method="post">
<div id="tabs">
	<% if(params.size()==0){%>
	<ul>
		<li><a href='#tab1'><span><%= PortletUtils.getMessage(pageContext, "color_option",null) %></span></a></li>
	</ul>
	<div id='tab1'>
		<%@ include file="/html/nds/option/inc_color_list.jsp" %>
	</div>
  	<%} else{%>
	<ul>
		<li><a href='#tab1'><span><%= PortletUtils.getMessage(pageContext, "user_option",null) %></span></a></li>
	<%if(!optionOnly)
		//取消界面配色模块
	{%>
		<!--li><a href='#tab2'><span><%= PortletUtils.getMessage(pageContext, "color_option",null) %></span></a></li-->
	<%}%>
    </ul>		
	<div id='tab1'><br>
	  <%@ include file="/html/nds/option/inc_ad_option.jsp" %>
	  <br>
	</div>
	<%if(!optionOnly)
	//取消界面配色模块
	{%>
	<!--div id='tab2'>
		 <%@ include file="/html/nds/option/inc_color_list.jsp" %>
	</div-->
	<%}
	}%>
</div>	
  <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input class="cbutton" type="button"  value='<%= PortletUtils.getMessage(pageContext, "command.ok",null)%>' onclick="uc.saveAll();"/>
<%if(!optionOnly){%>
  <input class="cbutton" type="button" value='<%= PortletUtils.getMessage(pageContext, "command.cancel",null)%>' onclick="javascript:uc.tryClose();"/> &nbsp;&nbsp;
  <%if(session.getAttribute("saasvendor")==null){
		//alisoft does not allow home page and logout, change password
	%>
  <input class="cbutton" type="button" value='<%= PortletUtils.getMessage(pageContext, "change-password",null)%>' onclick="popup_window('/html/nds/security/changepassword.jsp?objectid=<%=userid%>')"/>
  <%}%>
<%}%>
</form> 
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
<br><br><br><br>
<font size=1>&nbsp;&nbsp;&nbsp;session id:<%=session.getId()%></font>
<%@ include file="/html/nds/footer_info.jsp" %>
