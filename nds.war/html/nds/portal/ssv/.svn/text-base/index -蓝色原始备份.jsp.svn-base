<%@ page language="java" import="java.util.*,nds.velocity.*,org.json.JSONArray,org.json.JSONObject" pageEncoding="utf-8"%>
<%@page errorPage="/html/nds/error.jsp"%>
<%@include file="/html/nds/common/init.jsp"%>

<%! 
 private static int intervalForCheckTimeout=Tools.getInt(((Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS)).getProperty("portal.session.checkinterval","0"),0);
%>
<%
 
 if(userWeb==null || userWeb.getUserId()==userWeb.GUEST_ID){ 	
 	response.sendRedirect("/c/portal/login");
 	return;
 }
 if(!userWeb.isActive()){
 	session.invalidate();
 	com.liferay.util.servlet.SessionErrors.add(request,"USER_NOT_ACTIVE");
 	response.sendRedirect("/login.jsp");
 	return;
 }

String dialogURL=request.getParameter("redirect");
if(nds.util.Validator.isNull(dialogURL)){
	Boolean welcome=(Boolean)userWeb.getProperty("portal.welcome",Boolean.TRUE);
	if(welcome.booleanValue()){
		dialogURL= userWeb.getWelcomePage();
		//userWeb.setProperty("portal.welcome",Boolean.FALSE);
	}
}
 WebClient myweb=new WebClient(37, "","burgeon",false);
//下面是查找公司新闻的几个栏目
    String	other_str=(String)QueryEngine.getInstance().doQueryOne("select description  from AD_LIMITVALUE t where t.ad_limitvalue_group_id=(select id from AD_LIMITVALUE_GROUP t2 where t2.name='PORTAL_NEWS')   and t.value='other'");
    String	industry_str=(String)QueryEngine.getInstance().doQueryOne("select description  from AD_LIMITVALUE t where t.ad_limitvalue_group_id=(select id from AD_LIMITVALUE_GROUP t2 where t2.name='PORTAL_NEWS')   and t.value='industry'");
    String	latest_str=(String)QueryEngine.getInstance().doQueryOne("select description  from AD_LIMITVALUE t where t.ad_limitvalue_group_id=(select id from AD_LIMITVALUE_GROUP t2 where t2.name='PORTAL_NEWS')   and t.value='latest'");
    String	company_str=(String)QueryEngine.getInstance().doQueryOne("select description  from AD_LIMITVALUE t where t.ad_limitvalue_group_id=(select id from AD_LIMITVALUE_GROUP t2 where t2.name='PORTAL_NEWS')   and t.value='company'");
    //通过表来获得跳转的子系统ssid号
     int	V_AUDITBILL_id=Tools.getInt(QueryEngine.getInstance().doQueryOne("select a.ad_subsystem_id from ad_tablecategory a,ad_table b where a.id=b.ad_tablecategory_id and b.name='V_AUDITBILL'"),-1);
     int	U_NOTE_id=Tools.getInt(QueryEngine.getInstance().doQueryOne("select a.ad_subsystem_id from ad_tablecategory a,ad_table b where a.id=b.ad_tablecategory_id and b.name='U_NOTE'"),-1);
%>
<%!	
 	private final static int MAX_SUBJECT_LENGTH_NARROW_1024=30;
 	private final static int MAX_SUBJECT_LENGTH_WIDE_1024=50;
 	private final static int MAX_SUBJECT_LENGTH_MAX_1024=100;
 	private final static int MAX_SUBJECT_LENGTH_NARROW_800=24;
 	private final static int MAX_SUBJECT_LENGTH_WIDE_800=40;
 	private final static int MAX_SUBJECT_LENGTH_MAX_800=80;	
%>
<%
String curTime=String.valueOf(System.currentTimeMillis());
java.text.DateFormat df =((java.text.SimpleDateFormat)QueryUtils.dateFormatter.get());// new java.text.SimpleDateFormat("MM-dd HH");
//df.setTimeZone(timeZone);

