<%@ page import="com.ecyrd.jspwiki.tags.InsertDiffTag" %>
<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%!
    String getVersionText( Integer ver )
    {
        return ver.intValue() > 0 ? ("version "+ver) : "current version";
    }
%>

      <wiki:PageExists>
          <i18n:message key="DiffContent.diffBetween" /> 
          <%=getVersionText((Integer)pageContext.getAttribute(InsertDiffTag.ATTR_OLDVERSION, PageContext.REQUEST_SCOPE))%> 
          <i18n:message key="DiffContent.diffBetweenAnd" />
          <%=getVersionText((Integer)pageContext.getAttribute(InsertDiffTag.ATTR_NEWVERSION, PageContext.REQUEST_SCOPE))%>:
          <DIV>
          <wiki:InsertDiff>
              <I><i18n:message key="DiffContent.noDiff" /></I>
          </wiki:InsertDiff>
          </DIV>

      </wiki:PageExists>

      <wiki:NoSuchPage>
             <i18n:message key="DiffContent.pageDoesNotExist" />
             <wiki:EditLink><i18n:message key="DiffContent.createIt" /></wiki:EditLink>?
      </wiki:NoSuchPage>

      <P>
       <i18n:message key="DiffContent.backTo" /> <wiki:LinkTo><wiki:PageName/></wiki:LinkTo>,
       <i18n:message key="DiffContent.backToOrTo" /> <wiki:PageInfoLink><i18n:message key="DiffContent.backToOrToHistory" /></wiki:PageInfoLink>.
       </P>

