<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%@ page import="nds.util.LicenseManager"%>
<%@ page import="nds.util.LicenseWrapper"%>
<%
	int un=0;
	int pn=0;
	int  cu=0;
	int  cs=0;
	String cp=null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	Connection conn=null;
	String mac=null;
	Object sc=null;
	Date expdate=new java.util.Date();
	java.text.SimpleDateFormat df=new java.text.SimpleDateFormat("yyyy-MM-dd");
	try{
	conn= nds.query.QueryEngine.getInstance().getConnection();
	pstmt= conn.prepareStatement("select mac from users where id=?");
	pstmt.setInt(1, 893);
	rs= pstmt.executeQuery();
	if(rs.next()){
		sc=rs.getObject(1);
		if(sc instanceof java.sql.Clob) {
			mac=((java.sql.Clob)sc).getSubString(1, (int) ((java.sql.Clob)sc).length());
	        }else{
	        mac=(String)sc;
	        }	
	}
	try{
	LicenseManager.validateLicense("jackrain","5.0",mac,true);
	QueryEngine engine=QueryEngine.getInstance();
	Iterator b=LicenseManager.getLicenses();
	    while (b.hasNext()) {
	    	LicenseWrapper o = (LicenseWrapper)b.next();
	    	un=o.getNumUsers();
			pn=o.getNumPOS();
			cp=o.getName();
			expdate=o.getExpiresDate();
	    }
		cu=Tools.getInt(engine.doQueryOne("select count(*) from users t where t.isactive='Y' and t.IS_SYS_USER!='Y'"), -1);
		cs=Tools.getInt(engine.doQueryOne("select count(*) from c_store t where t.isactive='Y' and t.isretail='Y'"), -1);
	} catch (Exception e) {
	}
	}catch(Throwable t){

	}finally{
		try{if(rs!=null) rs.close();}catch(Throwable t){}
		try{if(pstmt!=null) pstmt.close();}catch(Throwable t){}
		try{if(conn!=null) conn.close();}catch(Throwable t){}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.title{
width: 939px;
overflow: hidden;
right: 200px;
position: absolute;
}
.main {
width: 100%;
height: 344px;
background: no-repeat left #790000;
position: absolute;
top: 100px;
background-position: 199px 0px;
}
#bottom {
padding-bottom: 0px;
padding-left: 0px;
padding-right: 0px;
padding-top: 453px;
clear: both;
margin: 0 auto;
left: 955px;
top: 438px;
width: 604px;
}
.bottom-logo{
background: url(/images/bottom.gif) no-repeat center;
/*position: absolute;*/
width: 87px;
height: 20px;
/*left: 333px;*/
float: left;
display: block;
}
#bottom-right {
padding-bottom: 0px;
padding-top: 0px;
color: #999999;
font-size: 12px;
text-align: center;
}
a.bottom-text {
    color: #FF6600;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 12px;
    font-weight: bold;
    text-decoration: underline;
}
a:link,a:visited{
 text-decoration:none;  /*超链接无下划线*/
}
</style>
<style>

table {
*border-collapse: collapse; /* IE7 and lower */
border-spacing: 0;
width: 60%;
margin:auto;
}

.bordered {
border: solid #ccc 1px;
-moz-border-radius: 6px;
-webkit-border-radius: 6px;
border-radius: 6px;
-webkit-box-shadow: 0 1px 1px #ccc;
-moz-box-shadow: 0 1px 1px #ccc;
box-shadow: 0 1px 1px #ccc;
}



.bordered td, .bordered th {
border-left: 1px solid #ccc;
border-top: 1px solid #ccc;
padding: 10px;
text-align: left;
font-size: 24px;
}

.bordered th {
	color: black;
background-color: #dce9f9;
-webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
-moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;
box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
border-top: none;
text-shadow: 0 1px 0 rgba(255,255,255,.5);
}

.bordered td:first-child, .bordered th:first-child {
border-left: none;
}

.bordered th:first-child {
-moz-border-radius: 6px 0 0 0;
-webkit-border-radius: 6px 0 0 0;
border-radius: 6px 0 0 0;
}

.bordered th:last-child {
-moz-border-radius: 0 6px 0 0;
-webkit-border-radius: 0 6px 0 0;
border-radius: 0 6px 0 0;
}

.bordered th:only-child{
-moz-border-radius: 6px 6px 0 0;
-webkit-border-radius: 6px 6px 0 0;
border-radius: 6px 6px 0 0;
}

.bordered tr:last-child td:first-child {
-moz-border-radius: 0 0 0 6px;
-webkit-border-radius: 0 0 0 6px;
border-radius: 0 0 0 6px;
}

.bordered tr:last-child td:last-child {
-moz-border-radius: 0 0 6px 0;
-webkit-border-radius: 0 0 6px 0;
border-radius: 0 0 6px 0;
}
</style>
<title>认证信息</title>
</head>
<body>
<div width=100% margin:0 auto>	
<div class="title">
<h4 class="Logo"><img src="/images/left.gif" alt="伯俊logo"></h4>
</div>
<div class="main" style="text-align:center;">
<font color="#ffffff">
<h1>BOS注册产品信息</h1>
<h2>客户名称：<span><%=cp%></span></h2>
<table class="bordered">
<thead>
  <tr>
    <th>用户数</th>
    <th>当前用户数</th>
    <th>POS数</th>
    <th>当前POS数</th>
  </tr>
 </thead> 
  <tr>
    <td><%=un%></td>
    <td><%=cu%></td>
    <td><%=pn%></td>
    <td><%=cs%></td>
  </tr>
</table>
<font color="yellow">
	<h2>服务到期时间：<span><%=df.format(expdate)%></span></h2>
	<h2>距离服务到期还有：<span><%=(expdate.getTime()-System.currentTimeMillis())/(24*60*60*1000)>0?(expdate.getTime()-System.currentTimeMillis())/(24*60*60*1000):0%></span>天</h2>
</font>
</font>
</div>
<div id="bottom">
<div id="bottom-right"><span class="bottom-logo"></span>&copy;2011-2013上海伯俊软件科技有限公司 版权所有 了解更多产品请点击:<a class="bottom-text" target="_parent" href="http://www.burgeon.com.cn">www.burgeon.com.cn</a></div>
</div>
</div>
</body>
</html>