//TableManager manager=TableManager.getInstance();
int startIndex= 0;
if(startIndex<0) startIndex=0;
boolean isOut= "Y".equals( QueryEngine.getInstance().doQueryOne("select is_out from users where id="+ userWeb.getUserId()));
boolean showAssignment=false;
 QueryResult result;
 int oid, recordId,tableId;
 String recordDocNo, brief,processName; 
 String  creationDate=null;
 int recordCount,i, maxTitleLength; 
 int serialno,relativeIdx=-1;
 Table table;
 //int phaseInstanceTableId=manager.getTable("au_phaseinstance").getId();
 int pageRecordCount;
 String className,assigneeName=null;
 int assigneeId=-1;
FKObjectQueryModel fkQueryModel=new FKObjectQueryModel(TableManager.getInstance().getTable("users"), "assignee",null); 
fkQueryModel.setQueryindex(-1);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/html/nds/portal/ssv/top_meta.jsp" %>

<script>
<%
	// check whether to check timeout for portal page
	if(intervalForCheckTimeout>0){
%>	
	setInterval("checkTimeoutForPortal(<%=session.getMaxInactiveInterval()%>)", <%=intervalForCheckTimeout*60000%>);
<%}
	if(nds.util.Validator.isNotNull(dialogURL)) {
%>	
	popup_window("<%=dialogURL%>");
<%}
%>	
</script>	
		   <script type="text/javascript">
		
		   jQuery(function(){
		  jQuery(".all_news .news").css('opacity','0.1');
		    jQuery(".all_news .news").hide(100).animate({opacity: '0.1'}, '50');
			jQuery(".all_news .news:first").show(100).animate({opacity: '1'}, '50');
		   jQuery("h2").click(function(){
					if(jQuery(this).next().css('opacity','0.1')){
						jQuery(".all_news .news").not(jQuery(this).next()).hide(100).animate({opacity: '1'}, '50');
				  	    jQuery(this).next().slideDown(100).animate({opacity: '1'}, '50');
				    }
		     });
			jQuery("h2").click(function(){
					jQuery("h2").not(jQuery(this).next()).removeClass("minus");
					jQuery(this).toggleClass("minus","switch");
				})
							
				
		    });
		    
		    
		  </script>
		  
</head>
<body>
	
<div class="header">
	<div class="logo"><img src="/html/nds/portal/ssv/images/logo.gif" /></div>
    
    <div class="welcom">
       <span class="lines"><span style="font-weight: bold"><%=user.getGreeting()%>&nbsp;&nbsp;│</span></span> 
       <%if(session.getAttribute("saasvendor")==null){
		     //alisoft does not allow home page and logout, change password
			 %>
			  <a class="top-text" href="/"><%=PortletUtils.getMessage(pageContext, "home",null)%></a>&nbsp;&nbsp;|&nbsp;
			<%}%>                              
		<!--	<a class="top-text" href="javascript:showObject('/html/nds/option/option.jsp',null,null,{maxButton:false,closeButton:false})"><%= PortletUtils.getMessage(pageContext, "option_setting",null)%></a>&nbsp;|&nbsp;
			<a class="top-text" href="javascript:popup_window('/help/Wiki.jsp?page=Help')"><%= PortletUtils.getMessage(pageContext, "help",null)%></a>&nbsp;|&nbsp;-->
			<%if(session.getAttribute("saasvendor")==null){%>
			<a class="top-text" href="<%= themeDisplay.getURLSignOut() %>"><bean:message key="sign-out" /></a>
			<%}%>
   
    </div>
   
   
   
    <!--end welcom-->
    
</div>

<!--end header-->
<%
/**
Navigation of ss
 */
String portalHome="/html/nds/portal/portal.jsp?ss=";
TableManager manager=TableManager.getInstance();
nds.query.web.SubSystemView ssv=new nds.query.web.SubSystemView();
SubSystem ss;
%>
<div class="main-1">
	<div class="main_left-1">
    	<div class="main_box-1">
        	<div class="title-1">
            	<div class="title_left-1">&nbsp;</div>
                <h1>子系统</h1>
                <div class="title_right-1">&nbsp;</div>
            </div><!--end title-->
            <ul class="ico-1">
            		<%
				List<SubSystem> sss =ssv.getSubSystems(request, nds.query.web.SubSystemView.PERMISSION_VIEWABLE);
				for(int ii=0;ii< sss.size();ii++){
					ss=sss.get(ii);
				%>
				<li><div class="ss-1"><a href="javascript:ssv.view(<%=ss.getId()%>)" class="IMG-1"><img src="<%=ss.getIconURL()%>" border="0"/><div class="sst-1"><%=ss.getName()%></div></a></div></li>
				<%	
				}
				%>
            </ul><!--end ico-->
        </div><!--end main_box-->
        <!--待审批单据-->
        
        <div class="main_box-1">
       	  <div class="title-1">
   	      <div class="title_left-1">&nbsp;</div>
                <h1>待审批单据</h1>
                <div class="title_right-1">&nbsp;</div>
