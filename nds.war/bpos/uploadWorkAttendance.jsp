<%@ page language="java" import="java.text.SimpleDateFormat,java.sql.Timestamp,java.security.MessageDigest,javax.transaction.UserTransaction, nds.control.util.EJBUtils,java.sql.*,nds.log.*, java.util.List,java.util.regex.Pattern,java.util.regex.Matcher,nds.query.QueryEngine,nds.control.web.UserWebImpl,nds.control.web.WebUtils,org.json.JSONArray,org.json.JSONObject,nds.schema.*" pageEncoding="utf-8"%>
<%!
public Timestamp parseStr2Date(String date,SimpleDateFormat sf)throws Exception{
	if("".equals(date))return null;
	return new Timestamp(sf.parse(date).getTime());
}

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

String email=request.getParameter("u");
String key=request.getParameter("ph");
JSONObject s=new JSONObject();
/**if(null==email||null==key||"".equals(email.trim())||"".equals(key.trim())){
	s.put("code",0);
	s.put("msg","未提供用户信息，无法通过验证！");
	out.print(s);
	return;
}*/
QueryEngine engine=QueryEngine.getInstance();

String password=(String)engine.doQueryOne("select passwordhash from users where email='"+email.trim()+"'");
if(!key.equals(MD5(email.trim()+MD5(password)))){
	s.put("code",1);
	s.put("msg","验证失败！密码或用户错误");
	out.print(s);
	return;
}
Logger logger=LoggerManager.getInstance().getLogger("uploadWorkAttendance.jsp------>");
String json =request.getParameter("data");
logger.error("error -----------json:"+json);
JSONArray ja=new JSONArray(json);

SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Connection conn=null;
PreparedStatement pstmt=null;
UserTransaction ut=null;
String tableName="HR_CHK_WORK_FTP";
try{
	ut = EJBUtils.getUserTransaction();
	ut.setTransactionTimeout(14400);
	ut.begin();
	conn= engine.getConnection();
	String sql="insert into HR_CHK_WORK_FTP(id,AD_CLIENT_ID,AD_ORG_ID,USERS_ID,TTIME,CREATIONDATE,MODIFIEDDATE,CHKWORKTYPE,ISADD,OWNERID,MODIFIERID,BEGTIME,ENDTIME,C_STORE_ID) values(?,37,27,?,?,?,?,?,?,?,?,?,?,?)";
	//String sql="insert into HR_CHK_WORK_FTP(id,USERS_ID) values(?,?)";
	pstmt=conn.prepareStatement(sql);
	Table t=TableManager.getInstance().getTable(tableName);
	for(int i=0;i<ja.length();i++){
		int mk_id=QueryEngine.getInstance().getSequence(tableName, conn);
		JSONObject jo=(JSONObject)ja.get(i);
		pstmt.setInt(1,mk_id);

		pstmt.setInt(2,jo.getInt("userid"));
		

		pstmt.setTimestamp(3,parseStr2Date(jo.getString("t_time"),sf));


		pstmt.setTimestamp(4,parseStr2Date(jo.getString("h_time"),sf));
		pstmt.setTimestamp(5,parseStr2Date(jo.getString("h_time"),sf));

		pstmt.setString(6,jo.getString("t_type"));


		pstmt.setString(7,jo.getString("is_add"));

		pstmt.setInt(8,jo.getInt("operatorid"));
		pstmt.setInt(9,jo.getInt("operatorid"));


		pstmt.setTimestamp(10,parseStr2Date(jo.getString("start_time"),sf));
		pstmt.setTimestamp(11,parseStr2Date(jo.getString("end_time"),sf));
		
		pstmt.setInt(12,jo.getInt("c_store_id"));
		pstmt.executeUpdate();
		new nds.control.ejb.DefaultWebEventHelper().doTrigger("AC",t,mk_id,conn);
	}
	ut.commit();
	s.put("code",0);
	s.put("msg","success");
}catch(Throwable e){
	if(ut!=null){
		try {
			ut.rollback();
		}catch (Exception er) {
			logger.error("Could not rollback.",er);
		}
	}
	logger.error(e.getMessage(),e);
	s.put("code",1);
	s.put("msg",e.getMessage());
}
out.print(s);
%>
