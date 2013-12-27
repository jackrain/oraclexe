<%
/** -- add support for webaction of tab buttons --**/
  Connection actionEnvConnection=null;
  List<WebAction> waTabButtons=new ArrayList<WebAction>();
  HashMap actionEnv=new HashMap();
  try{
  	actionEnvConnection=QueryEngine.getInstance().getConnection();
	actionEnv.put("httpservletrequest", request);
	actionEnv.put("userweb", userWeb);
	actionEnv.put("connection", actionEnvConnection);
	//special env data for TabButton display check
	actionEnv.put("objectid", masterId);
	actionEnv.put("maintable", masterTable.getName());
		
  	List<WebAction> was=table.getWebActions(WebAction.DisplayTypeEnum.TabButton);
  	for(int wasi=0;wasi<was.size();wasi++){
  		WebAction wa=was.get(wasi);
  		if(wa.canDisplay(actionEnv)){
  			waTabButtons.add(wa);
  		}
  	}
  }finally{
  	if(actionEnvConnection!=null)try{actionEnvConnection.close();}catch(Throwable ace){}
  }
for(int wasi=0;wasi<waTabButtons.size();wasi++){
	out.println(waTabButtons.get(wasi).toHTML(locale,actionEnv));
}
%>