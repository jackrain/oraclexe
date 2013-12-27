<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %> 
<%@page import="java.util.*,javax.naming.*,javax.sql.*,java.sql.*,nds.query.*,com.liferay.portal.service.UserLocalServiceUtil,nds.query.*" %>
<%
    /**
     * parameter:
     *      1.  objectid  - user Id whose password will be changed, if not set,default to current user's id
     */
  int userid= ParamUtils.getIntParameter(request, "objectid", -1);
  String oldpassword= request.getParameter("password0");
  String newpassword=request.getParameter("password1");
  String message=null;
  
  
  java.sql.Connection conn=null;
  PreparedStatement stmt;
  ResultSet rs;
  boolean complexcheck=false;
  int changecycle=0;
  

   try{  
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
   if ((oldpassword!=null)&&(newpassword!=null))  {
     stmt=conn.prepareStatement("select id, passwordreset, passwordexpirationdate, isactive, email from users where id=?");
     stmt.setInt(1,userid);
     rs=stmt.executeQuery();
     if (rs.next()){
        Timestamp expiretime=rs.getTimestamp("passwordexpirationdate");
        String passwordreset=((rs.getString("passwordreset")!=null)?rs.getString("passwordreset"):"N");
        String isactive=((rs.getString("isactive")!=null)?rs.getString("isactive"):"Y");
        String email=rs.getString("email");
        String userd=email+"@burgeon";
        java.util.Date today=(new GregorianCalendar()).getTime();
        rs.close();stmt.close();
       if (UserLocalServiceUtil.authenticateByEmailAddress("liferay.com", email, oldpassword, null,null)==1){
         boolean passwordReset_constant=false;
         UserLocalServiceUtil.updatePassword(userd, newpassword,newpassword, passwordReset_constant);
         QueryEngine.getInstance().executeUpdate("UPDATE USERS SET PASSWORDHASH="+QueryUtils.TO_STRING(newpassword)+" WHERE ID="+ userid);
		// QueryEngine.getInstance().executeUpdate("UPDATE USERS SET PASSWORDHASH="+newpassword+" WHERE ID="+ userid);
         if ("Y".equals(passwordreset)){
         			QueryEngine.getInstance().executeUpdate("UPDATE users SET passwordreset='N' WHERE id="+ userid);
         			if(changecycle>0){
         			     QueryEngine.getInstance().executeUpdate("UPDATE users set passwordexpirationdate=sysdate+"+changecycle+" WHERE id="+ userid);
         			}
         }else if(changecycle>0){
             if((expiretime !=null)&&expiretime.before(today)){
                   QueryEngine.getInstance().executeUpdate("UPDATE users set passwordexpirationdate=sysdate+"+changecycle+" WHERE id="+ userid);
              }
         }
         message=" \u5bc6\u7801\u6210\u529f\u66f4\u6539!";
         //message="Password successfully changed!";
       }else{
       	 message="\u65e7\u5bc6\u7801\u4e0d\u5bf9!";
       	 //message="Old password not correct!";
       	}
     }
     rs.close(); stmt.close();
    }//if (oldpassword!=null)
	else{
	   if ((oldpassword!=null)&&(newpassword==null)){
	   message="\u5bc6\u7801\u4e0d\u53ef\u4e3a\u7a7a!";}
	   // password can not be empty
	}
   }catch(Exception e){
     out.println("error:"+e.getMessage());
   }
   finally {conn.close();}  
  


	String tabName=PortletUtils.getMessage(pageContext, "change-password",null);
	Configurations conf=(Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);	
	if(conf.getProperty("security.password.file")!=null){
		//response.sendRedirect(conf.getProperty("security.password.file")+"?objectid="+userid);
		//remark to avoid further redirect 2010/05/14 by ken 
	}
%>
<script>
var remindstr="\u5bc6\u7801\u4fee\u6539\u539f\u5219\uff1a<br>1\uff0e\u5bc6\u7801\u4ee5\u5927\u5c0f\u5199\u82f1\u6587\u5b57\u7b26\u52a0\u6570\u5b57\u6784\u6210, \u957f\u5ea6\u4e3a\u6700\u5c11\u4e3a6\u4f4d, \u6700\u5c112\u4f4d\u5927\u5199\u5b57\u6bcd, <br>&nbsp;&nbsp;&nbsp;\u540c\u65f6\u8981\u6709\u5927\u5199\u548c\u5c0f\u5199\u5b57\u6bcd<br>2\uff0e\u672c\u6b21\u4fee\u6539\u7684\u5bc6\u7801\u4e0d\u80fd\u4e0e\u4e0a\u6b21\u5bc6\u7801\u4e2d\u7684\u4efb\u610f\u4e09\u4e2a\u5b57\u7b26\u76f8\u540c<br>3\uff0e\u6bcf\u4e09\u4e2a\u6708\u7cfb\u7edf\u5f3a\u5236\u8981\u6c42\u7528\u6237\u4fee\u6539\u5bc6\u7801\u3002";
	document.title="<%=tabName%>";
	<%if(!complexcheck) out.println("remindstr=\"\";");%>
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%

    ResultSet result= QueryEngine.getInstance().doQuery("select name, truename from users where id="+userid);
    if(!result.next()) {
        out.println("The pointed user is not found!");
        return;
    }

String userName=result.getString(1);
String userDesc= result.getString(2);

