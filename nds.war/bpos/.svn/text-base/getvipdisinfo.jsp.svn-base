<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="nds.control.web.WebUtils,java.util.regex.Pattern,java.util.regex.Matcher" %>
<%@ page import="nds.control.web.UserWebImpl,nds.query.QueryEngine" %>
<%!
public boolean checkVipType(String vipTypeSql,String vipTypeId){
	 Pattern p= Pattern.compile("IN\\s*\\((.+)\\)");
   Matcher m=p.matcher(vipTypeSql);
	 String vipstr=null;
   if(m.find()){
      vipstr=m.group(1);
   }
   try{
	   if(vipstr.contains("SELECT")){
	   		String o=QueryEngine.getInstance().doQueryOne(vipstr+" and C_VIPTYPE.ID="+vipTypeId).toString();
	   		if(o.trim().equals(vipTypeId)){
	   			return true;
	   		}
	   }else{
	   		String[] vipTypeIds=vipstr.split(",");
	   		for(int i=0;i<vipTypeIds.length;i++){
	   			if(vipTypeIds[i].trim().equals(vipTypeId)){
	   				return true;
	   			}
	   		}
	   }
   }catch(Exception e){
   	return false;
   }
   return false;
}
%>
<%
  UserWebImpl userWeb =null;
  try{
      userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
  }catch(Throwable userWebException){
      out.println("error");
  } 
	if(userWeb==null || userWeb.isGuest()){
	   // String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	    out.print("error");
	    return;
	}
	String storeid=request.getParameter("storeid");
	String vipTypeId=request.getParameter("viptypeid");
	String integrals=request.getParameter("integral");
	String qty=request.getParameter("qty");
	if(null==qty||"".equals(qty)){
		qty="0";
	}
	int integral=0;
	if(null!=integrals&&!integrals.trim().equals("")){
		integral=Integer.parseInt(integrals);
	}
	if((null!=storeid&&!storeid.trim().equals(""))&&(null!=vipTypeId&&!vipTypeId.trim().equals(""))){
		List al=QueryEngine.getInstance().doQueryList("SELECT t.id,t.name,t.distype,t.content,t.integral,t.isclear,t.ismused,t.viptypefilter,t.discountlimit FROM C_V_INTEGRALMIN  t WHERE nvl(t.LIMITQTY,"+qty+")="+qty+" and (t.c_store_id="+storeid+" and t.integral<="+integral+" or t.allstore='Y' and t.integral<="+integral+")  and nvl(t.INTEGRAL_LIMIT,0)<="+integral);
		String str="[";
		if(al.size()>0){
				for(int i=0;i<al.size();i++){
					List l=(List)al.get(i);
					String vipTypeSql;
					if(l.get(7) instanceof java.sql.Clob){
							vipTypeSql=((java.sql.Clob)l.get(7)).getSubString(1, (int) ((java.sql.Clob)l.get(7)).length());
					}else{
							vipTypeSql=(String)l.get(7);
					}
					if(checkVipType(vipTypeSql,vipTypeId)){
						str+="{id:"+l.get(0)+",name:\""+l.get(1)+"\",distype:\""+l.get(2)+"\",content:"+l.get(3)+",integral:"+l.get(4)+",isclear:\""+l.get(5)+"\",ismused:\""+l.get(6)+"\",viptypefilter:\""+vipTypeSql+"\",discountlimit:"+l.get(8)+"},";
					}
				}
				str+="{}]";
		}else{
			str="none";
		}
		out.print(str);
	}else{
		out.print("error2");
	}
%>