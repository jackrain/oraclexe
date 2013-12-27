<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">

<i18n:bundle scope="session" baseName="i18n.JSPWiki" debug="false"/>
<HTML>

<HEAD>
  <TITLE><wiki:Variable var="applicationname" />: <wiki:PageName /></TITLE>
  <%@ include file="cssinclude.js" %>
  <wiki:RSSLink />
</HEAD>

<BODY BGCOLOR="#FFFFFF">

<TABLE BORDER="0" CELLSPACING="8" width="95%">

    <TD CLASS="page" WIDTH="85%" VALIGN="top">

	<P>

      <wiki:CheckRequestContext context="view">
         <wiki:Include page="PageContent.jsp" />
      </wiki:CheckRequestContext>

      <wiki:CheckRequestContext context="diff">
         <wiki:Include page="DiffContent.jsp" />
      </wiki:CheckRequestContext>

      <wiki:CheckRequestContext context="info">
         <wiki:Include page="InfoContent.jsp" />
      </wiki:CheckRequestContext>

      <wiki:CheckRequestContext context="preview">
         <wiki:Include page="PreviewContent.jsp" />
      </wiki:CheckRequestContext>

      <wiki:CheckRequestContext context="conflict">
         <wiki:Include page="ConflictContent.jsp" />
      </wiki:CheckRequestContext>

      <wiki:CheckRequestContext context="find">
         <wiki:Include page="FindContent.jsp" />
      </wiki:CheckRequestContext>

      <wiki:CheckRequestContext context="prefs">
         <wiki:Include page="PreferencesContent.jsp" />
      </wiki:CheckRequestContext>

      <wiki:CheckRequestContext context="error">
         <wiki:Include page="DisplayMessage.jsp" />
      </wiki:CheckRequestContext>

    </TD>
  </TR>

</TABLE>

</BODY>

</HTML>


