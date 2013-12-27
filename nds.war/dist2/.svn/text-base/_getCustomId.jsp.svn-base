<%--
  User: zhou
  Date: 2009-11-28
  Time: 12:49:48
  AJAX application for get customId
  param orderId
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="nds.query.QueryEngine" %>
<%@ page import="nds.util.Tools" %>
<%
    response.setContentType("text/html;charset=utf-8");
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    response.setCharacterEncoding("utf-8");
    int orderId;
    try{
        orderId=Integer.parseInt(request.getParameter("orderid"));
    }catch (NullPointerException e){
        orderId=-1;
    }
    int customId=-1;
    if(orderId!=-1){
        customId=Tools.getInt(QueryEngine.getInstance().doQueryOne("select c.C_CUSTOMER_ID from C_STORE c,(select c_dest_id as store_id from b_so where id="+orderId+") v where c.id=v.store_id"),-1);
    }
    out.print(customId);
%>