<%@ include file="/html/nds/common/init.jsp" %>
<%
 /*
  Generate next sequence of specified ad_sequence. Will return with a script to write the sequence to both
  "form1.name" and "form1.serno" input, as long they are empty.
  
  This page is requested from hidden_frame.
  
  @param id - ad_sequence.id
 */
 String no="ERROR";
 int id= Tools.getInt(request.getParameter("id"), -1);
 try{
 	if(id!=-1)no=(String)QueryEngine.getInstance().doQueryOne("select Get_SequenceNo_by_id("+id+") from dual");
  }catch(Throwable t){
    t.printStackTrace();
  }
%>
<html><body> <script>
  	try{
  		parent.form1.elements("serno").value="<%=no%>";
  		if(parent.form1.elements("name").value=="")parent.form1.elements("name").value="<%=no%>";
  		parent.hideProgressWnd();
  	}catch(e){}
  </script>
  <%=no%>
</body></html>
