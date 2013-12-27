<%
/*
   ��ҳ��object.jsp���� 
   1�� ��ʾ��������
    ����selectedRefByTable �����жϣ����.getTableId()==mainTableId, ��ʾ����������ʾ��ǰ����
    �����id=mainTableObjectId    ��ѡ������������桢ɾ�����ύ��
    ���.getTableId()!=mainTableId, ��ʾ��ʾ���������Ϣ��ȡ�ù������¼Ϊ 
    �ֶ�selectedRefByTable.getRefByColumnId() ���� =mainTableObjectId, ����ж�����¼��ȡ��һ��
    ���û���ҵ���¼����ʾΪ�������档��ѡ������������桢ɾ�����ύ��
    
    ���ڶ���д���ֽ��棬����Ȩ�޽����жϣ��ֿ�ʵ������ҳ�棬������п�д������������ʾ
    ��д���棬������ʾ�����档
    
    Ѱ����ض���
    1������  -> 
    	Ȩ��Ϊֻ��-> �鿴����single_object_view���ж��Ƿ���ύ��������ʾ��ť���ύ����ӡ��
    	Ȩ��Ϊ��д-> �޸Ľ���single_object_modify���ж��Ƿ���ύ��������ʾ��ť���ύ�����棬��ӡ��ɾ����
    2��������->
    	��ӦĿ¼ֻ�� -> ���󲻴���
    	��ӦĿ¼��д -> ��������(single_object_modify) ��ť�����棩
    
    2����ʾ�б����
    ��Ϊ��selectedRefByTable.getTableId(), �ֶ�ΪselectedRefByTable.getRefByColumnId()
    ����  =mainTableObjectId ���Կɱ༭grid ��ʽ��ʾ��
    
    ���ڶ���д���ֽ��棬����Ȩ�޽����жϣ��ֿ�ʵ��2��ҳ�棬��������������İ�ȫĿ¼
    ��ͬ����ȱʡ����д���棬���������б���棨������list�������ϰ�����ť��
    �༭�������棩����ʱ������д���棨�����������������е�ĳ�У��򵯳��µĽ��档
    
    1)�����������İ�ȫĿ¼��ͬ ->
    	Ȩ��Ϊ��д-> �����޸Ľ���(multiple_object_modify)����ť�������У�ɾ���У��ύ�У��б�鿴����
    	Ȩ��Ϊֻ��-> �б����(multiple_object_view)����ť��
    2)	�����������İ�ȫĿ¼��ͬ ->
    	�б����(multiple_object_view)�����Ȩ�޿�д����ť���ӡ������༭���桱���ύѡ�У�ɾ��ѡ��
    	
    	
    
    ͳһ����������Ϊ�����֣����ť�����ã��Ͷ������ʾ���ã�
    �����ı����ΪtableId=selectedRefByTable.getTableId(), �ֶ�ΪfilterColumnId=selectedRefByTable.getRefByColumnId()
    ���������������Ϊ select * from <tableId> where filterColumnId=mainTableObjectId
    ���ť���� tableId  �����жϣ�������ʾ���ø��ݹ�����������
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
