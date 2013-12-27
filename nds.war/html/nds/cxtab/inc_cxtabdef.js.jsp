
var NDS_PATH="<%=NDS_PATH%>";
function CxtabDefInitObject(){}
CxtabDefInitObject.prototype={
	getCxtabId:function(){return <%=cxtabId%>; },
	getParentCxtabId:function(){return <%=parentId%>; }
};

var gMessageHolder={
	LOADING: "<%=PortletUtils.getMessage(pageContext, "loading",null)%>",
	SELECT_ONE_COLUMN:"<%=PortletUtils.getMessage(pageContext, "select-one-column",null)%>",
	SELECT_ONE_MEASURE:"<%=PortletUtils.getMessage(pageContext, "select-one-measure",null)%>",
	SELECT_ONE_DIMENSION:"<%=PortletUtils.getMessage(pageContext, "select-one-dimension",null)%>",
	EDIT_DIMENSION:"<%=PortletUtils.getMessage(pageContext, "edit-dimension",null)%>",
	EDIT_MEASURE:"<%=PortletUtils.getMessage(pageContext, "edit-measure",null)%>",
	NEW_MEASURE:"<%=PortletUtils.getMessage(pageContext, "new-measure",null)%>",
	REQUIRE_AT_LEAST_ONE_MEASURE:"<%=PortletUtils.getMessage(pageContext, "require-at-least-one-measure",null)%>",
	COLUMN_AND_USERFACT_CAN_NOT_BE_NULL:"<%=PortletUtils.getMessage(pageContext, "column-and-userfact-can-not-be-null",null)%>",
	COLUMN_MUST_BE_FROM_FACT_TABLE:"<%=PortletUtils.getMessage(pageContext, "column-must-be-from-fact-table",null)%>",
 	OPEN_NEW_WINDOW_TO_SEARCH: "<%=PortletUtils.getMessage(pageContext, "open-new-page-to-search",null)%>",
	CONFIRM_DELETE_CHECKED:"<%= PortletUtils.getMessage(pageContext, "do-you-confirm-delete-checked" ,null)%>",
	NO_DATA_TO_PROCESS:"<%= PortletUtils.getMessage(pageContext, "no-data-to-process" ,null)%>",
	CAN_NOT_BE_NULL: "<%=PortletUtils.getMessage(pageContext, "can-not-be-null",null)%>",
	MUST_BE_DATE_TYPE:"<%=PortletUtils.getMessage(pageContext, "must-be-date-type",null)%>",
	MUST_BE_NUMBER_TYPE: "<%=PortletUtils.getMessage(pageContext, "must-be-number-type",null)%>",
	PLEASE_SELECT: "<%=PortletUtils.getMessage(pageContext, "please-select",null)%>",
	AUTO_UPDATE_SCHEDULE:"<%=LanguageUtil.get(pageContext, "auto-update-schedule")%>",
	FILE_NAME:"<%= LanguageUtil.get(pageContext, "file-name") %>",
	MAINTAIN_BY_SYS: "<%=PortletUtils.getMessage(pageContext, "maintain-by-sys",null)%>",
	NO_PERMISSION: "<%=PortletUtils.getMessage(pageContext, "no-permission",null)%>",
	EXCEPTION: "<%=PortletUtils.getMessage(pageContext, "exception",null)%>",
	TEMPLET_NAME_REPEAT:"<%=PortletUtils.getMessage(pageContext, "templet_name_repeat",null)%>",
	TEMPLET_NAME:"<%=PortletUtils.getMessage(pageContext, "templet_name",null)%>"
};


