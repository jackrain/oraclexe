<%@ page language="java" import=" cn.com.burgeon.tasks.webpos.*,nds.query.QueryEngine,nds.util.Tools,java.util.ArrayList,java.util.Collection,java.util.List,java.security.MessageDigest" pageEncoding="utf-8"%>
<%!
public String MD5(String s){
	String r="";
	try{
		MessageDigest md = MessageDigest.getInstance("MD5"); 
		md.update(s.getBytes());
		byte b[]=md.digest();	
		int i;
		StringBuffer buf = new StringBuffer("");
		for (int offset = 0; offset < b.length; offset++) { 
			i = b[offset]; 
			if(i<0) i+= 256; 
			if(i<16) 
			buf.append("0"); 
			buf.append(Integer.toHexString(i)); 
		}
		r=buf.toString();
	}catch(Exception e){	
	}
	return r;
}
%>
<%

/**
 *vf MD5加密，验证用户
 *uid 用户ID
 *datetype 类型 ：all、disadj...
 *scope 范围 ：pricearea、store、...
 */
String verify=request.getParameter("vf");
String uid=request.getParameter("uid");
String pw=String.valueOf(QueryEngine.getInstance().doQueryOne("select passwordhash from users where id="+uid));
String pwh=MD5(pw+uid);
if(!pwh.equals(verify)){
	out.print("无权限！");
	return;
}
String dateType=request.getParameter("datetype");
String scope=request.getParameter("scope");
String objid=request.getParameter("objid");
if(null==dateType||null==scope||"".equals(dateType)||"".equals(scope)){
	out.print("动作定义定义错误，请联系管理员！");
}else{
	if("disadj".equals(dateType)&&null!=objid&&!"".equals(objid)){
		int a= Tools.getInt(QueryEngine.getInstance().doQueryOne("select pricearea from TDEFDATA_PRICE where id="+objid), -1);
		String sql="merge into TDEFDATA_LOG a using(select get_sequences('TDEFDATA_LOG') AS ID,37 AS AD_CLIENT_ID,27 AS AD_ORG_ID,"+a+" AS C_PRICEAREA_ID,";
		String sql2=" AS DATATYPE,1 AS GENEORGIN,SYSDATE AS DENEDATE,(SELECT ID FROM users WHERE NAME='root') AS OWNERID ,"+uid+" AS MODIFIERID,SYSDATE AS CREATIONDATE,SYSDATE AS MODIFIEDDATE,'Y' AS ISACTIVE FROM DUAL) T\n" +
                "ON ((t.C_PRICEAREA_ID=a.C_PRICEAREA_ID or (t.C_PRICEAREA_ID is null and a.C_PRICEAREA_ID is null))  AND t.GENEORGIN=a.GENEORGIN AND t.DATATYPE=a.DATATYPE)\n" +
                "WHEN MATCHED THEN\n" +
                "UPDATE SET a.DENEDATE=t.DENEDATE , a.MODIFIEDDATE=t.MODIFIEDDATE\n" +
                "WHEN NOT MATCHED THEN\n" +
                " INSERT(a.id,a.AD_CLIENT_ID,a.AD_ORG_ID,a.C_PRICEAREA_ID,a.DATATYPE,a.GENEORGIN,a.DENEDATE,a.OWNERID,a.MODIFIERID,a.CREATIONDATE,a.MODIFIEDDATE,a.ISACTIVE)\n" +
                " VALUES(t.id,t.AD_CLIENT_ID,t.AD_ORG_ID,t.C_PRICEAREA_ID,t.DATATYPE,t.GENEORGIN,t.DENEDATE,t.OWNERID,t.MODIFIERID,t.CREATIONDATE,t.MODIFIEDDATE,t.ISACTIVE)";
   DateGeneration2.getInstance().generationForADJUSTMENTs(new int[]{a});    
   QueryEngine.getInstance().executeUpdate(sql+3+sql2);
   List l= QueryEngine.getInstance().doQueryList("SELECT c.id FROM c_store c WHERE c.TDEFDOWNTYPE_ID is not null  and c.ISRETAIL='Y' and STORESIGN=1 and  c.isactive='Y' AND c.c_pricearea_id="+a);
   int[] li=new int[l.size()];
   for(int j=0;j<l.size();j++){
      int le= Tools.getInt(l.get(j), -1);
      li[j]=le;
   }
   DateGeneration2.getInstance().generationForDISes(li);
   QueryEngine.getInstance().executeUpdate(sql+4+sql2);
   Collection params=new ArrayList();
   params.add(objid);
   QueryEngine.getInstance().executeStoredProcedure("TDEFDATA_PRICE_SUBMIT",params,true);  
   out.print("完成");          
	}else if("all".equals(dateType)){
		out.print(DateGeneration2Run.dealGenerateDate());
	}
}

%>