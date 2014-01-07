<%@ page language="java" import="nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*" pageEncoding="utf-8"%>
<table cellpadding="0" cellspacing="0" width="100%">
	<!--tr>
	<div class="search">子系统查找</div>
	<div id="searchform"> 
		<input type="text" id="pojam" class="pinput" name="pojam"/>
	  <input type="submit" value="查找" class="pbutton" name="search"/>
	</div></tr-->
	<tr>
		<td id="cont">
		<div style="height:100%;">
		<%
		String istree=userWeb.getUserOption("ISTREE","Y");
		//System.out.println(istree);
		if("N".equalsIgnoreCase(istree)){
		//System.out.println("ASDFASDFASDF");
		%>
		<div><div id="rpt-list-outlook">
		<%
		}else{
		%>
			<div class="smalltab">
				 <ul class="gamma-tab">
					<li class="current"><%= PortletUtils.getMessage(pageContext, "feature-list",null)%>
					</li>
				</ul>
				<div id="rpt-list-content" >
						<!--%//((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("chatback","")%-->
		<%
		}
		%>
					<div id="tree-list"></div>
						</div>
				</div>
			</div>
			</div>
		</td>
</tr>
<tr>
<td id="weather"></td>
</tr>
<tr style="display:none;">
<td>
	<div id="bottom_tab">
		 <ul>
        <li><a href="#tabs-1">我的状态</a></li>
        <li><a href="#tabs-2">通知</a></li>
    </ul>
   <div id="tabs-1">
   	<!--div class="content">
                    <div class="profilePic"><img src="http://devgrow.com/wp-content/themes/cleanscreen/img/profile_pic.png"></div>
                    <p><strong>JACK DEV</strong>亲爱的管理员欢迎光临JACK DEV系统 
                    	<a href="" target="_blank">Jack dev</a>.</p>
                      <ul class="socialConnect">
                        <li><a href="/c/portal/logout" class="zy" target="_blank">注销</a></li>
                        <li><a onclick="javascript:showObject('/html/nds/option/option.jsp',null,null,{ispop:false,closeButton:false});" class="sj" target="_blank">设置</a></li>
                        <li><a href="/html/nds/portal/portal.jsp" class="cd" target="_blank">菜单</a></li>
                    </ul>
   </div-->
   	</div>
	 <div id="tabs-2">
<!--liferay-ui:tabs names="mynotice"-->
	<%
	request.setAttribute("nds.portal.listconfig", "mynotice");
	%>
	<jsp:include page="/html/nds/portal/portletlist/view.jsp" flush="true"/>

<!--/liferay-ui:tabs-->	
</div>
</div>
<script>
	jQuery( "#bottom_tab" ).tabs();
</script>
</td>
</tr>
</table>