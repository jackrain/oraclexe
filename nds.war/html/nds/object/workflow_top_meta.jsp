<%@ include file="/html/common/init.jsp" %>
<%/**
 ���ļ�����ʹ��ant task ����javascript, css �ļ��ĺϲ���ѹ���������Ա��ļ����е��޸���Ҫ���¶�Ӧ��ant build �ļ�
*/
%>
<%@ include file="/html/common/themes/top_meta.jsp" %>
<%@ include file="/html/common/themes/top_meta-ext.jsp" %>
<link rel="Shortcut Icon" href="/html/nds/images/portal.ico" />
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-1.7.2.js"></script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/hover_intent.min.js"></script>
<script>
	jQuery.noConflict();
</script>
<script language="javascript" src="/html/nds/js/jquery1.3.2/jquery-ui-1.8.21.custom.min.js"></script>
<script language="javascript" src="/html/nds/js/artDialog4/jquery.artDialog.js?skin=chrome"></script>
<script language="javascript" src="/html/nds/js/artDialog4/plugins/iframeTools.js"></script>

<link type="text/css" rel="stylesheet" href="/html/nds/css/nds_header.css">
<link type="text/css" rel="StyleSheet" href="/html/nds/css/cb2.css">
<link type="text/css" rel="StyleSheet" href="<%=userWeb.getThemePath()%>/css/custom-ext.css" />
<link type="text/css" rel="stylesheet" href="/html/nds/css/obj_workflow.css">
<title><%=table.getDescription(locale)%> - Workflow - NEWBOS</title>
