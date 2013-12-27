<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>

<%-- Inserts page content for preview. --%>

   <DIV class="previewnote">
      <B><i18n:message key="PreviewContent.pageTitle" /></B>
   </DIV>

   <P><HR></P>

   <DIV class="previewcontent">
      <wiki:Translate><%=pageContext.getAttribute("usertext",PageContext.REQUEST_SCOPE)%></wiki:Translate>
   </DIV>

   <BR clear="all" />

   <P><HR></P>

   <DIV class="previewnote">
      <B><i18n:message key="PreviewContent.pageTitle" /></B>
   </DIV>

