<%@page import="java.util.*,nds.util.*,javax.naming.*,javax.sql.*,java.sql.*,nds.query.*,com.liferay.portal.service.UserLocalServiceUtil,nds.query.*,com.liferay.util.servlet.SessionErrors" 
%><%
java.sql.Connection conn=null;
PreparedStatement stmt;
ResultSet rs;
boolean complexcheck=false;
int changecycle=0;

try{
  String user=request.getParameter("login");
  conn=QueryEngine.getInstance().getConnection();
  //get portal parameters about password
  stmt=conn.prepareStatement("select name, value from ad_param where name in ('portal.password.complexcheck','portal.password.firstloginchange','portal.password.changecycle') and isactive='Y'");
  rs=stmt.executeQuery();
  while (rs.next()){
     if("portal.password.complexcheck".equals(rs.getString("name"))){
        complexcheck=("true".equals(rs.getString("value"))?true:false);
     	}else if("portal.password.changecycle".equals(rs.getString("name"))){
     	  changecycle=Tools.getInt(rs.getString("value"),0);
     	}
  }
  stmt.close();
  rs.close();

  //get user information
  stmt=conn.prepareStatement("select id, passwordreset, passwordexpirationdate, isactive from users where email=?");
  stmt.setString(1,user);
	rs=stmt.executeQuery();
  if (!rs.next()){rs.close();stmt.close(); pageContext.forward("/c/portal/login");return;}
  Timestamp expiretime=rs.getTimestamp("passwordexpirationdate");
  String passwordreset=((rs.getString("passwordreset")!=null)?rs.getString("passwordreset"):"N");
  String isactive=((rs.getString("isactive")!=null)?rs.getString("isactive"):"Y");
  java.util.Date today=(new GregorianCalendar()).getTime();
  int userId=rs.getInt("id");
  rs.close();stmt.close();
  if("N".equals(isactive)){
    SessionErrors.add(request,"INACTIVE_USER");
    response.sendRedirect("/login.jsp");
  	return;
  }
  if(("Y".equals(passwordreset))||((changecycle>0)&&(expiretime !=null)&&expiretime.before(today))){
  	response.sendRedirect("/changepasswordbeforelogin.jsp?objectid="+userId);
  	return;
  }
}catch(Exception e) {
  out.println("error:"+e.getMessage());
}
finally{if(conn!=null)conn.close();}  
pageContext.forward("/c/portal/login");
%>