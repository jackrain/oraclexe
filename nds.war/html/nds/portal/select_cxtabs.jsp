<%
// Load default report template
Table cxtabTable=TableManager.getInstance().getTable("ad_cxtab");
ArrayList akSelection=new ArrayList();
akSelection.add(cxtabTable.getAlternateKey());
// first column is id, second is ak
String defaultCxtabName=null;
ArrayList defaultCxtab=userWeb.loadFirstRow(cxtabTable,akSelection,cxtabTable.getColumn("modifieddate"), false, 1, "AD_CXTAB.AD_TABLE_ID="+ tableId);
if(defaultCxtab!=null)defaultCxtabName= (String)defaultCxtab.get(1);

if(!nds.util.Validator.isNull(defaultCxtabName)){
	// create an input to accept ad_cxtab.name, which will be used as template of the report
	FKObjectQueryModel fkQueryModel;
	Column ad_cxtab_id_column=TableManager.getInstance().getColumn("ad_cxtab_fact","ad_cxtab_id");
	String cxtab_column_Id= "cxtab"+System.currentTimeMillis();
	//fix ad_table_id to current fact table
	PairTable cxtabpt=new PairTable();
	cxtabpt.put("ad_cxtab.ad_table_id", String.valueOf(tableId));
	fkQueryModel=new FKObjectQueryModel(ad_cxtab_id_column.getReferenceTable(), cxtab_column_Id,ad_cxtab_id_column,cxtabpt);
	fkQueryModel.setQueryindex(-1);	
	// onchange="cxtabControl.loadCxtabProcessParam()" 
%>	
<%=PortletUtils.getMessage(pageContext, "cxtab-template",null)%>:&nbsp;<br>
<input id="<%=cxtab_column_Id%>" name="<%=cxtab_column_Id%>" readonly="on" type="text" value="<%=defaultCxtabName%>" onkeydown="<%=fkQueryModel.getKeyEventScript()%>" size="25" maxlength="180">
<span id="cbt_<%=System.currentTimeMillis()%>"  onaction="<%=fkQueryModel.getButtonClickEventScript()%>"><img border=0 width=16 height=16 align=absmiddle src='<%=fkQueryModel.getImageURL()%>' alt='<%= PortletUtils.getMessage(pageContext, "open-new-page-to-search" ,null)%>'></span>
<script>createButton(document.getElementById("cbt_<%=System.currentTimeMillis()%>"));
pc.setCxtabInput("<%=cxtab_column_Id%>");
</script>
<%
}//end !nds.util.Validator.isNull(defaultCxtabName)
%>
