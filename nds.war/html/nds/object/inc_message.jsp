<%
//load au_pi_id info
String aupiinfo=null;
if(objectId!=-1 && table.getColumn("au_pi_id")!=null){
	List pilist=QueryEngine.getInstance().doQueryList("select p.LAST_COMMENTS,p.state from au_phaseinstance p, "+table.getRealTableName()+" a where a.id="+ objectId+" and p.id=a.au_pi_id");
	if(pilist!=null && pilist.size()>0){
		String pilists=(String) ((List)pilist.get(0)).get(0);
		String pilistsd=manager.getColumnValueDescription(
			 manager.getColumn("au_phaseinstance","state").getId(),
			 ((List)pilist.get(0)).get(1), locale);
		aupiinfo=LanguageUtil.get(pageContext, "worflow-audit-status")+":"+pilistsd+","+
			manager.getColumn("au_phaseinstance","LAST_COMMENTS").getDescription(locale)+":"+
			(Validator.isNull(pilists)?LanguageUtil.get(pageContext, "comments-empty"):
				pilists);
		aupiinfo="<div class='info-msg'>"+aupiinfo+"</div>";
	}
}
%>
<div id="message_txt"><%=(aupiinfo==null?"":aupiinfo)%></div>
