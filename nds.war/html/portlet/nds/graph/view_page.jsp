<liferay-ui:box top="/html/nds/common/box_top.jsp" bottom="/html/nds/common/box_bottom.jsp">
	<liferay-ui:param name="box_title_class" value="alpha" />
	<liferay-ui:param name="box_body_class" value="gamma" />
	<liferay-ui:param name="box_title" value="<%= boxTitle %>" />
	<liferay-ui:param name="box_bold_title" value="true" />
	<liferay-ui:param name="box_width" value="<%= portlet.isNarrow() ? Integer.toString(RES_NARROW) : Integer.toString(RES_WIDE) %>" />
	<%@ include file="/html/portlet/nds/graph/view_page_content.jsp" %>
</liferay-ui:box>
	
