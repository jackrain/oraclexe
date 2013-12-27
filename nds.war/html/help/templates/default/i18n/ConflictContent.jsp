<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>

   <DIV class="conflictnote">
      <P><B><i18n:message key="ConflictContent.oops" /></B></P>

      <P><i18n:message key="ConflictContent.oopsStupid" /></P>

      <P><i18n:message key="ConflictContent.oopsNote" /></P>

   </DIV>

      <P><font color="#0000FF"><i18n:message key="ConflictContent.modifiedText" />:</FONT></P>

      <P><HR></P>

      <TT>
        <%=pageContext.getAttribute("conflicttext",PageContext.REQUEST_SCOPE)%>
      </TT>      

      <P><HR></P>

      <P><FONT COLOR="#0000FF"><i18n:message key="ConflictContent.yourText" />:</FONT></P>

      <TT>
        <%=pageContext.getAttribute("usertext",PageContext.REQUEST_SCOPE)%>
      </TT>

      <P><HR></P>

      <P>
       <I>Go edit <wiki:EditLink><wiki:PageName /></wiki:EditLink>.</I>
      </P>

