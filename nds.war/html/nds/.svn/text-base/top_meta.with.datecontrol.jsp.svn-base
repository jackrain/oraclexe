<%@ include file="/html/common/init.jsp" %>
<%@ include file="/html/common/themes/top_meta.jsp" %>
<%@ include file="/html/common/themes/top_meta-ext.jsp" %>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico">
<script language="JavaScript" src="/html/nds/js/top_css_ext.js"></script>
<script type="text/javascript" language="JavaScript1.5" src="/html/nds/js/ieemu.js"></script>
<script language="JavaScript" src="/html/nds/js/cb2.js"></script>
<script language="JavaScript" src="/html/js/sniffer.js"></script>

<%if(BrowserSniffer.is_mozilla(request)){%>
	<script language="JavaScript" src="/html/nds/js/xmenu.js"></script>
	<script language="JavaScript" src="/html/nds/js/cssexpr.js"></script>
	<link type="text/css" rel="stylesheet" href="/html/nds/css/xmenu.css">
	<link type="text/css" rel="stylesheet" href="/html/nds/css/xmenu.windows.css">
<%}else{%>	
	<link type="text/css" rel="StyleSheet" href="/html/nds/js/menu4/skins/officexp/officexp.css">
	<script language="JavaScript" src="/html/nds/js/menu4/poslib.js"></script>
	<script language="JavaScript" src="/html/nds/js/menu4/scrollbutton.js"></script>
	<script language="JavaScript" src="/html/nds/js/menu4/menu4.js"></script>
	<%if ( ParamUtil.get(request, "enable_context_menu", false)==false){%>
	<script language="JavaScript" src="/html/nds/js/initctxmenu_<%=locale.toString()%>.js"></script>
	<%}else{%>
	<script>
	 //disable context menu control in top_css_ext.js 
	  document.detachEvent( "oncontextmenu",noContextMenu );
	</script>
	<%}
}%>
	<script language="javascript" src="/html/nds/js/prototype.js"></script>
	<script language="javascript" src="/html/nds/js/jquery1.2.3/jquery.js"></script>
	<script language="javascript" src="/html/nds/js/jquery1.2.3/hover_intent.js"></script>
	<script language="javascript" src="/html/nds/js/jquery1.2.3/ui.tabs.js"></script>
<%if("true".equals(request.getParameter("jquery.date"))){
		String jQueryLocale=locale.toString().replaceAll("_","-");
%>
	<script language="javascript" src="/html/nds/js/jquery1.2.3/ui.datepicker.js"></script>
	<script language="javascript" src="/html/nds/js/jquery1.2.3/i18n/ui.datepicker-<%=jQueryLocale%>.js"></script>
	<script>
		jQuery(function($){
			$.datepicker.setDefaults($.extend($.datepicker.regional['<%=jQueryLocale%>'],
				 {dateFormat:'yymmdd',numberOfMonths:2,rangeSeparator:'~',showOn: 'both', buttonImageOnly: true,buttonImage: '/html/nds/images/calendar.gif'}));
		});
		jQuery.noConflict();
	</script>
<%}else{%>
	<script>
		jQuery.noConflict();
	</script>
<%}%>
	<script language="JavaScript" src="/html/nds/js/common.js"></script>
	<script language="JavaScript" src="/html/nds/js/print.js"></script>
	<script language="JavaScript" src="/html/nds/js/prototype.js"></script>
	<script language="JavaScript" src="/html/js/ajax.js"></script>
	<script language="JavaScript" src="/html/js/util.js"></script>
<script type="text/javascript" src="/html/nds/js/selectableelements.js"></script>
<script type="text/javascript" src="/html/nds/js/selectabletablerows.js"></script>
<script language="JavaScript" src="/html/js/dragdrop/coordinates.js"></script>
<script language="JavaScript" src="/html/js/dragdrop/drag.js"></script>
<script language="JavaScript" src="/html/js/dragdrop/dragdrop.js"></script>
<script type="text/javascript" src="/html/nds/js/object_query.js"></script>
<script language="javascript" src="/html/nds/js/calendar.js"></script>
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/portal.css">
<link type="text/css" rel="StyleSheet" href="/html/nds/css/cb2.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/nds_portal.css">
<link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/custom-ext.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/ui.tabs.css">
<link type="text/css" rel="stylesheet" href="<%=userWeb.getThemePath()%>/css/object.css">
<title><%= request.getParameter("html_title")==null?"":request.getParameter("html_title") %></title>

