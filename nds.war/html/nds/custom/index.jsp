<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>
<%
	UserWebImpl userWeb =null;
	try{
		userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
	}catch(Throwable userWebException){
		System.out.println("########## found userWeb=null##########"+userWebException);
	}
	String path=null;
	if(userWeb!=null){
		path=userWeb.getThemePath()+"/images/topflow.gif";
	}
%>
<img src="<%=path%>" border="0" usemap="#Map" />
<map name="Map" id="Map">
  <area shape="rect" coords="239,307,340,365" href="javascript:pc.navigate('/html/nds/portal/subsystem.jsp?id=9')" />
  <area shape="rect" coords="239,147,339,202" href="javascript:pc.navigate('/html/nds/portal/subsystem.jsp?id=11')" />
  <area shape="rect" coords="658,274,753,333" href="javascript:pc.navigate('/html/nds/portal/subsystem.jsp?id=14')" />
  <area shape="rect" coords="363,418,460,473" href="javascript:pc.navigate('/html/nds/portal/subsystem.jsp?id=8')" />
  <area shape="rect" coords="580,396,680,454" href="javascript:pc.navigate('/html/nds/portal/subsystem.jsp?id=16')" />
  <area shape="rect" coords="441,32,541,91" href="javascript:pc.navigate('/html/nds/portal/subsystem.jsp?id=13')" />
  <area shape="rect" coords="639,126,738,183" href="javascript:pc.navigate('/html/nds/portal/subsystem.jsp?id=15')" />
</map>



