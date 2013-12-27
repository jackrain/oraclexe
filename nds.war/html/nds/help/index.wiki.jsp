<%@ include file="/html/nds/common/init.jsp" %>
<%
    /*
    Find page in wiki(create if needed), and redirect to it.
    in properties file, if wiki.checkfile=true, will check wiki page
    if wiki page of table not exist, recreate it then redirect to it
    @param table (int) if not exists go directly to wiki
    @param page (optional) will used as redirect parameter
    */ 
    String wikiPage= request.getParameter("page");
    Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
	String wikiRootPath= conf.getProperty("wiki.help.path","/help");
	

	int tableId= Tools.getInt(request.getParameter("table"),-1);
	Table table=  TableManager.getInstance().getTable(tableId);
	if( table ==null){
		response.sendRedirect(wikiRootPath+"/Wiki.jsp?page="+wikiPage);
    	//request.getRequestDispatcher(wikiRootPath+"/Wiki.jsp").forward(request, response);
    	return;
    }
	if("true".equals(conf.getProperty("wiki.checkfile","false"))){
		// check file existance first
	    String fileName="Help_Table_"+ table.getName()+".txt";
	    String filePath=conf.getProperty("wiki.pages.path","/act/wiki/pages");
	    File file= new File(filePath+File.separator+fileName);
	    
	    if(!file.exists()){
	    	// create file 
	    	File folder= new File(filePath);
	    	folder.mkdirs();
	    	StringBuffer sb=new StringBuffer();
	    	StringBufferWriter wr=new StringBufferWriter(sb);
	    	wr.println("!!![{ActiveDictionary method='tablename' table='"+ table.getName()+"'}]");
	    	wr.println();
	    	wr.println("[{ActiveDictionary method='table' table='"+ table.getName()+"'}]");
	    	wr.println();
	    	wr.println("[{ActiveDictionary method='columns' table='"+ table.getName()+"'}]");
	    	wr.println();
	    	wr.println("[{ActiveDictionary method='category_list' table='"+ table.getName()+"'}]");
	    	wr.println();
	    	wr.println("[{ActiveDictionary method='reftable_list' table='"+ table.getName()+"'}]");
	    	Tools.writeFile(file.getAbsolutePath(), sb.toString(),"ISO-8859-1");
			//System.out.println("write file"+ file.getAbsolutePath());
	    }
	}
	response.sendRedirect(wikiRootPath+"/Wiki.jsp?page=Help_Table_"+ table.getName());
%>