<span class="more"><a href="/html/nds/portal/portal.jsp?ss=<%=V_AUDITBILL_id%>&table=V_AUDITBILL" title="更多"><img src="/html/nds/portal/ssv/images/more.gif" /></a></span>
                </div>
            <!--end title--> 
   <form id="form1" method="POST">	
            <ul class="audit-1">
            	<input id="command" name="command" type="hidden" value="ExecuteAudit">
							<input id="auditActionType" type="hidden" name="auditAction" value="auditAction">
							<input type='hidden' name='arrayItemSelecter' value='selectedItemIdx'>
							<% 
								// maiximized one
								recordCount=5;
								maxTitleLength=MAX_SUBJECT_LENGTH_MAX_1024;
							 	result= AuditUtils.findWaitingInstances(request, recordCount, startIndex, showAssignment);
							 	pageRecordCount=result.getRowCount();
							%>

       
            	<li><span>批复：</span>
            		<input name="" type="text" class="audit_input" maxlength="255" name="comments" id="comments"/>
            		<span>
	            		<a class="imgbtn" href="javascript:void(0)" onclick="javascript:oa.submitAuditForm('accept')">
	            	  	<input name="" type="image" src="/html/nds/portal/ssv/images/login_70.gif" />
	            	  </a>
            	  </span>
            	  <span>
            	  	<a class="imgbtn" href="javascript:void(0)" onclick="javascript:pc.submitAuditForm('reject')">
            	  	  <input name="" type="image" src="/html/nds/portal/ssv/images/login_72.gif" />
            	  	</a>
            	  </span>
            	 </li>
                
              <li class="set_up"><span>代理人：</span>
              	<input name="assignee" type="text" class="audit_input" id="assignee"/>
	              	<span id="user" onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img class="login_78" align=absmiddle src="/html/nds/portal/ssv/images/find.gif" ></span>
	              	 <script>
										   createButton(document.getElementById("user"));
									 </script>              
                 
              
               <span class="zhuanpai"> <input  title="转派" type='image' value='转派' onclick="pc.submitAuditForm('assign')" src='/html/nds/portal/ssv/images/login_75.gif'>&nbsp;&nbsp;
							
                 <a href="javascript:oa.showdlg2('/html/nds/portal/ssv/setup.jsp')">
                 	      <img src="/html/nds/portal/ssv/images/set_up.gif" />
                 	     </a>
                 </span>
       
            </li>
            </ul><!--end audit-->
            <%@include file="/html/nds/portal/ssv/inc_audits_msgs.jsp"%>
            
            <ul class="docno">
            	  <li class="checkbox">
            	  	<input class='cbx' type="checkbox" id="chk_select_all" name="chk_select_all" value=1 onclick='javascript:oa.checkAll("form1",<%=pageRecordCount%>)'></li>
    
                <li class="docno_con">单据号</li>
                <li class="docno_con"><%= manager.getTable("au_process").getDescription(locale)%></li><!--工作流定义-->
                <li class="docno_con">描述</li>
                <li style="margin-left:52px;">创建日期</li>
            </ul>
            <!--end docno-->
            <div class="data">
            	<table style="border-collapse:collapse;" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tbody>
