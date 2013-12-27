<%@ page import="com.ecyrd.jspwiki.Release" %>
<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<!-- LeftMenuFooter is automatically generated from a Wiki page called "LeftMenuFooter" -->

<P>
    <wiki:InsertPage page="LeftMenuFooter" />
    <wiki:NoSuchPage page="LeftMenuFooter">
        <HR><P>
        <P ALIGN="center">
        <I><i18n:message key="LeftMenuFooter.noLeftMenuFooter" /></I><BR>
        <wiki:EditLink page="LeftMenuFooter"><i18n:message key="LeftMenuFooter.pleaseMakeOne" /></wiki:EditLink><BR>
        </P>
        <P><HR>
    </wiki:NoSuchPage>
</P>

<!-- End of automatically generated page -->

   <BR><BR><BR>
   <DIV ALIGN="left" CLASS="small">
   <%=Release.APPNAME%> v<%=Release.VERSTR%>
   </DIV>



