<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="nds.control.web.WebUtils" %>
<%@ page import="nds.control.web.UserWebImpl,nds.query.QueryEngine" %>
<%
  UserWebImpl userWeb =null;
  try{
      userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
  }catch(Throwable userWebException){
      out.println("error");
  } 
	if(userWeb==null || userWeb.isGuest()){
	    out.print("error");
	    return;
	}
	String barcode=request.getParameter("Barcode");
	//out.print("SELECT a.no,b.value1_code ,b.value2_code,c.name,c.value FROM m_product_alias a,m_attributesetinstance b,m_product c WHERE NO ='"+barcode+"' AND a.m_attributesetinstance_id=b.id AND a.m_product_id=c.id ");
	if(null!=barcode&&!barcode.equals("")){
		List al=QueryEngine.getInstance().doQueryList("SELECT a.no,b.value1_code ,b.value2_code,c.name,c.value,c.addsdesc FROM m_product_alias a,m_attributesetinstance b,m_product c WHERE NO ='"+barcode+"' AND a.m_attributesetinstance_id=b.id AND a.m_product_id=c.id ");
		if(al.size()>0){
				List l=(List)al.get(0);
				out.print("{'no':'"+l.get(0)+"','value1_code':'"+l.get(1)+"','value2_code':'"+l.get(2)+"','name':'"+l.get(3)+"','value':'"+l.get(4)+"','addsdesc':'"+l.get(5)+"'}");
		}else{
			%>
			error
			<%
		}
	}else{
		out.print("error");
	}
%>