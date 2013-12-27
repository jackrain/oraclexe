<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="nds.control.web.WebUtils,nds.db.oracle.QueryRequestImpl" %>
<%@ page import="nds.control.web.UserWebImpl" %>
<%@ page import="nds.schema.TableManager" %>
<%@ page import="nds.schema.TableImpl,nds.util.Configurations,nds.control.web.WebUtils" %>
<%@ page import="java.text.SimpleDateFormat,nds.query.*,org.json.*,java.io.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);	
    String generateHTML=request.getParameter("generateHTML");
    boolean isGeneHl=null==generateHTML?false:true;
    String storeName=isGeneHl?"webpos":null;
    String storeId=isGeneHl?"-1":null;
    String userName=isGeneHl?"webpos":null;
  	int userId=-1;
  //Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor(nds.util.WebKeys.CONFIGURATIONS);
  session.setMaxInactiveInterval(144000);
  String time=null;
  String mochineCode="";
  if(!isGeneHl){
		storeName=(String)session.getAttribute("storeName");
		storeId=(String)session.getAttribute("storeId");
		time=(String)request.getParameter("time");
		mochineCode=(String)session.getAttribute("mochineCode");
	}
  //String p=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.pageStyle'");
  String sales=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.showSalesTarget'");
  String rowValue=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='portal.4085'");//颜色
  String colValue=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='portal.4084'");//尺寸
  //获取VIP编号生成规则add by GRACE20120305
  String vipNo=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='portal.4064'");//VIP卡号
  String vipTypes=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.vip.addTypes'");
  
  int p_count=1;
	StringBuffer sql=new StringBuffer("[");
	int vId;//Grace20120206 vip_id
	String vName;//Grace20120206 vip_name
  
  UserWebImpl userWeb =null;
  try{
      userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
  }catch(Throwable userWebException){
      System.out.println("########## found userWeb=null##########"+userWebException);
  } 
  if(null!=userWeb){
  	userName=userWeb.getUserName();
  	userId=userWeb.getUserId();
  }
  
  Object s=null;
	JSONObject jo=null;
	try{
		s=QueryEngine.getInstance().doQueryOne("select m_retail_param("+storeId+",'"+userName+"') from dual");
		String cond=new QueryRequestImpl().addParam(userWeb.getSecurityFilter("c_viptype",1));
		if(null!=cond&&!"".equals(cond)){
			cond=" and " + cond;
		}else if(null==cond){
			cond="";
		}
		if("ALL".equals(vipTypes)) vipTypes="";
		else	vipTypes=" and c_viptype.code in  ('"+vipTypes.replace(",","','").replace("，","','")+"')";
		String sqlc="select c_viptype.ID,c_viptype.name from c_viptype  where c_viptype.isactive='Y' "+vipTypes+ cond;
		//out.print(sqlc);
		jo=new JSONObject((String)s);
		//out.print("select m_retail_param('"+storeName.trim()+"','"+userName+"') from dual");
		//ADD BY Grace 20120206 viptype_info
		List typeids=QueryEngine.getInstance().doQueryList(sqlc);
		if(null!=typeids){
			for(int i=0;i< typeids.size();i++){
			vId=Integer.parseInt(((List)typeids.get(i)).get(0).toString());
			vName=(String)((List)typeids.get(i)).get(1);
			if(i==typeids.size()-1)
				sql.append("{\"typeid\":\""+vId+"\",\"typename\":\""+vName+"\"}");
			else
				sql.append("{\"typeid\":\""+vId+"\",\"typename\":\""+vName+"\"},");
			}
		}			
		sql.append("]");
		
	}catch(Exception e){}
	//out.print(jo.get("isenter").toString()+"-----"+storeId);
	if((userWeb==null&&!isGeneHl) || (userWeb.isGuest()&&!isGeneHl)||null==jo||!jo.get("isenter").toString().equals("1")){
%> 

<style>
#login_user {
  position: absolute;
  font-size: 30px;
  color: #FF00FF
  width:400px;
  height:50px;
  left:38%;
  top:50%;
  margin-left:-50px;
  margin-top:-25px;
}

