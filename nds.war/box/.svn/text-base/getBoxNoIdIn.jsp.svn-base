<%--
  User: zhou
  Date: 2009-10-29
  Time: 17:02:53
  for get boxno id
  param:boxno,boxId
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="nds.query.QueryEngine" %>
<%@ page import="nds.util.Tools" %>
      <%
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        int boxno,boxid;
        try{
            boxno=Integer.parseInt(request.getParameter("boxno"));
            boxid=Integer.parseInt(request.getParameter("boxid"));
        }catch (NullPointerException e){
            boxno=-1;
            boxid=-1;
        }
        int boxNoId=-1;
        if(boxno!=-1&&boxid!=-1){
             boxNoId=Tools.getInt(QueryEngine.getInstance().doQueryOne("select g.id from m_v_box t,m_v_boxitem g where g.m_v_box_id="+boxid+" and g.boxno="+boxno+" and rownum=1"),-1);
        }
         out.print(boxNoId);
        %>
