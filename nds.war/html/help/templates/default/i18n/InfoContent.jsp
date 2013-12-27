<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>

<wiki:PageExists>

   <table cellspacing="4">
       <tr>
           <td><B><i18n:message key="InfoContent.pageName" /></B></td>
           <td><wiki:LinkTo><wiki:PageName /></wiki:LinkTo></td>
       </tr>

       <wiki:PageType type="attachment">
           <tr>
              <td><B><i18n:message key="InfoContent.parentPage" /></B></td>
              <td><wiki:LinkToParent><wiki:ParentPageName /></wiki:LinkToParent></td>
           </tr>
       </wiki:PageType>

       <tr>
           <td><B><i18n:message key="InfoContent.pageLastModified" /></B></td>
           <td><wiki:PageDate /></td>
       </tr>

       <tr>
           <td><B><i18n:message key="InfoContent.currentPageVersion" /></B></td>
           <td><wiki:PageVersion><i18n:message key="InfoContent.noVersions" /></wiki:PageVersion></td>
       </tr>

       <tr>
           <td valign="top"><b><i18n:message key="InfoContent.pageRevisionHistory" /></b></td>
           <td>
               <table border="1" cellpadding="4">
                   <tr>
                        <th><i18n:message key="InfoContent.version" /></th>                        
                        <th><i18n:message key="InfoContent.date" /> <wiki:PageType type="page"> <i18n:message key="InfoContent.datendMore" /></wiki:PageType></th>
                        <th><i18n:message key="InfoContent.author" /></th>
                        <th><i18n:message key="InfoContent.size" /></th>
                        <wiki:PageType type="page">                        
                            <th><i18n:message key="InfoContent.changes" /></th>
                        </wiki:PageType>
                   </tr>
                   <wiki:HistoryIterator id="currentPage">
                     <tr>
                         <td>
                             <wiki:LinkTo version="<%=Integer.toString(currentPage.getVersion())%>">
                                  <wiki:PageVersion/>
                             </wiki:LinkTo>
                         </td>

                         <td>
                             <wiki:PageType type="page">
                             <wiki:DiffLink version="latest" 
                                            newVersion="<%=Integer.toString(currentPage.getVersion())%>">
                                 <wiki:PageDate/>
                             </wiki:DiffLink>
                             </wiki:PageType>

                             <wiki:PageType type="attachment">
                                 <wiki:PageDate/>
                             </wiki:PageType>
                         </td>

                         <td><wiki:Author /></td>
                         <td><wiki:PageSize /></td>

                         <wiki:PageType type="page">
                           <td>
                              <% if( currentPage.getVersion() > 1 ) { %>
                                   <wiki:DiffLink version="<%=Integer.toString(currentPage.getVersion())%>" 
                                                  newVersion="<%=Integer.toString(currentPage.getVersion()-1)%>">
                                       <i18n:message key="InfoContent.fromVersion" /> <%=currentPage.getVersion()-1%> <i18n:message key="InfoContent.fromVersionTo" /> <%=currentPage.getVersion()%>
                                   </wiki:DiffLink>
                               <% } %>
                           </td>
                         </wiki:PageType>
                     </tr>
                   </wiki:HistoryIterator>
               </table>
           </td>
      </tr>
</table>
             
    <BR />
    <wiki:PageType type="page">
       <wiki:LinkTo><i18n:message key="InfoContent.backTo" /> <wiki:PageName/></wiki:LinkTo>
    </wiki:PageType>
    <wiki:PageType type="attachment">

       <form action="attach" method="POST" enctype="multipart/form-data">

           <%-- Do NOT change the order of wikiname and content, otherwise the 
                servlet won't find its parts. --%>

           <input type="hidden" name="page" value="<wiki:Variable var="pagename"/>">

           <i18n:message key="InfoContent.insctruction" />
           

           <P>
           <input type="file" name="content">
           <input type="submit" name="upload" value="<i18n:message key="InfoContent.update" />">
           <input type="hidden" name="action" value="upload">
           <input type="hidden" name="nextpage" value="<wiki:PageInfoLink format="url"/>">
           </form>


    </wiki:PageType>

</wiki:PageExists>


<wiki:NoSuchPage>
    <i18n:message key="InfoContent.pageDoesNotExist" />
    <wiki:EditLink><i18n:message key="InfoContent.createIt" /></wiki:EditLink>?
</wiki:NoSuchPage>