%>
<script language="JavaScript" src="<%=NDS_PATH%>/js/formkey.js"></script>
<script>
	function testComplex(val){<%if (!complexcheck) out.println("return \"\";");%>
 var oldpassword=document.getElementById("password0").value;
 var minLen=6;
 var minAZ=1;
 var minDigits=1;
 var UpperandLower=1;    //true=1 false=0
 var numPunc=0;
 if (val.length != val.replace(/^\s+|\s+$/g,"").length) return "\u5bc6\u7801\u4e2d\u4e0d\u80fd\u5305\u7a7a\u9694!"; // start and end no space allowed
 if (val.lenght<minLen ||val.lenght>12 ) return "\u5bc6\u7801\u957f\u5ea6\u8981\u5927\u4e8e6\u4f4d, \u5c0f\u4e8e12\u4f4d!";
 if (minAZ)
   {if (!/[a-z]/i.test(val) || val.match(/[A-Z]/gi).length < minAZ) return "\u5bc6\u7801\u5b57\u7b26\u4e2a\u6570\u4e0d\u8db3!";}
 if (minDigits)
     { if (!/\d/.test(val) || val.match(/\d/g).length < minDigits ) return "\u5bc6\u7801\u6570\u5b57\u5b57\u7b26\u4e0d\u591f!";}
 if (UpperandLower)
    {if (!/[a-z]/g.test(val) || !/[A-Z]/g.test(val) )return "\u5bc6\u7801\u7f3a\u5927\u6216\u5c0f\u5199\u5b57\u6bcd!";}
 if (numPunc)
     {if  ( !/[\.\'\;\,\!\"\:\?]/.test(val) || (val.match(/[\.\'\;\,\!\"\:\?]/g).length < numPunc)) return "\u5bc6\u7801\u7f3a\u5c11\u6807\u70b9\u7b26\u53f7!";}
 var count=0;
 for (var i=0;i<oldpassword.length;i++){
 	 if(val.indexOf(oldpassword.charAt(i))>-1)count++;
 	}
 if (count>3){return "\u65b0\u5bc6\u7801\u4e0e\u65e7\u5bc6\u7801\u4e0d\u80fd\u6709`3\u4e2a\u5b57\u7b26\u76f8\u540c!"}
 return "";
}

function checkOptions(form){
	var message;
	if(form.password1.value != form.password2.value){
		alert("<%= PortletUtils.getMessage(pageContext, "please-enter-matching-passwords",null)%>");
		return false;
	}
	if( isWhitespace(form.password1.value)){
		alert("<%= PortletUtils.getMessage(pageContext, "please-enter-a-valid-password",null)%>");
		return false;
	}
	message=testComplex(form.password1.value);
	if(message!=""){
		alert(message);
		return false;
	}

	submitForm(form); 
}
</script>
<p>
<form name="password_modify" method="post" action="/changepasswordbeforelogin.jsp?objectid=<%=userid%>" >
<br>
<table align="center" border="0" cellpadding="1" cellspacing="1" width="90%">
<input type="hidden" name="userid" value="<%=userid %>">
<input type="hidden" name="formRequest" value="<%=NDS_PATH+"/security/changepassword.jsp?objectid="+ userid%>">
<input type="hidden" name="command" value="ChangePassword">
<input type="hidden" name="nds.control.ejb.UserTransaction" value="N">
	<!--<tr><td align="center" colspan="2"><%= PortletUtils.getMessage(pageContext, "password-requirement",null)%></td></tr>-->
	<tr><td align="right"><%= PortletUtils.getMessage(pageContext, "name",null)%>:</td>
	<td nowrap><%=userName%>&nbsp;&nbsp;<%=userDesc%></td>
	</tr>
	<tr><td height="18" width="50%" nowrap align="right"><%="\u65e7"%><%= PortletUtils.getMessage(pageContext, "password",null)%>:</td>
    <td height="18" width="50%" align="left"><input type='password' id='password0'  name='password0' value=''></td>
    </tr>
    <tr><td height="18" width="50%" nowrap align="right"><%="\u65b0"%><%= PortletUtils.getMessage(pageContext, "password",null)%>:</td>
    <td height="18" width="50%" align="left"><input type='password'  name='password1' value=''></td>
    </tr>
    <tr><td height="18" width="50%" nowrap align="right"><%= PortletUtils.getMessage(pageContext, "enter-again",null)%>:</td>
    <td height="18" width="50%" align="left"><input type='password' name='password2' value=''></td>
    </tr>
    <tr>
    <td></td>
    	<td align='left'><br>
<input  type='button' name='ChangePassword' value='<%=PortletUtils.getMessage(pageContext, "save",null)%>' onclick="javascript:checkOptions(document.password_modify);" > &nbsp;&nbsp;
<input  type='button' name='enterportal' value='<%= LanguageUtil.get(pageContext, "enter-view") %><%= LanguageUtil.get(pageContext, "backmanager") %>' onclick="window.location='/html/nds/portal/portal.jsp'" > &nbsp;&nbsp;
    	</td>
    	<td>
    	</td>
    </tr>
 </table>
 
 </form>
				<script>document.write(remindstr);</script>
    </div>
</div>		

<%@ include file="/html/nds/footer_info.jsp" %>
<% if (message!=null)out.println("<script>alert('"+message+"');</script>");%>