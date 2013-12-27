<%@ page language="java" import="java.security.MessageDigest,java.sql.*,nds.log.*, java.util.List,java.util.regex.Pattern,java.util.regex.Matcher,nds.query.QueryEngine,nds.control.web.UserWebImpl,nds.control.web.WebUtils,org.json.JSONObject,org.jboss.resource.adapter.jdbc.WrappedConnection,oracle.jdbc.driver.OracleConnection,oracle.sql.CLOB,java.math.BigDecimal" pageEncoding="utf-8"%>
<%!
public String MD5(String s){
	String r="";
	try{
		MessageDigest md = MessageDigest.getInstance("MD5"); 
		md.update(s.getBytes());
		byte b[]=md.digest();	
		int i;
		StringBuffer buf = new StringBuffer("");
		for (int offset = 0; offset < b.length; offset++) { 
			i = b[offset]; 
			if(i<0) i+= 256; 
			if(i<16) 
			buf.append("0"); 
			buf.append(Integer.toHexString(i)); 
		}
		r=buf.toString();
	}catch(Exception e){	
	}
	return r;
}
%>
<%

String email=request.getParameter("e");
String key=request.getParameter("k");
JSONObject s=new JSONObject();
/**if(null==email||null==key||"".equals(email.trim())||"".equals(key.trim())){
	s.put("code",0);
	s.put("msg","未提供用户信息，无法通过验证！");
	out.print(s);
	return;
}*/
QueryEngine engine=QueryEngine.getInstance();
/**
String password=(String)engine.doQueryOne("select passwordhash from users where email='"+email.trim()+"'");
if(!key.equals(MD5(MD5(password)+email.trim()))){
	s.put("code",0);
	s.put("msg","验证失败！密码或用户错误");
	out.print(s);
	return;
}
*/
//Logger logger=LoggerManager.getInstance().getLogger("uploadretail.jsp------>");
String json =request.getParameter("JSON");
Pattern p=Pattern.compile("[.\\s\\S]+(\"productname\":[.\\s\\S]+)\"mdim11");
      Matcher m=p.matcher(json);
      String ss="";
      if(m.find()){
          ss=m.group(1);
      }
 json=json.replace(ss,"");
// logger.error("ss-------------------------------"+ss);
//logger.error("error -----------json:"+json);
JSONObject jo=new JSONObject(json);
int userId;
try{
	userId=Integer.parseInt(((JSONObject)jo.get("param")).getString("operatorid"));
}catch(Throwable t){
	 userId=Integer.parseInt(request.getParameter("userId"));
}

