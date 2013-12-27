<%@ page language="java" import="nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*" pageEncoding="utf-8"%>
<div id="objdropmenu" class="">
<ul id="css3menu1" class="topmenu">
<li class="topmenu">
	<a style="height:32px;line-height:32px;">
		<span><img src="/html/nds/images/qiehuan.png" alt="子系统菜单">系统切换</span>
	</a>
<ul>
<%
SubSystem ss;
String currentSubSystemMark;
List<SubSystem> sss =ssv.getSubSystems(request, nds.query.web.SubSystemView.PERMISSION_VIEWABLE);
for(int i=0;i< sss.size();i++){
	ss=sss.get(i);
	if(ss.getId()==ssId){
		currentSubSystemMark="/html/nds/images/check.png";
	}else currentSubSystemMark="/html/nds/images/lab.png";
%>
<li><a href="javascript:pc.ssv(<%=ss.getId()%>)">
	<img src="<%=currentSubSystemMark%>" alt="check">
	<%=ss.getName()%></a></li>
<%	
}%>
<li><a href="javascript:window.location='/html/nds/portal/ssv/index.jsp'">
<img src="/html/nds/images/showlist.gif" alt="check">
<%= PortletUtils.getMessage(pageContext, "subsystem-view",null)%></a></li>
</ul></li></ul>
</div>
		


