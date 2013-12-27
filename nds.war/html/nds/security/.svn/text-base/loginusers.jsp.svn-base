<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/header.jsp" %>
<%
	String tabName= PortletUtils.getMessage(pageContext, "loginusers",null);
%>
<script>
	document.title="<%=tabName%>";
</script>
<div id="maintab">
	<ul><li><a href="#tab1"><span><%=tabName%></span></a></li></ul>
	<div id="tab1">
<%!
    private static java.text.SimpleDateFormat dateFormat=
        new java.text.SimpleDateFormat("yyyy/MM/dd,HH:mm");

%>
<%
        /**
         * parameter :
         *
         * 1.  "sessionId" String[] in HttpServletRequest
         * 2.  "action" if is "modify", then all sessionIds will be removed
         */
%>
<%
String directory;
directory="LOGINUSER_LIST";
WebUtils.checkDirectoryReadPermission(directory,request);

    ServletContextManager manager= (ServletContextManager)application.getAttribute(nds.util.WebKeys.SERVLET_CONTEXT_MANAGER);
    SecurityManagerWebImpl se=(SecurityManagerWebImpl)manager.getActor(nds.util.WebKeys.SECURITY_MANAGER);
    String[] sessionIds= request.getParameterValues("sessionId");
    String action= request.getParameter("action");
    if( "modify".equals(action) && sessionIds!=null){
        // remove sessionIds
        for(int i=0;i< sessionIds.length;i++){
            se.unregister(sessionIds[i]);
        }
    }
    Collection c=se.getLoginSessions();// elements of SessionInfo
    Vector sessions=new Vector(c);
    ListSort.sort(sessions);


%>

<form name="session_form" method="post" action="<%=NDS_PATH+"/security/loginusers.jsp"%>">
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
  <tr>
      <td>
          <br>
            <table width="98%" border="1" cellspacing="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#999999">
              <tr bgcolor="#EBF5FD">
                <td width="10%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "select",null)%></span>
                </td>
                <td width="20%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "username",null)%></span>
                </td>
                <td width="30%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "ipaddress",null)%></span>
                </td>
                <td width="40%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "start-time",null)%></span>
                </td>
                <td width="40%" align="center">
                  <span><%=PortletUtils.getMessage(pageContext, "last-activity-time",null)%></span>
                </td>
              </tr>

               <%
                 int userTableId= TableManager.getInstance().getTable("Users").getId();
                 for (int i=0;i< sessions.size();i++){
                    SessionInfo info= (SessionInfo) sessions.elementAt(i)   ;
                    String userName=info.getUserName();
                    String sessionId= info.getSessionId();
                    String link= NDS_PATH+"/object/object.jsp?input=false&table="+userTableId+"&id="+info.getUserId();
                    String time= dateFormat.format(new Date(info.getCreationTime()));
                    String ip= info.getHostIP();
                    String lastTime=dateFormat.format(new Date(info.getLastActiveTime()));
                    String color;
               %>

              <tr bgcolor='<%=((i % 2 ==0 )?"#ffffff":"#FFFFFF") %>'>
                <td height="20" width="10%" align="center"><input type='checkbox' class="checkbox" name='sessionId' value='<%=sessionId %>'><%=i%></td>
                <td height="20" width="20%"><a href="<%=link %>"> <%= userName%></a></td>
                <td height="20" width="20%"><%=ip %></td>
                <td height="20" width="20%"><%=time %></td>
                <td height="20" width="30%"><%=lastTime %></td>
              </tr>
              <%
                }
              %>
            </table>
        <br><%
            SessionContextManager sme=WebUtils.getSessionContextManager(request.getSession());
            UserWebImpl usr=null;
            boolean isRoot=false;
            if( sme !=null ) usr =(UserWebImpl)sme.getActor(nds.util.WebKeys.USER);
            if( usr !=null) isRoot= (usr.getUserId()==0);
            if( isRoot){
                // only root can delete the sessions
        %>
        <table width="13%" border="0" cellspacing="0" cellpadding="0" align="center" height="22">
          <tr>
            <td align="center">
            <input type='hidden' name="action" value="modify">
             <input type="button" name="dosubmit" value="<%=PortletUtils.getMessage(pageContext, "disconnect-session",null)%>" onClick="javascript:submitForm(session_form);" >
             </td>
          </tr>
        </table>
        <%}%>
          <br>
          </td>
        </tr>

 </table>
 </form>
		
    </div>
</div>			
<%@ include file="/html/nds/footer_info.jsp" %>
