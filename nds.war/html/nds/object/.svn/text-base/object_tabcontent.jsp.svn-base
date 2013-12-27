<%
/*
   此页被object.jsp引用 
   1。 显示单个对象
    根据selectedRefByTable 进行判断，如果.getTableId()==mainTableId, 表示在主表上显示当前对象，
    对象的id=mainTableObjectId    可选命令包括：保存、删除、提交。
    如果.getTableId()!=mainTableId, 表示显示关联表的信息，取得关联表记录为 
    字段selectedRefByTable.getRefByColumnId() 满足 =mainTableObjectId, 如果有多条记录，取第一条
    如果没有找到记录，显示为新增界面。可选命令包括：保存、删除、提交。
    
    对于读、写两种界面，根据权限进行判断，分开实现两个页面，如果具有可写条件，优先显示
    可写界面，否则显示读界面。
    
    寻找相关对象，
    1）存在  -> 
    	权限为只读-> 查看界面single_object_view，判断是否可提交，是则显示按钮（提交，打印）
    	权限为可写-> 修改界面single_object_modify，判断是否可提交，是则显示按钮（提交，保存，打印，删除）
    2）不存在->
    	对应目录只读 -> 对象不存在
    	对应目录可写 -> 新增界面(single_object_modify) 按钮（保存）
    
    2。显示列表对象
    表为：selectedRefByTable.getTableId(), 字段为selectedRefByTable.getRefByColumnId()
    满足  =mainTableObjectId ，以可编辑grid 方式显示。
    
    对于读、写两种界面，根据权限进行判断，分开实现2个页面，如果关联表和主表的安全目录
    相同，则缺省进入写界面，否则进入读列表界面（类似于list）界面上包括按钮：
    编辑（读界面），这时将进入写界面（批量），如果点击其中的某行，则弹出新的界面。
    
    1)关联表和主表的安全目录相同 ->
    	权限为可写-> 批量修改界面(multiple_object_modify)，按钮：保存行，删除行，提交行，列表查看界面
    	权限为只读-> 列表界面(multiple_object_view)，按钮：
    2)	关联表和主表的安全目录不同 ->
    	列表界面(multiple_object_view)，如果权限可写，按钮增加“批量编辑界面”，提交选中，删除选中
    	
    	
    
    统一起来，设置为两部分：命令按钮的设置，和对象的显示设置，
    操作的表对象为tableId=selectedRefByTable.getTableId(), 字段为filterColumnId=selectedRefByTable.getRefByColumnId()
    构造基本过滤条件为 select * from <tableId> where filterColumnId=mainTableObjectId
    命令按钮根据 tableId  进行判断，对象显示设置根据过滤条件来。
    */
 //variables set in object.jsp: mainTableObjectId,selectedRefByTable,mainTable,mainTableId
 
 int tableId=selectedRefByTable.getTableId();
 request.setAttribute("table",""+tableId );
 request.setAttribute("refbytable",selectedRefByTable);
 
 Table table=manager.getTable(tableId);
 int filterColumnId=selectedRefByTable.getRefByColumnId();
 
 
 //if( filterColumnId != mainTable.getPrimaryKey().getId()){
 if( selectedRefByTable.getId()!=-1){
 	//only when not modifing on main table, will the fixedColumns be set
 	fixedColumns.put(new Integer(manager.getColumn(filterColumnId).getId()), ""+mainTableObjectId);
 	//System.out.println("fix column is :"+ manager.getColumn(filterColumnId));
 }
 request.setAttribute("fixedcolumns",fixedColumns );
 
 int assocType= selectedRefByTable.getAssociationType();
 int directoryPerm;

 isInput=isInput && (mainTable.isActionEnabled(Table.ADD) ||  mainTable.isActionEnabled(Table.MODIFY) );
 if(assocType==RefByTable.ONE_TO_ONE){
	 int objectId=getObjectId(selectedRefByTable, mainTableObjectId);
	 
	 request.setAttribute("inline_id",""+objectId );
	 
	 if(objectId !=-1){
	 	if(isInput==true && userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.WRITE)){
	 		// write form
	 		request.setAttribute("ismodify", "true");	
	 		%><jsp:include page="<%=NDS_PATH+ \"/object/inlineobj.jsp\"  %>" flush="true" /><%
	 	}else if(userWeb.hasObjectPermission(table.getName(),objectId,nds.security.Directory.READ)){
	 		// view form
	 		request.setAttribute("ismodify", "false");
	 		%><jsp:include page="<%=NDS_PATH+ \"/object/inlineobj.jsp\"  %>" flush="true" /><%
	 	}else{
	 		// no permission to read
	 		%>
	 		<font color='red'><%=PortletUtils.getMessage(pageContext, "no-permission-or-not-exists",null)%></font>
	 		<%
	 	}
	 }else{
	  	// object id==-1
	  	directoryPerm=userWeb.getPermission(table.getSecurityDirectory());
	  	if( (directoryPerm&nds.security.Directory.WRITE)==0){
	  		// can not write, and the object not exists
	  		%>
	 		<font color='red'><%=PortletUtils.getMessage(pageContext, "object-not-exists",null)%></font>
	 		<%
	  	}else{
	  		// can write,and the object not exists, so create form
	  		//write form
	  		request.setAttribute("ismodify", "true");
	  		%><jsp:include page="<%=NDS_PATH+ \"/object/inlineobj.jsp\"  %>" flush="true" /><%
	  	}
	 }
 
 }else{ // ONE_TO_MANY
     /* 
     Things needed in this page (attributes) :
     1.  itemtable     String|id of table that queried on, 
     2.  mastertable   String|id of master table, 
     3.  masterid	  id of master table record
 	 */
	request.setAttribute("itemtable", String.valueOf(tableId));
	request.setAttribute("mastertable", String.valueOf(mainTableId));
	request.setAttribute("masterid", String.valueOf(mainTableObjectId));
	
 	//check directory permission
 	directoryPerm=userWeb.getPermission(table.getSecurityDirectory());
 	System.out.println("directoryPerm="+ directoryPerm+", isInput="+ isInput+","+(table.getSecurityDirectory().equals(mainTable.getSecurityDirectory())));
 	if(table.getSecurityDirectory().equals(mainTable.getSecurityDirectory())){
 		if( (directoryPerm&nds.security.Directory.READ)==0){
	  		// can not read
	  		%>
	 		<font color='red'><%=PortletUtils.getMessage(pageContext, "no-permission",null)%></font>
	 		<%
	  	}else{
	  		if((directoryPerm&nds.security.Directory.WRITE)==0 || isInput==false||
	  			"2".equals(request.getAttribute("nds.request.object.mainobject.status"))||
	  				!(table.isActionEnabled(Table.ADD)||table.isActionEnabled(Table.MODIFY)||table.isActionEnabled(Table.DELETE))
	  			){
	  				request.setAttribute("ismodify", "false");	
	  		}else{
	  				request.setAttribute("ismodify", "true");	
	  		}
	  		
	  		%>
	  		<jsp:include page="<%=NDS_PATH+ \"/object/multiple_object.jsp\"  %>" flush="true" />
	 <%
	  	}
 	}else{
 		//defautl to view page, if "input is not set to ture"
 		if(isInput==true && (table.isActionEnabled(Table.ADD)
 			||table.isActionEnabled(Table.MODIFY)
 			||table.isActionEnabled(Table.DELETE) 
 			||table.isActionEnabled(Table.SUBMIT))){
 			if((directoryPerm&nds.security.Directory.WRITE)!=0 ){
 				request.setAttribute("ismodify", "true");	
 				%>
 				<jsp:include page="<%=NDS_PATH+ \"/object/multiple_object.jsp\"  %>" flush="true" />
 		<%
 			}
 		}else if( (directoryPerm&nds.security.Directory.READ)!=0 ){
 			request.setAttribute("ismodify", "false");	
 			%>
 			<jsp:include page="<%=NDS_PATH+ \"/object/multiple_object.jsp\"  %>" flush="true" />
 		<%
 		}else{
 			// can not read
 			%>
	 		<font color='red'><%=PortletUtils.getMessage(pageContext, "no-permission",null)%></font>
	 		<%
 		}
 	}
 	
 } 
%>