//增加判断单据是否已经上传			
List args=engine.doQueryList("select to_char(CREATIONDATE,'yyyy-MM-dd hh24:mi:ss'),TOT_AMT_ACTUAL from m_retail where REFNO='"+((JSONObject)jo.get("param")).getString("refno")+"' order by id desc");
if(args.size()>0){
//计算总成交价
BigDecimal tot_amt_actual=new BigDecimal("0.0");
String[] realpaymount=((JSONObject)jo.get("param")).getString("realpaymount").replace("[","").replace("]","").split(",");
for(int i=0;i<realpaymount.length;i++){
	tot_amt_actual=tot_amt_actual.add(new BigDecimal(realpaymount[i]));
}
//含有单据号refno，且单据时间是否相同、总成交金额相同,确认重复
if((Double.compare(tot_amt_actual.doubleValue(),new Double(((List)args.get(0)).get(1).toString()).doubleValue())==0)&&((JSONObject)jo.get("param")).getString("createtime").equals(((List)args.get(0)).get(0))){
	s.put("code",2);
	s.put("msg","");
%>
<%=s%>
<%	
//单据号(refno)重复但单据时间不同（表示只单据号重复明细不同）
}else {
	s.put("code",0);
	s.put("msg","错误：单据号重复，明细不同。请联系管理员！");
%>
<%=s%>
<%
}
}else{
boolean connIsNull=true;
Connection conn=null;
CallableStatement cs=null;
PreparedStatement pstmt=null;

Clob c=null;
conn= engine.getConnection();
OracleConnection oc;
if(conn instanceof WrappedConnection)  {
  oc=(OracleConnection)((WrappedConnection)conn).getUnderlyingConnection();
}else if(conn instanceof OracleConnection){
  oc=(OracleConnection)conn;
}else{
  throw new SQLException("Not supported connection class:"+ conn.getClass().getName()+" (only oracle and jboss connection supported)");
}
try{  
  c= CLOB.createTemporary(oc,true,CLOB.DURATION_SESSION);
  c.setString(1,jo.getString("param"));
  connIsNull=false;
  
	cs=conn.prepareCall("{?=call M_RETAIL_$R_INSERT_SAVE(?,?)}");
	cs.registerOutParameter(1, Types.VARCHAR);
	cs.setInt(2,userId);
	cs.setClob(3,c);
	cs.execute();
	s.put("msg",cs.getString(1));
	s.put("code",1);
}catch(Throwable e){
	Throwable re=e.getCause();
	String errInf;
	if(null!=re){
		errInf=re.getMessage();
	}else{
		errInf=e.getMessage();
	}
	s.put("code",0);
	s.put("msg",errInf);
	String refno=((JSONObject)jo.get("param")).getString("refno");
	String c_store_id=((JSONObject)jo.get("param")).getString("storeid");
	if(!connIsNull&&null!=conn&&null!=c){
		String sql="merge into WEBPOS_UPLOAD_LOG a using(select "+
							"GET_SEQUENCES('webpos_upload_log')  as id,"+
							"37 as AD_CLIENT_ID,27 as AD_ORG_ID,"+
							userId+" as OWNERID,"+
							userId+" as MODIFIERID,"+
							"sysdate as CREATIONDATE,sysdate as MODIFIEDDATE,'Y' as ISACTIVE,? as JSON_DATA,'"+
							errInf+"' as ERROR_REASON,'N' as ISDEAL,'' as ERROR_DATA,'"+
							refno+"' as REFNO,"+
							c_store_id+" as C_STORE_ID from dual)b on(b.refno=a.refno)"+
							"when matched then update set a.MODIFIERID=b.MODIFIERID,a.MODIFIEDDATE=b.MODIFIEDDATE,a.JSON_DATA=b.JSON_DATA,a.ERROR_REASON=b.ERROR_REASON,a.ISDEAL=b.ISDEAL "+
							"WHEN NOT MATCHED THEN INSERT"+
							"(a.ID,a.AD_CLIENT_ID,a.AD_ORG_ID,a.OWNERID,a.MODIFIERID,a.CREATIONDATE,a.MODIFIEDDATE,a.ISACTIVE,a.JSON_DATA,a.ERROR_REASON,a.ISDEAL,a.ERROR_DATA,a.refno,a.c_store_id)"+
							"values"+
							"(b.ID,b.AD_CLIENT_ID,b.AD_ORG_ID,b.OWNERID,b.MODIFIERID,b.CREATIONDATE,b.MODIFIEDDATE,b.ISACTIVE,b.JSON_DATA,b.ERROR_REASON,b.ISDEAL,b.ERROR_DATA,b.refno,b.c_store_id)";
		try{						
			pstmt=conn.prepareStatement(sql);
			pstmt.setClob(1,c);
			pstmt.executeUpdate();
		}catch(Exception e11){}
	}
}finally{
  if(null!=cs){
    try{
     	cs.close();
    	cs=null;
    }catch(SQLException e1){}
  }
  if(null!=pstmt){
    try{
     	pstmt.close();
    	pstmt=null;
    }catch(SQLException e2){}
  }
  if(null!=conn){
    try{
    	conn.close();
      conn=null;
    }catch(SQLException e3){}
  }
}
%>
<%=s%>
<%}%>