<%
   if(pageRecordCount==0){
%> 
		<tr>
					<td align="center" colspan="5" valign="top">
						没有数据
					</td>
		</tr> 	

<%}
 int userTableId= manager.getTable("users").getId();
  while(result.next()){
 	 
 	 oid=((java.math.BigDecimal)result.getObject(1)).intValue(); // au_phaseinstance.id
 	 processName= (String)result.getObject(2);
 	 tableId=((java.math.BigDecimal)result.getObject(3)).intValue();
 	 table= manager.getTable(tableId);
 	 if( table ==null){
 	 	//special condition when table is not active set by admin
 	 	continue;
 	 }
 	 /* yfzhu marked up following line since real table must not show view's records */
 	 //if(table.getRealTableName()!=null) tableId=manager.getTable(table.getRealTableName()).getId();
 	 recordDocNo= (String)result.getObject(4);
 	 recordId=Tools.getInt(result.getObject(5),-1) ; 
 	 
 	 if(Validator.isNull(recordDocNo)){
 	 	recordDocNo="[null]";
 	 }
 	  brief=StringUtils.shortenInBytes( (String)result.getObject(6), maxTitleLength);
 	 if(!showAssignment){
	 	 if(result.getObject(7) !=null){ 
	 	 	creationDate= df.format((java.util.Date)result.getObject(7));
	 	 }else{
	 	 	creationDate=StringUtils.NBSP;
	 	 }
 	 }else{
		//loading assignee information
		List al=(List)QueryEngine.getInstance().doQueryList("select u.id,u.name from users u, au_pi_user p where p.au_pi_id="+oid+" and p.ad_user_id="+ userWeb.getUserId()+" and p.assignee_id=u.id(+)").get(0);
		assigneeId= Tools.getInt( al.get(0),-1);
		assigneeName= (String)al.get(1);
 	 }
	relativeIdx++;
	className= (relativeIdx%2==1?"gamma":"gamma");
%>

                  <tr id="<%=oid%>_templaterow">
                    <td width="8%" height="24" align="center" valign="middle">
                    	<span class="checkbox">
                          <input class='cbx' type='checkbox' id='chk_obj_<%=oid%>' name='itemid' value='<%=oid%>' onclick="oa.unselectall()">
				              </span>
				            </td>
                    <td width="23%" height="24" align="center" valign="middle"><a href="javascript:oa.auditObj(<%=oid%>)"><%=recordDocNo%></a></td>
                    <td width="23%" height="24" align="center" valign="middle"><a href="javascript:oa.auditObj(<%=oid%>)"><%=processName%></a></td>
                    <td width="23%" height="24" align="center" valign="middle"><%=brief%></td>
                    <td width="23%" height="24" align="center" valign="middle">
                    <%if(showAssignment){%>
											  <a href="javascript:popup_window('/html/nds/object/object.jsp?table=<%=userTableId%>&id=<%=assigneeId%>')"><%=assigneeName%></a>
											<%}else{%>
													<%=creationDate%>
											<%}%>
				            </td>
                  </tr>
                  
 <%
 }
 int totalCount=AuditUtils.getTotalCount(request,showAssignment);
 String url="/html/nds/audit/view.jsp?showassign="+Boolean.toString(showAssignment);
%>
              </tbody>
              </table>
            </div>
       <!--end data-->
            </form>
        </div>
        
