<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">

<HTML>

<HEAD>
  <TITLE><wiki:Variable var="ApplicationName" /> Edit: <wiki:PageName /></TITLE>
  <META NAME="ROBOTS" CONTENT="NOINDEX">
  <%@ include file="cssinclude.js" %>
</HEAD>

<BODY class="edit" BGCOLOR="#D9E8FF" onLoad="document.forms[1].text.focus()">

<TABLE BORDER="0" CELLSPACING="8">

  <TR>

    <TD CLASS="page" WIDTH="85%" VALIGN="top">

      <TABLE WIDTH="100%" CELLSPACING="0" CELLPADDING="0" BORDER="0">
         <TR>
            <TD align="left">
                <H1 CLASS="pagename"><i18n:message key="EditTemplate.edit" /> <wiki:PageName/></H1></TD>
            <TD align="right">
                <%@ include file="SearchBox.jsp" %>
            </TD>
         </TR>
      </TABLE>

      <HR><P>

      <wiki:CheckVersion mode="notlatest">
         <P CLASS="versionnote"><i18n:message key="EditTemplate.youAreAboutTo" /> 
         <wiki:PageVersion/><i18n:message key="EditTemplate.youAreAboutToClickRestore" />
         </P>
      </wiki:CheckVersion>

      <wiki:CheckLock mode="locked" id="lock">
         <P CLASS="locknote"><i18n:message key="EditTemplate.user" /> '<%=lock.getLocker()%>' 
         <i18n:message key="EditTemplate.userHasStarted" />
         <%=lock.getTimeLeft()%> 
         <i18n:message key="EditTemplate.userHasStartedTimeAgo" />
         </P>
      </wiki:CheckLock>

      <FORM action="<wiki:EditLink format="url" />" method="POST" 
            ACCEPT-CHARSET="<wiki:ContentEncoding />">

      <%-- These are required parts of this form.  If you do not include these,
           horrible things will happen.  Do not modify them either. --%>

      <%-- FIXME: This is not required, is it? --%>
      <INPUT type="hidden" name="page"     value="<wiki:PageName/>">
      <INPUT type="hidden" name="action"   value="save">
      <INPUT type="hidden" name="edittime" value="<%=pageContext.getAttribute("lastchange", PageContext.REQUEST_SCOPE )%>">

      <%-- End of required area --%>

      <TEXTAREA CLASS="editor" wrap="virtual" name="text" rows="25" cols="80" style="width:100%;"><wiki:InsertPage mode="plain" /></TEXTAREA>

      <P>
      <input type="submit" name="ok" value="<i18n:message key="EditTemplate.save" />" />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="submit" name="preview" value="<i18n:message key="EditTemplate.preview" />" />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="submit" name="cancel" value="<i18n:message key="EditTemplate.cancel" />" />
      </FORM>

      </P>
      <P>
      <wiki:NoSuchPage page="EditPageHelp">
         <i18n:message key="EditTemplate.editPageHelp" /> <wiki:EditLink page="EditPageHelp">?</wiki:EditLink>
         <i18n:message key="EditTemplate.editPageHelpMissing" />
      </wiki:NoSuchPage>
      </P>

      <wiki:InsertPage page="EditPageHelp" />

    </TD>
  </TR>

</TABLE>

</BODY>

</HTML>