</style>
	  <html>
	   <body>
  		<div id="login_user">
    		<div id="s">您登陆的用户：<%=userName %>无法登陆：<%=storeName%></div>  
    		<div id="warm"></div><a href="/bpos/login.jsp" >返回登陆页面</a>
    	</div>
	   </body>  
    </html>
	   <script  type="text/javascript">
	   	var secs =5; //倒计时的秒数         
      for(var i=secs;i>=0;i--){   
       window.setTimeout("doUpdate(" + i + ")",(secs-i)*1000);   
     }     
    
    function doUpdate(num){ 
     document.getElementById("warm").innerText= "将在"+num+"秒后自动跳转登陆页面" ; 
     if(num == 0){
     	 location.href="/bpos/login.jsp";	
      	 }   
       } 
	   	</script>
	   <%
	    return;
	}
	String logintime=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.logintime'");
	if(logintime.equals("true")&&!isGeneHl){
		try{
		QueryEngine.getInstance().executeUpdate("insert into WEBPOS_LOG (ID,AD_CLIENT_ID,AD_ORG_ID,C_STORE_ID,Ownerid,Creationdate,Modifierid,Modifieddate,Isactive,PLAN_NUM) values(get_sequences('WEBPOS_LOG'),37,27,"+storeId+","+userId+",to_date('"+time+"','yyyyMMdd-hh24:mi:ss'), "+userId+",to_date('"+time+"','yyyyMMdd-hh24:mi:ss'),'Y','"+mochineCode+"')");
		}catch(Exception e){}
	}
	File f=new File(request.getRealPath(".")+"/bpos/setup.inf");
	BufferedReader br=null;
	String str="";
	try{
		br=new BufferedReader(new InputStreamReader(new FileInputStream(f),"Unicode"));
		String recode;
		while(null!=(recode=br.readLine())){
			str+=new String(recode.getBytes("Unicode"),"Unicode");
		}
	}catch(Exception e){
		out.print(e.getMessage());
	}finally{
		if(null!=br){
       try{
        br.close();
       }catch(IOException e3){}
    }
	}
	String objectIdS=request.getParameter("id");
  int objectId=-1;
  if(null!=objectIdS&&!objectIdS.trim().equals("")){
  	objectId=Integer.parseInt(objectIdS.trim());
  }
   if(objectId!=-1)
 {   
        int retailTableId=TableManager.getInstance().getTable("m_retail").getId();
        response.sendRedirect("/html/nds/object/object.jsp?table="+retailTableId+"&id="+objectId );
        return;
  }
	int rangType=nds.util.Tools.getInt(QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.vipAreaRange'"),-1);
	int subsys=nds.util.Tools.getInt(QueryEngine.getInstance().doQueryOne("select id from AD_SUBSYSTEM where name='门店管理'"),-1);
	String menuList=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.menu.list'");
	String menuReportList=(String)QueryEngine.getInstance().doQueryOne("select value from ad_param where name='webpos.menu.reportlist'");
	//String menuReportList="发货订单汇总报表";
	if(null==menuList||"".equals(menuList)){
		menuList="M_RETAIL";
	}
	String menuListO="'"+menuList.trim()+"'";
	menuList="'"+menuList.trim().replace(",","','")+"'";
	List mrl=new ArrayList();
	if(null!=menuReportList&&!"".equals(menuReportList)){
		String menuReportListO="'"+menuReportList.trim()+"'";
		menuReportList="'"+menuReportList.replace(",","','")+"'";
		mrl=QueryEngine.getInstance().doQueryList("select ID,name FROM ad_cxtab WHERE NAME IN("+menuReportList+") order by instr("+menuReportListO+",name)");
	}
	List ml=QueryEngine.getInstance().doQueryList("select ID,DESCRIPTION FROM AD_TABLE WHERE NAME IN("+menuList+") order by instr("+menuListO+",name)");
	
%>
<head>

<%@ include file="/bpos/index_header.jsp" %>



<title>上海伯俊</title>
<script type="text/javascript">
jQuery(function(){
	jQuery("#sys_date").removeClass("q_input");
	jQuery("#sys_date").addClass("zody_q_input");
	jQuery("#zody_td").removeClass("value");
	jQuery("#zody_td").addClass("zody_value");
});
    function check1(){  
        if(document.getElementById("vip").value==""){ 
          	alert("请输入vip卡号！");
          	return;
        }else if(document.getElementById("vip").value.indexOf("[")!=-1&&document.getElementById("vip").value.indexOf("]")!=-1&&document.getElementById("vip").value.indexOf("{")!=-1&&document.getElementById("vip").value.indexOf("}")!=-1&&document.getElementById("vip").value.indexOf(":")!=-1&&document.getElementById("vip").value.indexOf(",")!=-1&&document.getElementById("vip").value.indexOf("\"")!=-1){
            alert("请输入正确的vip卡号！");
        }else{
            var form="form1";
            bpos.checkvip();          
        }
    }
    function check3(){  
    	if($("search_condition").value=="2"&&(!jQuery.trim($("storename").value)||!jQuery.trim($("retaildata").value))){
    		alert("必须输入店仓和单据日期！");
    	}else if($("search_condition").value=="1"&&!jQuery.trim($("retailno").value)){
    		alert("请输入原单编号！");
    	}else{
    		bpos.checkretailno(jQuery.trim($("retailno").value));    
    	}
    }
    //updated by zxz at 120522 修改金额 界面点击代码优化
 function checkradio(v){
 	      jQuery("#discount_"+v).removeAttr('disabled');
 			  jQuery("#discount_"+v).focus();
 	 for(var i=0;i<3;i++){
 		 if(i!=v){
 		  	jQuery("#discount_"+i).attr("disabled", true);
		 	  jQuery("#discount_"+i).val("");				  	
 		  }
 	 }
 }            
     
	function onReturn(event){
	 event = window.event || event;
	var keyCode = event.keyCode || event.which || event.charCode;
	var retailmust=window.document.getElementById("m_retail_idx").value;

	  if (keyCode == 13&&retailmust.length>0&&(jQuery.trim(retailmust)).length>0)
	  {
	     bpos.insertLine();
	  }
	}
function onReturnnum(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {
     bpos.changnum();
  }
}
function onReturnretailno(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {    
         check3();
  }
}

function onReturnretailprice(event){
  if (!event) event = window.event;
  if (event && event.keyCode && event.keyCode == 13)
  {
     bpos.changamt();
  }
}

</script>
</head>
<body id="pos-body" oncontextmenu="return false">
	<input type="hidden" value='<%=rowValue%>' id="colorShow" />
	<input type="hidden" value='<%=vipNo%>' id="addvipNo" />
	<input type="hidden" value='<%=colValue%>' id="sizeShow" />
	<input type="hidden" value='<%=jo%>' id="params"/>
	<input type="hidden" value='<%=storeName.trim()%>' id="storeName" />
	<input type="hidden" value='<%=storeId%>' id="store_id" />
	<input type="hidden" value='<%=sql%>' id="vip_type" />

	
	<iframe id="CalFrame" name="CalFrame" frameborder=0 src=/html/nds/common/calendar.jsp style="display:none;position:absolute; z-index:9999"></iframe>
	
<div id="objtb-pos">
	<div class="form_top_right_b">
		<OBJECT ID="MainApp" style="float:left;margin-left:20px;height:23px;width:77px" CLASSID="CLSID:<%=str.trim()%>" codebase="setup.cab"></OBJECT>

<div style="float:left;margin-left:40px;" ><span style="font-size:15px;" id="clock"></span><br><span style="color:red;display:none;" id="dateIsNotCorrect"> 本地时间与服务器时间不一致！</span></div>
<script>
	var iscorrect=false;
	function changeClock()
	{
	    var d = new Date();
	    
	    document.getElementById("clock").innerHTML = d.toLocaleString();
	}
	window.setInterval(changeClock, 1000);
	</script>
<div class="divHmain">
		<ul>
			<li  class="hmain">
					  <a href="#" >数据下载</a>					
				<ul>
				<%if(rangType>0){%>
					<li id="downloadvip">
							<a href="#" onclick="javascript:bpos.downLoadVipDb();">VIP下载</a>
					</li>
				<%}%>
					<li>
						<a href="#" onclick="javascript:bpos.download();">数据更新</a>
					</li>
				</ul>			
			</li>
			<li  class="hmain">
					  <a href="#" >扩展功能</a>
					  <ul>	
					  	<li><a href="#" onclick="javascript:bpos.integralpay();">积分付款</a></li>
							<li><a href="#" onclick="javascript:bpos.printpreorder();">重复打印</a></li>
							<li><a href="#" onclick="javascript:bpos.checkWorkAttendance();">考勤</a></li>
						</ul>	
			</li>
							<!--
							<li class="hmain0"><a href="#" onclick="javascript:bpos.integralpay();">积分付款</a></li>		
							<li class="hmain0"><a href="#" onclick="javascript:bpos.printpreorder();">重复打印</a></li>		
							-->
			<%if(mrl.size()>0){%>
			<li class="hmain">
				<a href="#">报表查询</a>					
						<ul>
							<%
							for(int i=0;i<mrl.size();i++){
						  %>
							<li>
								<a href="#" onclick="javascript:bpos.lineShop(0,'<%=((List)mrl.get(i)).get(1)%>',<%=((List)mrl.get(i)).get(0)%>);"><%=((List)mrl.get(i)).get(1)%></a>
							</li>	
							<%}%>				
						</ul>				  
			</li>
			<%}%>
			<li class="hmain">
				
				<a target="_blank" href="/html/nds/portal/portal.jsp?ss=<%=subsys%>">在线店务</a>
					<ul>
						<%
					for(int i=0;i<ml.size();i++){
				  %>
						<li>
							<a href="#" onclick="javascript:bpos.lineShop(<%=((List)ml.get(i)).get(0)%>,'<%=((List)ml.get(i)).get(1)%>');"><%=((List)ml.get(i)).get(1)%></a>
						</li>
						<%}%>
					</ul>	
				
			</li>
		
			<li class="hmain">
				<a href="javascript:bpos.sava();">退出</a>				
				<ul>
					<li>
						<a href="javascript:bpos.sava();">注销</a>
					</li>
					<li>
						<a href="#" onclick="javascript:bpos.closeWindow();">关闭</a>
					</li>	
									
				</ul>			
			</li>
	</ul>

</div>		
		
</div>
	
	
	<div id="title-body">
	  <div>
	  	<input type="hidden" id="time" value="<%=new Date()%>"/>
	  	<input type="hidden" id="sales" value="<%=sales%>"/>
	  	<input type="hidden" id="p_count" value="<%=p_count%>"/>
		</div>

<div id="from_top">
	<div id="from_top_text"><!--这里填充店仓名称--></div>
</div>
<div class="obj">
    <table width="1003" align="center" cellpadding="0" cellspacing="0" class="objtb">
      <tr>
	      <td width="152" nowrap="nowrap" align="left" valign='top' class="desc-pos"><div class="desc-txt">单据号:</div></td>
        <td class="value" width="117" nowrap="nowrap" align="left" valign='top' ><span id="column_23983"></span> </td>
        <td width="216" nowrap="nowrap" align="right" valign='top' class="value2">零售类型:</td>
        <td class="value" width="207" nowrap="nowrap" align="left" valign='top'>
                         <select id="retailType" onchange="bpos.rememberSelectedValue()" class="q_input2">                	            
                 	       </select>	
        	
        </td>
        <td id="zody_t1" width="126" nowrap="nowrap" align="left" valign='top' class="desc-pos"><div class="desc-txt">单&nbsp;据&nbsp;日&nbsp;期:</div></td>
        
        <td class="value" id="zody_td" width="152" nowrap="nowrap" align="left" valign='top' > 
        			<select id="sys_date" name="sys_date" class="q_input">
  						</select>
       </td>
      </tr>
      <tr>
		<td width="152" nowrap="nowrap" align="left" valign='top' class="desc-pos"><div class="desc-txt">V&nbsp;I&nbsp;P号:</div></td>
        <td class="value" width="117" nowrap="nowrap" align="left" valign='top' ><span id="vipnum">&nbsp;</span> </td>
        <td width="216" nowrap="nowrap" align="left" valign='top' class="desc-pos"><div class="desc-txt">卡&nbsp;类&nbsp;型:</div></td>
        <td class="value" width="207" nowrap="nowrap" align="left" valign='top' id="viptype1" >&nbsp;</td>
         <td width="126" nowrap="nowrap" align="left" valign='top' class="desc-pos"><div class="desc-txt" id="currSaler">当前营业员:</div></td>    
        <td class="value" width="152" nowrap="nowrap" align="left" valign='top' id="emp_name"></td>
		<td></td>
      </tr>
    </table>
  </div>
  <div id="obj-line"><div class="line"></div></div>

<div class="from-table">
  <div id="from-table" class="from-table-head">
	</div>
</div>
<div id="from-main" class="from-sidebar" style="height: 210px; visibility: visible; opacity: 1;">	
</div>

<div id="obj-line"><div class="line"></div></div>

<div id="embed-items">
	<table width="998" border="0" align="center" cellpadding="0" cellspacing="0" class="modify_table">
  	<tr>
    	<td width="638" class="embed_td">
    		<table width="540" cellspacing="0" cellpadding="0" border="0" align="left" class="objtb">
      		
      		<tbody>
      			<tr>
        			<td width="60" valign="top" nowrap="nowrap" align="left">
        				<div class="desc-txt">
	        				<input class="td-input" id="m_retailtype" name="type" type="text" readonly="readonly" value="正常">
	    					</div>
    					</td>
        			<td width="160" align="left"><input type="text" onkeypress="onReturn(event);"  class="q_input" maxlength="80" size="20" name="m_retail_idx" id="m_retail_idx"></td>
       	 			<td width="80" valign="top" nowrap="nowrap" align="right"><div class="desc-txt-white" style="color:#36567C">总数量：</div></td>
        			<td width="80" valign="top" nowrap="nowrap" align="left"><div id="tot_num" class="desc-txt-white">0</div></td>
        			<td width="80" valign="top" nowrap="nowrap" align="right"><div class="desc-txt-white" style="color:#36567C">原价金额：</div></td>
        			<td width="80" valign="top" nowrap="nowrap" align="left"><div id="tot_amt" class="desc-txt-white">0.00</div></td>
      			</tr>
    			</tbody>
    		</table>
    </td>
    <td width="358" rowspan="2" class="embed_td">
    	<div class="obj">
	    	<table width="260" cellspacing="0" cellpadding="0" border="0" align="center" class="objtb">
	      	<tbody>
	      		<tr>
	        		<td width="150" valign="top" nowrap="nowrap" align="right"><div class="desc-txt-red24">应付金额：</div></td>
	        		<td width="110" valign="top" nowrap="nowrap" align="left"><div id="tot_payable" class="desc-txt-red24">0.00</div></td>
	      		</tr>
	    	 </tbody>
	    	</table>
    	</div>
    </td>
  </tr>
  <tr>
    <td class="embed_tds"><div class="obj">
    	<table width="600" cellspacing="0" cellpadding="0" border="0" align="left" class="objtb">
      <tbody><tr>
        <td width="50" valign="top" nowrap="nowrap" align="right" class="desc-txt-white" style="color:#36567C">备注</td>
        <td width="550" align="left">&nbsp;&nbsp;<input type="text" class="inputTxt" name="comment" onkeyup="zody.udone(event)" id="comment">&nbsp;&nbsp;
		<!--<input name="Submit1" id="hoezody" type="button" class="input" onclick="zody.ope()" value="Home：备注"/>--></td>
        </tr>
    </tbody>
    </table>
    </div></td>
    </tr>
</table>
</div>
			<div id="obj-line"><div class="line"></div></div>

			<div id="from_input">
				<table width="840" border="0" align="center" cellpadding="0" cellspacing="0">
				  <tr>
				    <td width="145"><input id="f2button" name="Submit2" type="button" class="input" value="F2：开新单" onclick="bpos._editvip('f2newretail');" /></td>
				    <td width="145"><input id="f3button" name="Submit22" type="button" class="input" value="F3：营业员" onclick="bxl.sales()"/></td>
				    <td width="145"><input id="f4button" name="Submit23" type="button" class="input" value="&nbsp;F4：挂单/处理" onclick="zody.guaDanOrChuli()" /></td>
					<td width="145"><input id="f5button" name="Submit24" type="button" class="input" value="&nbsp;F5：付款"  onclick="bpos.payprice()"/></td>
				    <td width="145"><input id="f6button" name="Submit25" type="button" class="input" value="&nbsp;F6：状态切换" onclick="bpos.changeretailtype()"/></td>
				    <td width="145"><input name="Submit30" type="button" id="uploadbutton" class="input" value="(Ctrl+U)上传" onclick="bpos.uploadOrder()" /></td>
				    <td><input name="Submit212" type="button" value="(DELETE)删除" id="deletebutton" class="input" onclick="bpos.deletelines();"/></td>
				  </tr>
				  <tr>
				    <td height="30"><input id="f7button" name="Submit26" type="button" class="input" value="F7：改数量" onclick="bpos.changnumber();"/></td>
				    <td><input name="Submit27" id="f8button" type="button" class="input" value="F8：改金额" onclick="bpos.changprice()" /></td>
				    <td><input name="Submit28" id="f9button" type="button" class="input" value="F9：总额折扣"onclick="zody.discount()"/></td>
				    <td><input name="Submit29" id="f10button" type="button" class="input" value="F10：备注" onclick="zody.ope()"/></td>
				    <td><input name="Submit210" id="f11button" type="button" class="input" value="F11：批量录入" onclick="bxl.insertnum()"/></td>
				    <td><input name="Submit211" type="button" id="searchbutton" class="input" value="(Ctrl+F)查询" onclick="bxl.searchdocNo()"/></td>
				    <td width="145"><input name="Submit31" type="button" id="uploadvip" class="input" value="(Ctrl+P)VIP" onclick="bpos.showvip();" /></td>
				    
				  </tr>
				</table>
			</div> 
		</div>
		</div>
  </div>
<div id="pay" style="display:none">
    <%@ include file="/bpos/payment.jsp" %>
</div>
<div id="amt" style="display:none">
    <%@ include file="/bpos/inc_amt.jsp" %>
</div>
<div id="num" style="display:none">
    <%@ include file="/bpos/inc_num.jsp" %>
</div>  
<div id="dlg_vip" style="display:none">
    <%@ include file="/bpos/vip.jsp" %>
</div>  
<div id="r_retail_no" style="display:none">
    <%@ include file="/bpos/inc_retail_no.jsp" %>
</div>  
<div id="r_retail_price" style="display:none">
    <%@ include file="/bpos/inc_retail_price.jsp" %>
</div>
 <div id="insert_num" style="display:none">
	<%@ include file="/bpos/inc_insert.jsp" %>
</div> 
 <div id="search_num" style="display:none">
	<%@ include file="/bpos/search.jsp" %>
</div>
<div class="GreenBrowser">
  <ul>
 	<li>当前操作员:<span id="currentoperator" style="color:blue;"></span></li>
 	<li>日指标:<span id="daycurrent" style="color:blue;">0</span><span class="idTarget">/</span><span id="daytarget" style="color:blue;">0</span></li>
 	<li>月指标:<span id="monthcurrent" style="color:blue;">0</span><span class="idTarget">/</span><span id="monthtarget" style="color:blue;">0</span></li>
 	<li>月开卡指标:<span id="openVipCurrent" style="color:blue;">0</span><span class="idTarget">/</span><span id="openViptarget" style="color:blue;">0</span></li>
 	<li>挂单数:<span style="color:blue;" id="restordernum">0</span></li>
 	<li>零售笔数:<span id="numcurrent" style="color:blue;">0</span></li>
	</ul>
</div>
<div class="GreenBrowser">
	系统消息：
	<marquee width=90% scrollamount="3"> 
		
		<div id='posNews'>
			无最新系统消息！
     </div>
 </marquee>
	</div>
<div ondblclick="$('cmdmsg').hide()" style="display:none;" id="cmdmsg">
	<div id="imbox"><div class="imu" id="cmdmsguname">:</div>
		<div class="imt" id="cmdmsgtime"></div>
		<div class="imm nn1" id="cmdmsgcontent"></div>
		<div class="imf" id="cmdhref"><a href="#">查看通知明细</a></div></div><br>
			<div id="cmdbtns"><input type="button"  value="&nbsp;&nbsp;确认已读&nbsp;&nbsp;"></div>
	</div>
<DIV id=eMeng style="BORDER-RIGHT: #455690 1px solid; BORDER-TOP: #a6b4cf 1px solid; Z-INDEX:99999; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: #a6b4cf 1px solid; WIDTH: 180px; BORDER-BOTTOM: #455690 1px solid; POSITION: absolute; TOP: 0px; HEIGHT: 116px; BACKGROUND-COLOR: #c9d3f3">
	<TABLE style="BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid" cellSpacing=0 cellPadding=0 width="100%" bgColor=#cfdef4 border=0>
	<TBODY>
		<TR>
			<TD style="FONT-SIZE: 12px; COLOR: #0f2c8c" width=30 height=24></TD>
			<TD style="FONT-WEIGHT: normal; FONT-SIZE: 12px; COLOR: #1f336b; PADDING-TOP: 4px;PADDING-left: 4px" vAlign=center width="100%"> 消息提示：</TD>
			<TD style=" PADDING-TOP: 2px;PADDING-right:2px" vAlign=center align=right width=19><span title=关闭 style="CURSOR: hand;color:red;font-size:12px;font-weight:bold;margin-right:4px;" onclick='jc.hideElementAndClearInterval($("eMeng"))'>×</span></TD>
		</TR>
		<TR>
			<TD style="PADDING-RIGHT: 1px; PADDING-BOTTOM: 1px" colSpan=3 height=90>
				<DIV style="BORDER-RIGHT: #b9c9ef 1px solid; PADDING-RIGHT: 13px; BORDER-TOP: #728eb8 1px solid; PADDING-LEFT: 13px; FONT-SIZE: 12px; PADDING-BOTTOM: 13px; BORDER-LEFT: #728eb8 1px solid; WIDTH: 100%; COLOR: #1f336b; PADDING-TOP: 18px; BORDER-BOTTOM: #b9c9ef 1px solid; HEIGHT: 100%" id="tipMsg">
					<span id="tipMsgHead"></span><br/><div align=center  style="word-break:break-all" id="tipMsgBody"></div>
				</DIV>
			</TD>
		</TR>
	</TBODY>
	</TABLE>
</DIV>
<div id="alertMsg" class="div_botder" style="display:none;z-index:9999;position:absolute">
<span id="tipContent">可用库存：</span><span id="alertMsgContent">查询中...</span>
</div>
<script type="text/javascript">
	jQuery(document).ready(function(){
		if(jQuery("#sales").val()=="false"){
			jQuery(".GreenBrowser li:eq(1)").css("display","none");
			jQuery(".GreenBrowser li:eq(2)").css("display","none");
	 	}
		});
	</script>
</body>
</html>
