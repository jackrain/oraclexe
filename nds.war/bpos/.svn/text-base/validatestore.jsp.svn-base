<%@ page language="java" import="java.util.*,nds.query.*,org.json.JSONObject" pageEncoding="utf-8"%>
<%
String login=request.getParameter("u");
String storeid=request.getParameter("storeid");
String passwd=  request.getParameter("p");
	if(null!=login&&!login.equals("")&&null!=passwd&&!passwd.equals("")){
		String userName=login.trim();
		passwd=passwd.trim();
		List al=QueryEngine.getInstance().doQueryList("select a.id,a.code,a.name,a.address,a.phone from c_store a,TSYSTRANS b where a.CODE ="+QueryUtils.TO_STRING(userName)+" and nvl(a.POSPW,'') ='"+passwd+"' and a.id=b.c_store_id and b.issetup=0");
		//out.print("select a.id,a.code,a.name from c_store a,TSYSTRANS b where a.CODE ="+QueryUtils.TO_STRING(userName)+" and nvl(a.POSPW,'') ='"+passwd+"' and a.id=b.c_store_id and b.issetup=0");
		if(al.size()>0){
				List l=(List)al.get(0);
				JSONObject jo=new JSONObject();
				jo.put("id",l.get(0));
				jo.put("code",l.get(1));
				jo.put("name",l.get(2));
				jo.put("phone",l.get(4));
				jo.put("addr",l.get(3));
				out.print(jo.toString());
		}else{
			%>
			error
			<%
		}
	}else if(null!=storeid&&!storeid.equals("")){
		int id=Integer.parseInt(storeid);
		String randompw=id+new Double(Math.random()*10).intValue()+"pw";
		List<String> vec=new ArrayList<String>();
		vec.add("update c_store set POSPW='"+randompw+"' where id="+id);
		vec.add("update TSYSTRANS set issetup=1 where c_store_id="+id);
		try{
			QueryEngine.getInstance().doUpdate(vec);
		}catch(Exception e){
			out.print("更新服务器数据出错："+e.getMessage());
		}
	}
%>