<%
/**
* View single news object 
*/
UNews newsObject=dao.load(new Integer(objectId));
String errNewsMessage= null;
if(newsObject==null){
	errNewsMessage=PortletUtils.getMessage(pageContext, "object-not-exists",null);
}
if(!"Y".equals(newsObject.getIsPublic())){
	if( dao.isGuest(userWeb)){
		//is guest and news is not public
		errNewsMessage=PortletUtils.getMessage(pageContext, "login-to-read-private-news",null);
	}else if(!userWeb.hasObjectPermission("u_news",objectId, nds.security.Directory.READ)){
		errNewsMessage=PortletUtils.getMessage(pageContext, "no-permission",null);
	}
}

 if(errNewsMessage!=null){	
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td align="center">
<font class="bg" size="2"><span class="bg-neg-alert">
<%=errNewsMessage%>
</span></font>
</td></tr></table>

<%}else{// not error, show show the news object
	String content= ""; // this is error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	UNews parentNews =  newsObject.getParentNews();
	
%>
<style type="text/css">
<!--
.ftitle {
	FONT-WEIGHT: bold; FONT-SIZE: 23px; COLOR: #104171; line-height: 40px
}
.style2 {
	font-size: 12px;
}
-->
</style>
          <DIV class=div>
            <TABLE border=0 cellSpacing=2 cellPadding=0 width="95%" border=0>
              <TBODY>
              <% if(parentNews!=null ||dao.isGuest(userWeb) ){
              %>
              <tr>
              	<td><table width="100%" cellSpacing=2 cellPadding=2>
              		<tr>
              		<%if(parentNews!=null){%>
              		<td align="left"><font class='gamma'><%=PortletUtils.getMessage(pageContext, "belong-topic",null)%>:&nbsp;
              		<a class="redlink" href="javascript:opw_<%=renderResponse.getNamespace()%>(<%=newsObject.getParentId()%>)">
 						<%=parentNews.getSubject()%>
 					</a></font></td>
 					<%}
 					if(dao.isGuest(userWeb)){%>
 					<td align="right"><%=newsObject.getAdClient().getDescription()%></td>
 					<%}%>
 					</tr></table>
 					
              	</td>
              </tr>
              <%}%>
              <tr>
              	<td align='center'  valign="bottom" height="25">
              		<div class="ftitle"><%=newsObject.getSubject() %> </div>
              	</td> 
              </tr>
              <tr>
              	<td align='center'  valign="middle" height="14">
              		<div class="style2">
              		
              		<%= (newsObject.getPublisher()==null?"":newsObject.getPublisher())%>
              		&nbsp;&nbsp;<%= (newsObject.getAuthor()==null?"":newsObject.getAuthor())%>
              		&nbsp;&nbsp;<%=((java.text.SimpleDateFormat)QueryUtils.dateFormatter.get()).format(newsObject.getModifiedDate())%>
              		 </div>
              		
              	</td> 
              </tr>
              <tr height=20>
              	<td align='center' >
              	</td> 
              </tr>
              <TR>
                <TD><DIV>
                <%=content%>
                </DIV></TD>
              </TR>
              
              <tr><td>
        			<%@ include file="/html/portlet/nds/news/inc_toplink.jsp" %> 
              </td>
              </tr>
              <tr><td>
              
        			<%@ include file="/html/portlet/nds/news/inc_relatelink.jsp" %> 
              </td>
              </tr>
              <tr><td>
<table border=0 cellSpacing=0 cellPadding=0 width="90%" border=0 align="center">
<tr height="20"><td align="right">
<script>
 function edit_<%=renderResponse.getNamespace()%>(){
 	popup_window("/html/nds/sheet/object.jsp?table=u_news&id=<%=objectId%>");
 }
</script>
<font class='gamma'>
<% if(userWeb.hasObjectPermission("u_news",objectId,nds.security.Directory.WRITE)){%>
[<a class="redlink" href="javascript:edit_<%=renderResponse.getNamespace()%>();" >
	<%=PortletUtils.getMessage(pageContext, "edit",null)%>
</a>]&nbsp;&nbsp;
<%}%>
[
<a class="redlink" href="<portlet:renderURL  windowState="<%= WindowState.NORMAL.toString() %>"></portlet:renderURL>" >
	<%=PortletUtils.getMessage(pageContext, "windowstate-normalize",null)%>
</a>]&nbsp;&nbsp;[
<a class="redlink" href="javascript:window.close();" >
	<%=PortletUtils.getMessage(pageContext, "close",null)%>
</a>]&nbsp;&nbsp;[
<a class="redlink" href="<portlet:renderURL  windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="categoryid" value="<%="-1"%>" /></portlet:renderURL>" >
	<%=PortletUtils.getMessage(pageContext, "show-all-news",null)%>
</a>]</font>
</td></tr></table>
              </td>
              </tr>
              </TBODY>
              </TABLE>
          </DIV>
<%}//end if acitve
%>
