<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="nds.log.*,
                 nds.query.*,
                 nds.query.web.*,
                 nds.schema.*,
                 nds.excel.*,
                 nds.util.*,
                 java.util.*,
                 java.sql.*,
                 nds.control.web.*"
%>
<%@ taglib uri='/WEB-INF/tld/struts-tiles.tld' prefix='tiles' %>
<%@	page errorPage="../error.jsp" %>
<%
    /**
     * Things needed in this page:
     *  form - form name which contains an param named "preferDesc"
     */
%>
<%
    String form= request.getParameter("form");

	String title="���ù���������";

%>
<% //request.getContextPath()+
    String headerjsp="/header.jsp";
 %>
<tiles:insert page='<%=headerjsp%>'>
  <tiles:put name='title' value='<%=title%>' direct='true'/>
</tiles:insert>


<br>
<script>
    function savePrefer(){
        if (prefer_form.desc.value.length<1) {
            alert("���������������ݣ�");
            return false;
        }
        window.opener.document.<%=form%>.preferDesc.value= prefer_form.desc.value;
        window.opener.document.<%=form%>.preferId.value= "1";
        window.opener.document.<%=form%>.submit();
        window.close();
    }
</script>
<table border="0" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="90%">
  <tr>
    <td rowspan=2>&nbsp;</td>
          <td>
<tiles:insert page='/title.jsp'>
  <tiles:put name='title' value='<%= title %>' direct='true'/>
  </tiles:insert>
          </td>
          <td rowspan=2>&nbsp;</td>
        </tr>
        <tr>
          <td colspan=3>
		<table border="1" cellspacing="0" cellpadding="0" align="center" bordercolordark="#FFFFFF" bordercolorlight="#FFCC00" width="100%">
          <tr bgcolor="#FDFBE3">
            <td> <table border="0" cellspacing="0" cellpadding="0" align="center" width="90%"><tr><td>
              <br>
         <p> �ڴ������Զ���Ĺ�������������Ϣ
         <p> ˵�����ڱ��������ʱ��ϵͳҲͬʱ����ǰ���õ�ÿҳ��ʾ���������档���⣬��������������Ϣ�����й�������ͬһ��ҳ�棩��������ͬ���µĹ��������ý�����ԭ�й��������á�
<form name="prefer_form" method="post" onSubmit="javascript:savePrefer()">
������<input type="text" name="desc" value='' size="25" maxlength="150">
<p>
<input class="command_button" type='button' name='saveDesc' value='����' onclick="javascript:savePrefer();" >
<input class="command_button" type='button' name='Cancle' value='ȡ��' onclick="javascript:window.close();" >

</form></td></tr></table>
 </td></tr></table>
 <br>
 </td></tr></table>
<%
    String footerjsp= "/footer2.jsp";
 %>

  <tiles:insert page='<%=footerjsp %>'>
</tiles:insert>
