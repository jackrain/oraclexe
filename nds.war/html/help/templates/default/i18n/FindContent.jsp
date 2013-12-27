<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>
<%@ page import="com.ecyrd.jspwiki.*" %>
<%@ page import="java.util.Collection" %>

<%-- FIXME: Get rid of the scriptlets. --%>
<%
    Collection list = (Collection)pageContext.getAttribute( "searchresults",
                                                             PageContext.REQUEST_SCOPE );

    String query = (String)pageContext.getAttribute( "query",
                                                     PageContext.REQUEST_SCOPE );
    if( query == null ) query = "";
%>

      <H2><i18n:message key="FindContent.findPages" /></H2>

      <% if( list != null ) 
      {
      %>
          <H4><i18n:message key="FindContent.searchResults" /> '<%=query%>'</H4>

          <P>
          <I><i18n:message key="FindContent.found" /> <%=list.size()%> <i18n:message key="FindContent.foundHits" /></I>
          </P>

          <table border="0" cellpadding="4">

          <tr>
             <th width="30%" align="left"><i18n:message key="FindContent.page" /></th>
             <th align="left"><i18n:message key="FindContent.score" /></th>
          </tr>          
          <% if( list.size() > 0 ) { %>
              <wiki:SearchResultIterator list="<%=list%>" id="searchref" maxItems="20">
                  <TR>
                      <TD WIDTH="30%"><wiki:LinkTo><wiki:PageName/></wiki:LinkTo></TD>
                      <TD><%=searchref.getScore()%></TD>
                  </TR>
              </wiki:SearchResultIterator>
          <% } else { %>
              <TR>
                  <TD width="30%"><B><i18n:message key="FindContent.noResults" /></B></TD>
              </TR>
          <% } %>

          </table>
          <P>
          <A HREF="http://www.google.com/search?q=<%=query%>" TARGET="_blank"><i18n:message key="FindContent.tryGoogle" /></A>
          </P>
          <P><HR></P>
      <%
      }
      %>

      <P>

      <FORM action="<wiki:Variable var="baseURL"/>Search.jsp"
            ACCEPT-CHARSET="ISO-8859-1,UTF-8">

      <i18n:message key="FindContent.enterQuery" />:<BR>
      <INPUT type="text" name="query" size="40" value="<%=query%>">

      <P>
      <input type="submit" name="ok" value="<i18n:message key="FindContent.find" />" />
      </FORM>

      <P>
      <i18n:message key="FindContent.helpSigns" />
      
