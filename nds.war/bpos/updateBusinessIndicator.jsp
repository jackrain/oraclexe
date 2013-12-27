<%@ page language="java" import="java.util.List,nds.query.QueryEngine,nds.util.Tools" pageEncoding="utf-8"%>
<%
String storeId=(String)request.getParameter("si");
try{																						
	List current=QueryEngine.getInstance().doQueryList("SELECT (SELECT NVL(SUM(T.TOT_AMT_ACTUAL), 0) FROM M_RETAIL T WHERE T.ISACTIVE = 'Y' AND T.STATUS = 2 AND T.BILLDATE = TO_NUMBER(TO_CHAR(SYSDATE, 'yyyymmdd')) AND T.C_STORE_ID = "+storeId+") AS daycurrent,(SELECT NVL(SUM(T.TOT_AMT_ACTUAL), 0)FROM M_RETAIL T WHERE T.ISACTIVE = 'Y' AND T.STATUS = 2  AND T.BILLDATE > ="
							+" TO_NUMBER(TO_CHAR(SYSDATE, 'yyyymm') || '01' ) AND T.BILLDATE < TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'yyyymm') || '01')AND T.C_STORE_ID = "+storeId+") AS monthcurrent,(select count(1)  from m_retail   where isactive = 'Y'   and status = 2   and billdate = to_number(to_char(sysdate, 'yyyymmdd')) and  c_store_id ="+storeId+") as numcurrent FROM dual ");
	out.print("data:"+((List)current.get(0)).get(0)+","+((List)current.get(0)).get(1)+","+((List)current.get(0)).get(2));
}catch(Throwable t){}
%>