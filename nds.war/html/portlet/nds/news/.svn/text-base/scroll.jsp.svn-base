<%@page errorPage="/html/nds/error.jsp"%>
<%@ include file="/html/nds/common/init.jsp" %>
<%
	/**
	* Parameters:
	*   url -  (String)	 url template, id replace by "NEWSOBJECTID"
	*/
%>
<%!
	/**
	*  max length to be display for the news' subject,
	*  if greater than that, will append ".."
	*/
 	private final static int MAX_SUBJECT_LENGTH=30;
%>

<html><head>
<%@ include file="/html/common/init.jsp" %>
<%@ include file="/html/common/themes/top_meta.jsp" %>
<%@ include file="/html/common/themes/top_meta-ext.jsp" %>
<link rel="Shortcut Icon" href="<%= themeDisplay.getPathThemeImage() %>/liferay.ico" />
<link href="<%= themeDisplay.getPathMain() %>/portal/css_cached?themeId=<%= themeDisplay.getTheme().getThemeId() %>&colorSchemeId=<%= themeDisplay.getColorScheme().getColorSchemeId() %>" type="text/css" rel="stylesheet" />
<link href="<%= themeDisplay.getPathJavaScript() %>/calendar/skins/aqua/theme.css" rel="stylesheet" type="text/css" />

	<script language="JavaScript" src="<%= contextPath %>/html/nds/js/common.js"></script>
	<script language="JavaScript" src="<%= contextPath %>/html/nds/js/print.js"></script>
	<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal.css">
	<title><%= request.getParameter("html_title") %></title>

<style>
a {text-decoration: none}
A:visited{TEXT-DECORATION: none}
A:hover{color: #FF6600}
a:active {  color: #FF0000}
.dateview{FONT-SIZE: 9px; COLOR: #6666cc;}
</style>	
</head>
<body bgcolor="<%=colorScheme.getPortletBg()%>">
<script language="javascript">
	function open_nds_window(url){
		window.open(url ,'_blank','status=yes,resizable=yes,scrollbars=yes,location=no,menubar=no,toolbar=no');
	}
   var url="<%=JS.decodeURIComponent( request.getParameter("url"))%>";
   function viewNewsObject(objectId){
   		var l= 	url.replace(/NEWSOBJECTID/g,""+objectId);	
   		top.location=l;
   }
<%

  // load lastest 10 news
UNewsDAO dao=new UNewsDAO();  
 QueryResult result;
 int oid;
 String subject, contenturl;
 String date;
 int scrollWidth;
 
 result= dao.find(request, 10, 0,-1,null);
 int i=0;
 String marquee="";
DateFormat df = new java.text.SimpleDateFormat("dd HH");
//df.setTimeZone(timeZone);
 String link;
 while(result.next()){
 	 i++;
 	 oid=((java.math.BigDecimal)result.getObject(1)).intValue();
 	 subject= (String)result.getObject(2);
 	 if(Validator.isNull(subject)){
 	 	subject=StringUtils.NBSP;
 	 }else{
 	 	subject=StringUtils.shortenInBytes(subject, MAX_SUBJECT_LENGTH);
 	 }
 	 if(result.getObject(3) !=null){ 
 	 	//System.out.println(result.getObject(3).getClass().getName()+","+ result.getObject(3));
 	 	date= df.format((java.util.Date)result.getObject(3));
 	 }else{
 	 	date=StringUtils.NBSP;
 	 }
 	 contenturl= (String) result.getObject(5);
 	 if( contenturl ==null)
 	 	link="<a href='javascript:viewNewsObject("+oid+")'>"+subject+"</a>";
 	 else
 	 	link="<a href='javascript:popup_window(\""+contenturl+"\")'>"+subject+"<img border=0 src='"+NDS_PATH+"/images/outlink.png' class='outlink'></a>";
 	 if(i==1){
 	 %>
 	 //var nc = "<%=link%><br>";
<%}
     marquee +=	"<span class='dateview'>"+ date+"</span> "+ link;	
  }
%>
	</script>

<marquee SCROLLAMOUNT=12 onmouseover='this.stop()' onmouseout='this.start()' scrollDelay=500>
<font color=#ff0000><%=PortletUtils.getMessage(pageContext, "latest-news",null)%>:</font>
 <%=marquee%>...
 <a href=javascript:location.reload()><%=PortletUtils.getMessage(pageContext, "refresh",null)%></a>
 </marquee><br>
</body>
</html>
