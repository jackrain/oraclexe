<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %> 
<%
    /**
     * parameter:
     *      1.  objectid  - user Id whose password will be changed, if not set,default to current user's id
     */
int userid= ParamUtils.getIntParameter(request, "objectid", -1);
if(userid==-1) userid= userWeb.getUserId();

	String tabName=PortletUtils.getMessage(pageContext, "change-password",null);
	Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);	
	if(conf.getProperty("security.password.file")!=null){
		response.sendRedirect(conf.getProperty("security.password.file")+"?objectid="+userid);
	}
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
     /**------check permission---**/
String directory;
directory="USERS_LIST";
try{
	WebUtils.checkDirectoryWritePermission(directory,request);
}catch(Throwable t){
	// user must be himeself then
	if( userWeb.getUserId()==-1 || userWeb.getUserId()!=userid) throw new NDSException("@no-permission@");
}
TableManager manager=TableManager.getInstance();
Table table= manager.getTable("USERS");
int tableId= table.getId();

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
	function testComplex(val){
 var minLen=6;
 var minAZ=2;
 var minDigits=2;
 var UpperandLower=1;    //true=1 false=0
 var numPunc=1;
 if (val.length != val.replace(/^\s+|\s+$/g,"").length) return false; // start and end no space allowed
 if (val.lenght<minLen ||val.lenght>12 ) return false;
 if (minAZ)
   {if (!/[a-z]/i.test(val) || val.match(/[A-Z]/gi).length < minAZ) return false;}
 if (minDigits)
     { if (!/\d/.test(val) || val.match(/\d/g).length < minDigits ) return false;}
 if (UpperandLower)
    {if (!/[a-z]/g.test(val) || !/[A-Z]/g.test(val) )return false;}
 if (numPunc)
     {if  ( !/[\.\'\;\,\!\"\:\?]/.test(val) || (val.match(/[\.\'\;\,\!\"\:\?]/g).length < numPunc)) return false;}

 return true;
}

function checkOptions(form){
	if(form.password1.value != form.password2.value){
		alert("<%= PortletUtils.getMessage(pageContext, "please-enter-matching-passwords",null)%>");
		return false;
	}
	if( isWhitespace(form.password1.value)){
		alert("<%= PortletUtils.getMessage(pageContext, "please-enter-a-valid-password",null)%>");
		return false;
	}
/*	
	if(!testComplex(form.password1.value)){
		alert("<%= PortletUtils.getMessage(pageContext, "please-enter-a-valid-password",null)%>");
		return false;
	}
*/
	submitForm(form); 
}
</script>
<p>
<form name="password_modify" method="post" action="<%=contextPath%>/control/command" >
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
    <tr><td height="18" width="50%" nowrap align="right"><%= PortletUtils.getMessage(pageContext, "password",null)%>:</td>
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
		
    </div>
</div>		
<%@ include file="/html/nds/footer_info.jsp" %>
