
var NDS_PATH="<%=NDS_PATH%>";
function CxtabInitObject(){}
CxtabInitObject.prototype={
};
var gMessageHolder={
	LOADING: "<%=PortletUtils.getMessage(pageContext, "loading",null)%>",
	SELECT_ONE_COLUMN:"<%=PortletUtils.getMessage(pageContext, "select-one-column",null)%>",
	SELECT_ONE_MEASURE:"<%=PortletUtils.getMessage(pageContext, "select-one-measure",null)%>",
	SELECT_ONE_DIMENSTION:"<%=PortletUtils.getMessage(pageContext, "select-one-dimension",null)%>",
	EDIT_DIMENSION:"<%=PortletUtils.getMessage(pageContext, "edit-dimesion",null)%>",
	EDIT_MEASURE:"<%=PortletUtils.getMessage(pageContext, "edit-measure",null)%>",
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
	EXCEPTION: "<%=PortletUtils.getMessage(pageContext, "exception",null)%>"
};


