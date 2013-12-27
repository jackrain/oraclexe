<%@ include file="/html/nds/common/init.jsp" %>
<%
String title= PortletUtils.getMessage(pageContext, "web-option",null);
int pagesize=Tools.getInt(request.getParameter("pagesize"),-1);
int clientId=Tools.getInt(userWeb.getAdClientId(),-1);
%>

<liferay-util:include page="/html/nds/header.jsp">
	<liferay-util:param name="html_title" value="<%=title%>" />
	<liferay-util:param name="show_top" value="true" />
	<liferay-util:param name="enable_context_menu" value="true" />	
	<liferay-util:param name="table_width" value="100%" />
</liferay-util:include>
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="highslide-styles-ie6.css" />
<![endif]-->
<script type="text/javascript" src="/html/nds/js/highslide.js"></script>
<script type="text/javascript" src="/html/nds/js/select_template.js"></script>
<link rel="stylesheet" type="text/css" href="/highslide-styles.css">
<script type="text/javascript">


//<![CDATA[
hs.graphicsDir ='/images/';
hs.lang.restoreTitle='<%= PortletUtils.getMessage(pageContext, "contraction",null) %>';
// remove the registerOverlay call to disable the close button
hs.registerOverlay({
	overlayId: 'closebutton',
	position: 'top right',
	fade: 2 // fading the semi-transparent overlay looks bad in IE
});
</script>
<%
List params= QueryEngine.getInstance().doQueryList("select name,foldername,description,previewlurl,imgurl from ad_site_template");
int totnum=params.size();
int pagetotsize=0;
int j=0;
if(params.size()%3==0){
   pagetotsize=params.size()/3;
}else{
 pagetotsize=params.size()/3+1;
}

if(pagesize<0){
   pagesize=0;
 }else if(pagesize>=pagetotsize){
   pagesize=pagetotsize-1;
 }

%>
<script type="text/javascript">
function popup_window(url,tgt,theWidth,theHeight){
    if(tgt==null|| tgt==undefined) tgt="_blank";
    if(theWidth==null|| theWidth==undefined) theWidth=951;
    if(theHeight==null|| theHeight==undefined) theHeight=570;
	var theTop=(screen.height/2)-(theHeight/2);
	var theLeft=(screen.width/2)-(theWidth/2);
	var features="height="+theHeight+",width="+theWidth+",top="+theTop+",left="+theLeft+",dependent=yes,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,status=yes";
    var newWindow=window.open(url,tgt,features);
    newWindow.focus();
}
//]]>
</script>
<div id="maintab">
<ul>
	<li><a href='#tab1'><span><%= PortletUtils.getMessage(pageContext, "web-option",null) %></span></a></li>
</ul>

<div id="tab1">
<div id="ytre">
	<div>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="5" class="index-td">
                <br>
                <br>	
                	<div align="center"><span><%= PortletUtils.getMessage(pageContext, "web-message",null) %></span></div></td>
                </tr>
              <tr>
     <%
	 for(int i=pagesize*3;i<(pagesize+1)*3&&i<totnum;i++){
	    j=i+1;
	    String str1="";
	    String str2="";
	    String str3=(String)((List)params.get(i)).get(1);
	    if(j<10){
	       str1="/images/full00"+j;
	       str2="/images/thumb00"+j;
	        
	    }else{
	     str1="/images/full0"+j;
	     str2="/images/thumb0"+j;
	    }
	 %>
	 <td  width="33%" align="center">
	 <a href="<%=str1%>.jpg" class="highslide" onclick="return hs.expand (this)">
		<img style="margin-top: 15px;" src="<%=str2%>.jpg"  title="<%= PortletUtils.getMessage(pageContext, "enlarge",null)%>" width="200" height="150" border="0">	</a>
		 <div class="highslide-caption" align="center"><input type="button" onclick="st.cloose_template('<%=str3%>',<%=clientId%>)" value="<%= PortletUtils.getMessage(pageContext, "customize",null)%>">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="<%= PortletUtils.getMessage(pageContext, "template-instance",null)%>" onclick="popup_window('<%=(String)((List)params.get(i)).get(3)%>');"></div>
		<div id="closebutton" class="highslide-overlay closebutton" onclick="return hs.close(this)" title="<%= PortletUtils.getMessage(pageContext, "close",null)%>"></div>
		&nbsp;&nbsp;&nbsp;<input type="button" onclick="st.cloose_template('<%=str3%>',<%=clientId%>);" value="<%= PortletUtils.getMessage(pageContext, "customize",null)%>">&nbsp;&nbsp;
		<input type="button" value="<%= PortletUtils.getMessage(pageContext, "template-instance",null)%>" onclick="popup_window('<%=(String)((List)params.get(i)).get(3)%>');">
		</div>
		</div>
	</td>
	 <td>&nbsp;</td>
	<%}%>
              </tr>
   </table> 
	<div>
		<br>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
		<%
		for(int k=pagesize*3;k<(pagesize+1)*3&&k<totnum;k++){
		    if((String)((List)params.get(k)).get(2)!=null){
		   %>
	     	<td width="2%">&nbsp;&nbsp;&nbsp;</td> 
	     	<td width="29%" >
	     		<%=(String)((List)params.get(k)).get(2)%>
	     	</td> 
	     	  <td width="2%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> 
			<%}else{%>
			<td width="33%" >&nbsp; </td>
	   <%}}%>
	    </tr>
	 </table>  
 </div>
<br>
<br>
<div align="center">
<img  src="/images/button-home.gif" onclick="javascript:window.open('select_template.jsp?pagesize=0','_self','');" />&nbsp;&nbsp;&nbsp;
<img  src="/images/button-up.gif" onclick="st.page(<%=pagesize-1%>,<%=pagetotsize%>);" />&nbsp;&nbsp;&nbsp;
<img  src="/images/button-down.gif" onclick="st.page(<%=pagesize+1%>,<%=pagetotsize%>);" />&nbsp;&nbsp;&nbsp;
<img  src="/images/button-end.gif" onclick="javascript:window.open('select_template.jsp?pagesize=<%=pagetotsize-1%>','_self','');" />
</div>
</div>
</div>

<%@ include file="/html/nds/footer_info.jsp" %>


