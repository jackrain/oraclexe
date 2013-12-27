<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	String tabName= PortletUtils.getMessage(pageContext, "userinfo",null);
%>
<script>
	document.title="<%=PortletUtils.getMessage(pageContext, "userinfo",null)%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%
    /**
     * Things needed in this page:
     */
    String title="当前用户信息";
    String userName, userDescription;
    int userId=-1;
    SessionContextManager manager= WebUtils.getSessionContextManager(request.getSession());
    UserWebImpl user= null;
    if( manager !=null){
        user= (UserWebImpl)manager.getActor(nds.util.WebKeys.USER);
    }
    if( user!=null){
        userId= user.getUserId();
        userName=user.getUserName();
        userDescription=user.getUserDescription();
    }else{
        userName="guest";
        userDescription="Not Login";
    }

%>
<% //request.getContextPath()+
    String headerjsp="/header.jsp";
 %>
<tiles:insert page='<%=headerjsp%>'>
  <tiles:put name='title' value='<%=title%>' direct='true'/>
</tiles:insert>

<script>
function checkSelected(optionControl, desc){
      for(i=0; i<optionControl.options.length; i++) {
        if (optionControl.options[i].selected) {
            if( optionControl.options[i].value =='0'){
                alert("\Select "+desc+", Please!!");
                optionControl.focus();
                return false;
            }
        }
      }
      return true;
}
function checkOptions(form){
   if(!checkSelected(form.command,"Command"))  return false;
   return true;
}
</script>
<br>

<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
  <tr>
    <td rowspan=2>&nbsp;</td>
          <td>
<tiles:insert page='/title.jsp'>
  <tiles:put name='title' value='<%= title %>' direct='true'/>
  <tiles:put name='titleCn' value='<%= "用户信息" %>' direct='true'/>
</tiles:insert>
          </td>
          <td rowspan=2>&nbsp;</td>
        </tr>
        <tr>
          <td>

        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" bordercolorlight="#cccccc" align="center" background="../images/Nds_table_bg_2.gif">
          <tr>
            <td>
              <br><!-- user infor here-->
<form name="sheet_title_form" method="post" action="<%=request.getContextPath() %>/control/command" onSubmit="return checkOptions(document.sheet_title_form);">
<table align="center" border="0" cellpadding="1" cellspacing="1" width="90%">
<input type="hidden" name="id" value="<%=userId %>">
<input type="hidden" name="name" value="<%=userName %>">
    <tr><td height="18" width="50%" nowrap align="right">帐号：</td>
    <td height="18" width="50%" align="left"><%=userName %></td>
    </tr>
    <tr><td height="18" width="50%" nowrap align="right">描述：</td>
    <td height="18" width="50%" align="left"><input type='text' class="text" name='description' value='<%=userDescription %>'></td>
    </tr>
 </table><br>
          <table width="33%" border="0" cellspacing="0" cellpadding="0" align="center" height="22">
          <tr>
            <td width="70%" height="2" align='right'>
              <select size="1" name="command">
                <option value="0">--选择--</option>
                <option selected value="UserUpdate">保存描述</option>
              </select>
            </td>
            <td width="30%" height="2" align='left'>
              <input type="image" name="Submit" value="Submit"  src="../images/exec_btm.gif" border="0" >
            </td>
        </table>
 </form>

<br><br>
<form name="password_modify" method="post" action="<%=request.getContextPath() %>/control/command" onSubmit="return checkOptions(document.password_modify);">
 <table align="center" border="0" cellpadding="1" cellspacing="1" width="90%">
<input type="hidden" name="id" value="<%=userId %>">
<input type="hidden" name="name" value="<%=userName %>">
<input type="hidden" name="description" value="<%=userDescription %>">

    <tr><td height="18" width="50%" nowrap align="right">旧密码：</td>
    <td height="18" width="50%" align="left"><input type='password' class="text" name='oldPassword' value=''></td>
    </tr>
    <tr><td height="18" width="50%" nowrap align="right">新密码：</td>
    <td height="18" width="50%" align="left"><input type='password' class="text" name='PasswordHash' value=''></td>
    </tr>
    <tr><td height="18" width="50%" nowrap align="right">再次输入新密码：</td>
    <td height="18" width="50%" align="left"><input type='password' class="text" name='PasswordHash' value=''></td>
    </tr>
 </table><br>
         <table width="33%" border="0" cellspacing="0" cellpadding="0" align="center" height="22">
          <tr>
            <td width="70%" height="2" align='right'>
              <select size="1" name="command">
                <option value="0">--选择--</option>
                <option selected value="UserUpdate">修改密码</option>
              </select>
            </td>
            <td width="30%" height="2" align='left'>
              <input type="image" name="Submit" value="Submit"  src="../images/exec_btm.gif" border="0" >
            </td>
        </table>
 </form>

             <!-- user infor above--><br>
            </td>
          </tr>
        </table>
    <br><br>
      </td>
    </tr>
  </table>
    <br><br>
<%
    String footerjsp= "/footer.jsp";
 %>

  <tiles:insert page='<%=footerjsp %>'>
</tiles:insert>		
    </div>
</div>
<%@ include file="/html/nds/footer_info.jsp" %>
