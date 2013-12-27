<%@ taglib uri="/WEB-INF/jspwiki.tld" prefix="wiki" %>
<%@ taglib uri="/WEB-INF/taglibs-i18n.tld" prefix="i18n" %>

<%-- Inserts page content. --%>

      <%-- If the page is an older version, then offer a note and a possibility
           to restore this version as the latest one. --%>

      <wiki:CheckVersion mode="notlatest">
         <FONT COLOR="red">
            <P CLASS="versionnote"><i18n:message key="PageContent.thisIsVersion" /> <wiki:PageVersion/>.  
            <i18n:message key="PageContent.notCurrentVersion" /><BR/>
            <wiki:LinkTo>[<i18n:message key="PageContent.backToCurrent" />]</wiki:LinkTo>&nbsp;&nbsp;
            <wiki:EditLink version="this">[<i18n:message key="PageContent.restoreThis" />]</wiki:EditLink></P>
         </FONT>
         <HR />
      </wiki:CheckVersion>

      <%-- Inserts no text if there is no page. --%>

      <wiki:InsertPage />

      <wiki:NoSuchPage>
           <!-- FIXME: Should also note when a wrong version has been fetched. -->
           <i18n:message key="PageContent.pageDoesNotExist" />
           <wiki:EditLink><i18n:message key="PageContent.createIt" /></wiki:EditLink>?
      </wiki:NoSuchPage>

      <BR CLEAR="all" />

      <wiki:HasAttachments>
         <B><i18n:message key="PageContent.attachments" />:</B>

         <DIV class="attachments" align="center">
         <table width="90%">
         <wiki:AttachmentsIterator id="att">
             <tr>
             <td><wiki:LinkTo><%=att.getFileName()%></wiki:LinkTo></td>
             <td><wiki:PageInfoLink><img src="images/attachment_big.png" alt="<i18n:message key="PageContent.infoOn" /> <%=att.getFileName()%>"></wiki:PageInfoLink></td>
             <td><%=att.getSize()%> <i18n:message key="PageContent.bytes" /></td>
             </tr>
         </wiki:AttachmentsIterator>
         </table>
         </DIV>
      </wiki:HasAttachments>

      <P>
	&nbsp;&nbsp;<a href="Wiki.jsp?page=Help"><img src="images/home.gif" border=0><i18n:message key="PageContent.helpHome" /></a>
	<HR />
      <table border="0" width="100%">
        <tr>
          <td align="left">
          <%
          	if(nds.control.web.WebUtils.isDirectoryPermissionEnabled("WIKI",3,request)){
          %>
             <wiki:Permission permission="edit">
                 <wiki:EditLink><i18n:message key="PageContent.editThisPage" /></wiki:EditLink>&nbsp;&nbsp;
             </wiki:Permission>
             <wiki:PageInfoLink><i18n:message key="PageContent.moreInfo" /></wiki:PageInfoLink>&nbsp;&nbsp;
             <a href="javascript:window.open('<wiki:UploadLink format="url" />','Upload','width=640,height=480,toolbar=1,menubar=1,scrollbars=1,resizable=1,').focus()"><i18n:message key="PageContent.attachFile" /></a>
             <BR />
            <%
          	}
          	
          %>
          </td>
        </tr>
        <tr>
          <td align="left">
             <FONT size="-1" >
             
             <wiki:CheckVersion mode="latest">
                 <I><i18n:message key="PageContent.lastChange" /> <wiki:DiffLink version="latest" newVersion="previous"><wiki:PageDate/></wiki:DiffLink> <i18n:message key="PageContent.lastChangeBy" /> <wiki:Author />.</I>
             </wiki:CheckVersion>
             <wiki:CheckVersion mode="notlatest">
                 <I><i18n:message key="PageContent.versionPublished" /> <wiki:PageDate/> <i18n:message key="PageContent.versionPublishedBy" /> <wiki:Author /></I>.
             </wiki:CheckVersion>
 
             <wiki:NoSuchPage>
                 <I><i18n:message key="PageContent.pageNotCreated" /></I>
             </wiki:NoSuchPage>
             </font>
			<p>
             <FONT size="-1"color="#DDDDDD">
			<%="<b>Agile ERP</b> (Enterprise Resource Portal)&nbsp; \u7248\u672c <b>2.0</b>"%>
			<!--
			<%="<br> \u7248\u6743\u6240\u6709(C) 2002-2006 \u4e0a\u6d77\u5f00\u6d4e\u4fe1\u606f\u6280\u672f\u6709\u9650\u516c\u53f8"%>
			-->
             </FONT>
          </td>
        </tr>
      </table>

