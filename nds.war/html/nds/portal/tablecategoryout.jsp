<?xml version="1.0"?>
<%@page errorPage="/html/nds/error.jsp"%>

<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ page import="java.sql.ResultSet,java.sql.Connection,java.sql.PreparedStatement,nds.query.web.*,nds.control.web.*,nds.util.*,nds.schema.*,nds.query.*, java.io.*,java.util.*,nds.control.util.*,nds.portlet.util.*,nds.report.*,nds.web.bean.*,nds.model.*, nds.model.dao.*"%>

<%    /**
     * @param 
      		id - tablecategory.id	
     */
     
int tablecategoryId=  ParamUtils.getIntAttributeOrParameter(request, "id", -1);
String onlyfa=  ParamUtils.getAttributeOrParameter(request, "onlyfa");
String NDS_PATH=nds.util.WebKeys.NDS_URI;
UserWebImpl userWeb =null;
try{
	userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));	
}catch(Exception userWebException){
	//System.out.println("########## found userWeb=null##########"+userWebException);
}
Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
nds.query.web.SubSystemView ssv=new nds.query.web.SubSystemView();
//get WEBaction 传入参数环境
HashMap actionEnv = new HashMap();
actionEnv.put("httpservletrequest", request);
actionEnv.put("userweb", userWeb);

List categoryChildren=ssv.getChildrenOfTableCategorybymenu(request,tablecategoryId,true/*include webaction*/ );
Locale locale =userWeb.getLocale();
int tableId,fa_tableId;
Table table;
List mu_favorites=ssv.getSubSystemsOfmufavorite(request);
String url,cdesc,tdesc,tabout,fa_tdesc;
String famus = new String();

if(mu_favorites.size()>0){
//System.out.println("mu_favorites     "+mu_favorites.size());
for(int j=0;j<mu_favorites.size();j++){
List favs=(List)mu_favorites.get(j);
String	fa_menu=(String)favs.get(0);
String	fa_muac=(String)favs.get(1);
String	fa_rpt=(String)favs.get(2);
Object	fa_tab=favs.get(3);
String fa_tabimg = new String();
if(fa_rpt.equals("Y"))fa_tabimg="<img src='/html/nds/images/cxtab.gif' style='height:16px;width:20px;'/>";

if(fa_tab instanceof Table){
		fa_tableId =((Table)fa_tab).getId(); 
		fa_tdesc=((Table)fa_tab).getDescription(locale);
		famus=famus+"<div class=\"accordion_headings\" onclick=\""+fa_muac+"\">"+fa_tabimg+"<a class=\"fa_mu\" href=\"javascript:mu.del_mufavorite('"+fa_tableId+"');\">"+fa_tableId+"</a><a>"+StringUtils.escapeForXML(fa_tdesc)+"</a></div>";
	  			}	
			}	
}
//System.out.println(famus);
//String tabout = new String();
TableManager manager=TableManager.getInstance();
TableCategory tc= manager.getTableCategory(tablecategoryId);
//System.out.println(tc.getName());
//String tabout1 = new String();
String tabout1 ="<div><h3 class=\"ui-accordion-first\"><a style=\"color:white;\">我的收藏夹</a></h3><div id=\"mu_favorite\">"+famus+"</div></div>";
for(int j=0;j<categoryChildren.size();j++){
List als=(List)categoryChildren.get(j);
String	ACCORDION_name=(String)als.get(0);
//System.out.println(ACCORDION_name);
List tab=(List)als.get(1);
//System.out.println(tab.size());
//String higthp=String.valueOf((tab.size()+1)*23);
String Inable = new String();
String Inaction = new String();
WebAction action=null;

for(int e=0;e<tab.size();e++){
	String tabimg = new String();
	if(tab.get(e)  instanceof Table){
		table=(Table)tab.get(e);
		tableId =table.getId(); 
		tdesc=table.getDescription(locale);
		if(table.getAccordico()!=null){
			//tabimg="<img src=\""+table.getAccordico()+"\" style=\"height:16px;width:20px;\">";
			tabimg="<img src=\""+StringUtils.escapeForXML(table.getAccordico())+"\" style=\"height:16px;width:20px;\"></img>";
			}
		Inable=Inable+"<div class=\"accordion_headings\" onclick=\"javascript:pc.navigate('"+tableId+"')\">"+tabimg+"<a>"+StringUtils.escapeForXML(tdesc)+"</a></div>";
		//System.out.println(Inable);
  }else if(tab.get(e)  instanceof WebAction){
  	  
			action=(WebAction)tab.get(e);
			//System.out.println(action.getName());
			WebAction.ActionTypeEnum ate= action.getActionType();
			WebAction.DisplayTypeEnum dst=action.getDisplayType();
			if(ate.equals(WebAction.ActionTypeEnum.JavaScript)&&dst.equals(WebAction.DisplayTypeEnum.Accord)){
			Inable=Inable+"<div class=\"accordion_headings\" onclick=\""+action.getScript()+"\"><a>"+StringUtils.escapeForXML(action.getDescription())+"</a></div>";
		}else{
		//扩展webaction treenode 支持 outlook 方式
		  action=(WebAction)tab.get(e);
		//System.out.println(action.getName());
		//System.out.println(action.getActionType());
			Inaction=Inaction+action.toHTML(locale,actionEnv);
		}
	}
}
//自适应调整OUTLOOK 菜单高度

//System.out.println(Inable);
//height:300px;
if(tab.size()>=12&&Inable!=null){
	tabout="<div><h3><a>"+ACCORDION_name+"</a></h3><div style=\"max-height:566px\">"+Inable+"</div></div>";
	}else if(Inable != null && Inable.length() != 0){
  tabout="<div><h3><a>"+ACCORDION_name+"</a></h3><div>"+Inable+"</div></div>";
	}else{
	tabout=" ";
	}
//System.out.println(tabout);
 /*
tabout="<div><h3><a>"+ACCORDION_name+"</a></h3><div>"+Inable+"</div></div>";
*/
if(onlyfa==null){
tabout1=tabout1+tabout+Inaction;
}
}
String main="<h3 class='ui-accordion-header ui-helper-reset ui-state-default ui-corner-all' role='tab' aria-expanded='false' aria-selected='false' tabindex='-1'>";
		main+="<span class='ui-icon ui-icon-triangle-1-e'></span><a>天气指南</a></h3>";
		main+="<div id='wth'>";
			//main+="<iframe src='/html/nds/sinawa/index.html' frameborder='0' scrolling='no' width='210' height='230' allowTransparency='true'></iframe>";
		main+="</div>";
//System.out.println(tabout1);
out.print("<div id=\"tab_accordion\">"+tabout1+"</div>");
%>
