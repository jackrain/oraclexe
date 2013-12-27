<%
for(int i=0;i< validCommands.size();i++){
	btn=null;
	Object cmd= validCommands.get(i);
	if(cmd instanceof String){
		btn=commandFactory.getButton((String)cmd);
	}else if(cmd instanceof Button){
		btn=(Button)cmd;
	}
	if(btn==null) throw new Error("Internal error: command not found:"+ cmd);
%>
	<%=btn.toHREFbyimg("table-buttons2")%>
<%	
}
%>