<input type='hidden' name='queryindex_-1' id='queryindex_-1' value="-1" />
    
 <!--end main_box-->
 <!--系统消息-->
 
  
        <div class="main_box-1">
       	  <div class="title-1">
   	      <div class="title_left-1">&nbsp;</div>
                <h1>系统消息</h1>
                <div class="title_right-1">&nbsp;</div>
              <span class="more">
              	 <!-- <a href="javascript:ssv.showNotes(10084);">-->
              	 <a href="/html/nds/portal/portal.jsp?ss=<%=U_NOTE_id%>&table=u_note">
              	 	 <img src="/html/nds/portal/ssv/images/more.gif" />
              	 </a>
              </span>
            </div>
            <!--/html/nds/portal/portal.jsp?ss=45&table=u_note-->
            <!--javascript:ssv.showNotes(10084);-->
            
            <!--end title-->
   <div id="dotred-im">
            <ul class="news" id="imul2">
            	 <li style="display:none" id="imul2_li_0"></li>
            	 <li style="display:none" id="imul2_li_1"></li>
            	 <li style="display:none" id="imul2_li_2"></li>
            	 <li style="display:none" id="imul2_li_3"></li>            	 
            </ul>
            <ul class="news" id="imul3">
            	 <li style="display:none" id="imul3_li_0"></li>
            	 <li style="display:none" id="imul3_li_1"></li>
            	 <li style="display:none" id="imul3_li_2"></li>
            	 <li style="display:none" id="imul3_li_3"></li>
            </ul>
            
            <!--end audit-->            
    </div>    
            <!--end audit-->
            <div class="clear"></div>
        </div>
        <!--end main_box-->     
       </div>
   <div id="cmdmsg" style="display:none;" ondblclick="$('cmdmsg').hide()"></div>
   
  <!--end main_left-->
  
  <!--begin 新闻动态-->
  
    <div class="main_right-1">
    	<div class="main_box-1">
        	<div class="title-1">
            	<div class="title_left-1">&nbsp;</div>
                <h1>新闻动态</h1>
                <div class="title_right-1">&nbsp;</div>
            </div><!--end title-->
            <div class="all_news">
                <h2 class="add minus"><%=latest_str%>：</h2><!--最新动态-->
				<ul class="news">
                    <% List latest=myweb.getList("latest","latest");
															 for(int k=0;k<latest.size();k++){
										 %> 											
											       <li>&nbsp;<a href="<%=((List)latest.get(k)).get(0)%>" class="width-text" target="_blank"><%=((List)latest.get(k)).get(1)%></a></li> 
										<%}%>	
										<span>&nbsp;<a style="color:#00548D;" class="more_news" href="/news.jsp?newsstr=latest" target="_blank">更多...</a></span> 
                </ul><!--end news-->
                <h2 class="add"><%=industry_str%>：</h2><!--行业新闻-->
                <ul class="news">
                    <% List companyportal=myweb.getList("industry","industry");
																		 for(int iii=0;iii<companyportal.size();iii++){
										 %>
																	<li>&nbsp;<a href="<%=((List)companyportal.get(iii)).get(0)%>" class="width-text" target="_blank"><%=((List)companyportal.get(iii)).get(1)%></a></li>
												<%}%>
										<span>&nbsp;<a style="color:#00548D;" class="more_news" href="/news.jsp?newsstr=industry" target="_blank">更多...</a></span> 
                </ul><!--end news-->
                <h2 class="add"><%=company_str%>：</h2><!--公司新闻-->
                <ul class="news">
                    <% List companyportal1=myweb.getList("company","company");
																		 for(int j=0;j<companyportal1.size();j++){
										 %>
															<li>&nbsp;<a href="<%=((List)companyportal1.get(j)).get(0)%>" class="width-text" target="_blank"><%=((List)companyportal1.get(j)).get(1)%></a></li>
										<%}%>
									<span>&nbsp;<a style="color:#00548D;" class="more_news" href="/news.jsp?newsstr=company" target="_blank">更多...</a></span> 
                </ul><!--end news-->
                <h2 class="add"><%=other_str%>：</h2><!--其他-->
                <ul class="news">
                    <%   List companyportal2=myweb.getList("other","latest");
																		 for(int jj=0;jj<companyportal2.size();jj++){
										%>
																	<li>&nbsp;<a href="<%=((List)companyportal2.get(jj)).get(0)%>" class="width-text" target="_blank"><%=((List)companyportal2.get(jj)).get(1)%></a></li>
									  <%}%>
									 <span>&nbsp;<a style="color:#00548D;" class="more_news" href="/news.jsp?newsstr=other" target="_blank">更多...</a></span> 
                </ul><!--end news-->
            </div><!--end all_news-->
        </div><!--end main_box-->
        
        <div class="main_box-1">
        	<div class="title-1">
            	<div class="title_left-1">&nbsp;</div>
                <h1>收藏夹</h1>
                <div class="title_right-1">&nbsp;</div>
            </div><!--end title-->
            
            	<div id="breadcrumb" style="width:99%">
            		<ul class="favorites">
	<%
	StringBuffer sb=new StringBuffer();
	TableManager tmgr=TableManager.getInstance();
	for(Iterator it=userWeb.getVisitTables();it.hasNext();){
		Table tr=tmgr.getTable( Tools.getInt( it.next(),-1));
		if(tr!=null) sb.append("<li><a style=\"color:#0000FF;font-size:12px;\" href=\"javascript:ssv.showNotes('").append(tr.getId())
			.append("')\">").append(tr.getDescription(locale)).append("</a></li>");
	}%>
	&nbsp;&nbsp;
	<%=PortletUtils.getMessage(pageContext, "my-recent-visit",null)%>:&nbsp;<%=sb.toString()%>
</div>
           
            </ul><!--end favorites-->
        </div><!--end main_box-->
    </div><!--end main_right-->
</div>

<!--end main-->
<div class="copyright">(C) 2008-2009   上海伯俊软件科技有限公司   版权所有    </div><!--end copyright-->
</body>
</html>


