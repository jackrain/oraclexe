<%@ page language="java" import="org.json.JSONObject,org.json.JSONArray,nds.query.QueryEngine,nds.util.Tools" pageEncoding="utf-8"%>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);	
    int verssion=Tools.getInt(request.getParameter("Verssion"),0);
    int currentVerssion=Tools.getInt(QueryEngine.getInstance().doQueryOne("select max(verssion) from webpos_verssion_info"),0);
    if(verssion==currentVerssion){
    	out.print("-1");
    	return;
    }
    JSONObject jo=new JSONObject();
    jo.put("verssion",currentVerssion);
    JSONArray jaJSP=new JSONArray();
    jaJSP.put("bpos/login.jsp?generateHTML=true");
    jaJSP.put("bpos/index.jsp?generateHTML=true");
    jo.put("generateHTMLJSP",jaJSP);
    JSONArray jaZIP=new JSONArray();
    jaZIP.put("bpos/webpos.css.zip");
    jo.put("downloadFiles",jaZIP);
    JSONObject joa=new JSONObject();
		JSONObject jot=new JSONObject();
		jot.put("Table",jo);
		joa.put("param",jot);
    out.print(joa.toString());
%>