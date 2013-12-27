<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>

      <P>
      <i18n:message key="PreferencesContent.remark" />
      </P>

      <FORM action="<wiki:Variable var="baseURL"/>UserPreferences.jsp" 
            method="POST"
            ACCEPT-CHARSET="UTF-8">

         <B><i18n:message key="PreferencesContent.userName" />:</B> <INPUT type="text" name="username" size="30" value="<wiki:UserName/>">
         <I><i18n:message key="PreferencesContent.userNameInstruction" /></I>
         <BR><BR>
         <INPUT type="submit" name="ok" value="<i18n:message key="PreferencesContent.setPreferences" />">
         <INPUT type="hidden" name="action" value="save">
      </FORM>

      <HR/>

      <H3><i18n:message key="PreferencesContent.removingPreferences" /></h3>

      <P><i18n:message key="PreferencesContent.removingPreferencesInstructions" />
      </P>

      <DIV align="center">
      <FORM action="<wiki:Variable var="baseURL"/>UserPreferences.jsp"
            method="POST"
            ACCEPT-CHARSET="UTF-8">
      <INPUT type="submit" name="clear" value="<i18n:message key="PreferencesContent.removingPreferencesButton" />" />
      </FORM>
      </DIV>

