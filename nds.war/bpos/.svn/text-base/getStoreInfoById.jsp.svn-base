<%@ page language="java" import="java.security.MessageDigest,java.sql.*,nds.log.*, java.util.List,nds.query.QueryEngine,nds.control.web.UserWebImpl,nds.control.web.WebUtils,org.json.JSONObject,org.jboss.resource.adapter.jdbc.WrappedConnection,oracle.jdbc.driver.OracleConnection,oracle.sql.CLOB,java.math.BigDecimal" pageEncoding="utf-8"%>
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

String storeId=request.getParameter("storeId");
QueryEngine engine=QueryEngine.getInstance();
JSONObject result=new JSONObject();
List ls=QueryEngine.getInstance().doQueryList("select a.name,a.code,a.phone,a.address from c_store a where a.id="+storeId);
JSONObject jo=new JSONObject();
if(0<ls.size()){
	jo.put("id",storeId);
	jo.put("name",String.valueOf(((List)ls.get(0)).get(0)));
	jo.put("code",String.valueOf(((List)ls.get(0)).get(1)));
	jo.put("tele",String.valueOf(((List)ls.get(0)).get(2)));
	jo.put("addr",String.valueOf(((List)ls.get(0)).get(3)));
	result.put("code",1);
}else{
	result.put("code",0);
}
result.put("msg",jo);
out.print(result);
%>