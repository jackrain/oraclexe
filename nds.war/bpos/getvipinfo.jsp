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
	    String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	    out.print("error");
	    return;
	}
	String vipNo=request.getParameter("vipno");
	if(null!=vipNo&&!vipNo.equals("")){
		List al=QueryEngine.getInstance().doQueryList("select nvl(b.amount,0),nvl(b.integral,0) from c_vip a,fa_vipacc b where a.id=b.c_vip_id and a.isactive='Y' and a.VIPSTATE='Y' and a.cardno='"+vipNo.trim()+"'");
		if(al.size()>0){
				List l=(List)al.get(0);
				out.print("{'amount':'"+l.get(0)+"','intefral':'"+l.get(1)+"'}");
		}else{
			%>
			error
			<%
		}
	}else{
		out.print("error");
	}
%>