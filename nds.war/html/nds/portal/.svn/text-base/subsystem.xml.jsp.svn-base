<?xml version="1.0"?>
<%@page errorPage="/html/nds/error.jsp"%>

<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>

<%    /**
     *
     */
     
int subSystemId=  ParamUtils.getIntAttributeOrParameter(request, "id", -1);

String NDS_PATH=nds.util.WebKeys.NDS_URI;
UserWebImpl userWeb =null;
try{
	userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
}catch(Exception userWebException){
	System.out.println("########## found userWeb=null##########"+userWebException);
}
Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
Locale locale =userWeb.getLocale();
int tablecategoryId,tableId;
Table table;
TableCategory  tablecategory;
SubSystemView subsystemview=new SubSystemView();
List tabcategorylist,categoryChildren,al;
String url,cdesc,tdesc;
/*elements are List, containing 2 elements: 
		nds.schema.TableCategory,
		java.util.List (nds.schema.Table or nds.schema.WebAction) 
*/	 
tabcategorylist=subsystemview.getTableCategories(request,subSystemId);// elements can be TableCategory or WebAction
%>
<tree>
<%
  if(tabcategorylist.size()>1){
for(int i=0;i<tabcategorylist.size();i++){  
	al= (List)tabcategorylist.get(i);
	if(al.get(0) instanceof TableCategory){
	    tablecategory=(TableCategory)al.get(0);
		categoryChildren= (List) al.get(1);
		tablecategoryId =tablecategory.getId();
		url=tablecategory.getPageURL();
		cdesc=tablecategory.getName();
	    if(url!=null){ 
 %>     
    <tree text="<%=cdesc%>" action="javascript:pc.navigate('<%=url%>')">
     	<%     	
     	}else{
     %>		 
    <tree text="<%=cdesc%>">
    <%
		} // end  if(url!=null)
		for(int j=0;j<categoryChildren.size();j++){
			if(categoryChildren.get(j)  instanceof Table){
				table=(Table)categoryChildren.get(j);
				tableId =table.getId(); 
				tdesc=table.getDescription(locale);
%>
	<tree icon="/html/nds/images/table.gif"  text="<%=StringUtils.escapeForXML(tdesc)%>" action="javascript:pc.navigate('<%=tableId%>')"/>       
	<%			
			}else if(categoryChildren.get(j)  instanceof WebAction){
				WebAction action=(WebAction)categoryChildren.get(j) ;
%>
	<%=action.toHTML(locale,null)%>
<%			
			}
		
		}
		// check additional links from configurations
		String linkFile= conf.getProperty("ui.treelink.tablecategory_"+tablecategoryId );
		if(linkFile !=null){
	%>
		<jsp:include page="<%=linkFile%>" flush="true"/>
	<%	} 
	%>
	</tree>
<%
	}//end if TableCategory
	else{
		//web action
		WebAction wac= (WebAction)al.get(0);
%>
		<%=wac.toHTML(locale,null)%>
<%		
	}
 }//  end for
}else if(tabcategorylist.size()==1){
  	al= (List)tabcategorylist.get(0);
  	if(al.get(0) instanceof TableCategory){
	  	tablecategory=(TableCategory)al.get(0);
	  	categoryChildren= (List) al.get(1);
	  	for(int j=0;j<categoryChildren.size();j++){
			if(categoryChildren.get(j)  instanceof Table){
				table=(Table)categoryChildren.get(j);
				tableId =table.getId(); 
				tdesc=table.getDescription(locale);
%>
	<tree icon="/html/nds/images/table.gif"  text="<%=StringUtils.escapeForXML(tdesc)%>" action="javascript:pc.navigate('<%=tableId%>')"/>       
	<%			
		}else if(categoryChildren.get(j)  instanceof WebAction){
			WebAction action=(WebAction)categoryChildren.get(j);
%>
	<%=action.toHTML(locale,null)%>
<%			
		}
	} 
	// check additional links from configurations
	String linkFile= conf.getProperty("ui.treelink.tablecategory_"+tablecategory.getId() );
	if(linkFile !=null){
	%>
		<jsp:include page="<%=linkFile%>" flush="true"/>
	<%}
	}else{
	//web action
		WebAction wac= (WebAction)al.get(0);
%>
		<%=wac.toHTML(locale,null)%>
<%		
	}
}
%>
 
</tree>    
