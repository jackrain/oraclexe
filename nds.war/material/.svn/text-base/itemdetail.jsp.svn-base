<%@ page language="java" import="java.util.regex.Matcher,java.util.regex.Pattern,java.util.*,nds.schema.*,nds.util.Tools,nds.query.QueryEngine,nds.control.web.UserWebImpl,nds.control.web.WebUtils" pageEncoding="utf-8"%>
<%!
public void distinct(ArrayList<String> args,int index){
	for(int i=index+1;i<args.size();i++){
		if(args.get(i).equals(args.get(index)))args.set(i,"null");
	}
	ArrayList<String> al=new ArrayList<String>(1);
	al.add(0,"null");
	args.removeAll(al);
}
public String[] distinctAndSort(ArrayList<String> args){
	int index=0;
	while(index<args.size()){
		distinct(args,index);
		index++;
	}
	String[] ss=args.toArray(new String[args.size()]);
	Arrays.sort(ss);
	return ss;
}
public double parseDouble (Object obj){
	if(null==obj)return 0;
	double r;
	try{
		r=Double.parseDouble(obj.toString());
	}catch(NumberFormatException e){
		r=0;
	}
	return r;
}

public double[] checkExists(List ls,String color,String spec){
	for(int j=0;j<ls.size();j++){
		if(color.equals(String.valueOf(((List)ls.get(j)).get(3))+"("+String.valueOf(((List)ls.get(j)).get(4))+")")&&spec.equals(String.valueOf(((List)ls.get(j)).get(1))+"("+String.valueOf(((List)ls.get(j)).get(2))+")"))return new double[]{(double)Tools.getInt(((List)ls.get(j)).get(0),0),parseDouble(((List)ls.get(j)).get(5)),parseDouble(((List)ls.get(j)).get(6))};
	}
	return new double[]{0,0,0};
}
%>
<%
UserWebImpl userWeb =null;
try{
    userWeb= ((UserWebImpl)WebUtils.getSessionContextManager(session).getActor(nds.util.WebKeys.USER));
}catch(Throwable userWebException){
    System.out.println("########## found userWeb=null##########"+userWebException);
}
if(userWeb==null || userWeb.isGuest()){
	String redirect=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString() ,"UTF-8");
	response.sendRedirect("/login.jsp?redirect="+redirect);
	return;
}
int tableId=Tools.getInt(request.getParameter("table"),-1);
int ymtid=Tools.getInt(request.getParameter("ymtid"),-1);
String ymtname=request.getParameter("ymtname");
int objId=Tools.getInt(request.getParameter("objId"),-1);
int mstTableId=Tools.getInt(request.getParameter("mstTable"),-1);
String aliasQtyColumn=request.getParameter("aliasQtyColumn");
String storedata=request.getParameter("storedata");
int store_colId=Tools.getInt(request.getParameter("store_colId"),-1);
if(-1==ymtid){
out.print("<span color='red'>该物料无可用颜色规格</span>");

return;
}
/*
select b.id,c.name,c.code,d.name,d.code,t.qty,t.qtycan 
      from Y_MATERIAL_ALIAS B,Y_SPEC c,Y_COLOR d,V_Y_FA_STORAGE t
      where b.y_material_id=133
      and  b.y_color_id=d.id
      and b.y_spec_id=c.id
      and t.y_warehouse_id=
      and t.y_materialalias_id=b.id
 */
 String sql="select b.id,c.name,c.code,d.name,d.code,0,0 "+
      " from Y_MATERIAL_ALIAS B,Y_SPEC c,Y_COLOR d"+
      " where b.y_material_id="+ymtid+
      " and  b.y_color_id=d.id"+
      " and b.y_spec_id=c.id";
 
 if(null!=storedata&&!"".equals(storedata)){
	sql="select b.id,c.name,c.code,d.name,d.code,t.qty,t.qtycan "+
	      " from Y_MATERIAL_ALIAS B,Y_SPEC c,Y_COLOR d,(select * from V_Y_FA_STORAGE where y_warehouse_id=(select id from Y_WAREHOUSE where name='"+storedata.trim()+"')) t"+
	      " where b.y_material_id="+ymtid+
	      " and  b.y_color_id=d.id"+
	      " and b.y_spec_id=c.id"+
	      " and t.y_materialalias_id(+)=b.id";
 }
List ls=QueryEngine.getInstance().doQueryList(sql);
if(0==ls.size()){
out.print("<span color='red'>该物料无可用颜色规格</span>");
return;
}

String tName=TableManager.getInstance().getTable(tableId).getName();
String sqlType=String.valueOf(QueryEngine.getInstance().doQueryOne("select coltype from ad_column where name='"+(tName+"."+aliasQtyColumn).toUpperCase()+"'"));

Pattern p=Pattern.compile("NUMBER\\(\\d+\\,(\\d+)\\)");
Matcher m=p.matcher(sqlType);
String numType="0";
if(m.find()){
   numType=m.group(1);
}
String [] colors,speces;
ArrayList<String> colorList=new ArrayList<String>();
ArrayList<String> specList=new ArrayList<String>();
for(int j=0;j<ls.size();j++){
	colorList.add(String.valueOf(((List)ls.get(j)).get(3))+"("+String.valueOf(((List)ls.get(j)).get(4))+")");
	specList.add(String.valueOf(((List)ls.get(j)).get(1))+"("+String.valueOf(((List)ls.get(j)).get(2))+")");
}
colors=distinctAndSort(colorList);
speces=distinctAndSort(specList);

%>
<style>
.modify_table, #modify_table {
    background-color: #FFFFFF;
    border: 1px solid #77A3E0;
    border-collapse: collapse;
		font-size:12px;
}

.td-hd {
    background-color: #E1EBFD;
    border: 1px solid #77A3E0;
    cursor: pointer;
	line-height:18px;
	height:18px;
}

.td-green {
    background-color: #deffdd;
    border: 1px solid #77A3E0;
    cursor: pointer;
	line-height:18px;
	height:18px;
}

.td-red {
    background-color: #ffecec;
    border: 1px solid #77A3E0;
    cursor: pointer;
	line-height:18px;
	height:18px;
}
.hd-select{
padding:0px 0px 3px 0px ;
font-size:12px;
width:790px;}

.inputline {
    background-color: transparent;
    border-color: #CCCCCC #333 #333;
    border-style: solid;
    border-width: 0 0 1px;
    color: #333333;
    font: 9pt "Verdana","Arial","Helvetica","sans-serif";
    vertical-align: middle;
}
</style>
<div id="ratiodist_body">
  <div class="hd-select">物料：<%=ymtname%></div>
  彩色字是发货店仓库存情况   <%if(null!=storedata&&!"".equals(storedata)){%>店仓：<%=storedata%> <%}%>   <span class="store1_desc_s"><input type="checkbox"  checked="true" value="sqty" id="sqty">库存量</span><span class="store1_desc_v"><input type="checkbox"  checked="true" value="vqty" id="vqty">可用量</span>
 <div id="ratiodist_table" style="width: 790px; height: 360px; overflow: auto; border: thin groove rgb(204, 204, 204); padding: 0px;" id="itemdetail_div"> 
<table  border="1" align="left" cellpadding="0"  cellspacing="0" bordercolor="#77A3E0" bordercolorlight="#77A3E0" bordercolordark="#77A3E0" bgcolor="#FFFFFF" class="modify_table">
  <tr>
    <td >&nbsp;</td>
    <% 
    for(int g=0;g<speces.length;g++){
    %>
    <td class="td-hd"><%=speces[g]%></td>
    <%}%>
    <td class="td-hd">行合计</td>
  </tr>
  <% 
  for(int a=0;a<colors.length;a++){
  %>
  <tr row="<%=a%>" copyindex='0'>
    <td class="td-hd"><%=colors[a]%></td>
    <%
    for(int s=0;s<speces.length;s++){
    double [] arrAis=checkExists(ls,colors[a],speces[s]);
    %>
    <td>
    	<input type="text" <%if(0==arrAis[0]){%>readonly="true" disabled="true" <%}%> value="" cl="<%=colors[a]%>" sz="<%=speces[s]%>" x="<%=s%>" y="<%=a%>" size="4" class="inputline">
    	<br>
    	<div class="product-storage">
    			<div class="psl">
    				<div class="s"><%=arrAis[1]==0?"&nbsp;":arrAis[1]%></div>
    				<div class="v"><%=arrAis[2]==0?"&nbsp;":arrAis[2]%></div>
    			</div>
    	</div>
    </td>
    <%}%>
    <td class="td-green"><input id="rowtot<%=a%>" type="text" readonly="true"  value=""   size="4"  class="inputline"></td>
  </tr>
	<%}%>
  <tr>
    <td class="td-hd">列合计</td>
		<%
		for(int d=0;d<speces.length;d++){
		%>
		<td><input type="text" id="coltot<%=d%>"  col="<%=d%>" readonly="true"  value=""   size="4"  class="inputline"></td>
		<%}%>
    <td><input type="text" id="totrow" readonly="true" value=""   size="4"  class="inputline"></td>
  </tr>
</table>
</div>
<input class="command2_button" type="button" name="createinstances" value="保存(J)" id="ratiodist_save" accessKey="J" >
<input class="command2_button" type="button" name="cancel" value="取消(Q)" onclick="closeAlert()" accessKey="Q" >
</div>
<script>
	<%
	StringBuffer sb=new StringBuffer("[");
	for(int k=0;k<colors.length;k++){
		for(int l=0;l<speces.length;l++){
			if(0!=checkExists(ls,colors[k],speces[l])[0]){
				sb.append("{'x':"+l+",'y':"+k+",'color':'"+colors[k]+"','size':'"+speces[l]+"','ais':"+checkExists(ls,colors[k],speces[l])[0]+",'num':0,'copyindex':0}");
				if((k+1)*(l+1)!=(colors.length)*(speces.length))sb.append(",");
			}
		}
	}
	sb.append("]");
	%>
	var cell_datas="<%=sb%>";
	cell_datas=cell_datas.evalJSON();
	var singleBoxesCount=new Array();
	var lenSize=<%=speces.length%>;
	var lenColor=<%=colors.length%>;
	var decimalPlace=<%=numType%>;
	function accAdd(arg1,arg2){
    var r1,r2,m;
   	r1=arg1.toString().split(".");
    if(r1[1]){
    	r1=r1[1].length;
    }else{
    	r1=0;
    }
    r2=arg2.toString().split(".")
    if(r2[1]){
    	r2=r2[1].length;
    }else{
    	r2=0;
    }
    m=Math.pow(10,Math.max(r1,r2));
    return (arg1*m+arg2*m)/m
	}

//给Number类型增加一个add方法，调用起来更加方便。
	Number.prototype.add = function (arg){
    return accAdd(arg,this);
	}
	
	function showQty(sign){
		if( $(sign+"qty").checked){
			$$('#ratiodist_table .'+sign).each(Element.show);
		}else{
			$$('#ratiodist_table .'+sign).each(Element.hide);
		}

	}
	jQuery("#sqty").bind("click",function(){showQty("s")});
	jQuery("#vqty").bind("click",function(){showQty("v")});
	function updatetot(x,y){
		var coltot=0;
		var rowtot=0;
		var tot=0;
		for(var i=0;i<cell_datas.length;i++){
			if(cell_datas[i].x==x)coltot=coltot.add(parseFloat(cell_datas[i].num));
			if(cell_datas[i].y==y)rowtot=rowtot.add(parseFloat(cell_datas[i].num));
			tot=tot.add(parseFloat(cell_datas[i].num));
		}
		jQuery("#coltot"+x).val(coltot);
		jQuery("#rowtot"+y).val(rowtot);
		jQuery("#totrow").val(tot);
	}
	function numFormat(num){
		if(isNaN(num))return 0;
		if(decimalPlace<=0)return parseInt(num,10);
		var p=".";
		for(var i=0;i<decimalPlace;i++){
			p+="#";
		}
		return formatNumber(num,{pattern:p});
	}
	function updateItem(cell){
		if(cell){
			var x=parseInt(jQuery(cell).attr("x"),10);
			var y=parseInt(jQuery(cell).attr("y"),10);
			var count=numFormat(parseFloat(jQuery(cell).val()));
			for(var i=0;i<cell_datas.length;i++){
				if(cell_datas[i].x==x&&cell_datas[i].y==y){
					cell_datas[i].num=count;
					break;
				}
			}
			updatetot(x,y);
		}
	}
	
	  function _format(pattern,num,z){  
        var j = pattern.length >= num.length ? pattern.length : num.length ;  
        var p = pattern.split("");  
        var n = num.split("");  
        var bool = true,nn = "";  
        for(var i=0;i<j;i++){  
            var x = n[n.length-j+i];  
            var y = p[p.length-j+i];  
            if( z == 0){  
                if(bool){  
                    if( ( x && y && (x != "0" || y == "0")) || ( x && x != "0" && !y ) || ( y && y == "0" && !x )  ){  
                        nn += x ? x : "0";  
                        bool = false;  
                    }     
                } else {  
                    nn +=  x ? x : "0" ;  
                }  
            } else {  
                if( y && ( y == "0" || ( y == "#" && x ) ))  
                    nn += x ? x : "0" ;                               
            }  
        }  
        return nn;  
    }  
    function _formatNumber(numChar,pattern){  
        var patterns = pattern.split(".");  
        var numChars = numChar.split(".");  
        var z = patterns[0].indexOf(",") == -1 ? -1 : patterns[0].length - patterns[0].indexOf(",") ;  
        var num1 = _format(patterns[0].replace(","),numChars[0],0);  
        var num2 = _format( patterns[1]?patterns[1].split('').reverse().join(''):"", numChars[1]?numChars[1].split('').reverse().join(''):"",1);  
        num1 =  num1.split("").reverse().join('');  
        var reCat = eval("/[0-9]{" + (z-1) + "," + (z-1) + "}/gi");  
        var arrdata = z > -1 ? num1.match(reCat) : undefined ;  
        if( arrdata && arrdata.length > 0 ){  
            var w = num1.replace(arrdata.join(''),'');  
            num1 = arrdata.join(',') + ( w == "" ? "" : "," ) + w ;  
        }  
        num1 = num1.split("").reverse().join("");  
        return (num1 == "" ? "0" : num1) + (num2 != "" ? "." + num2.split("").reverse().join('') : "" );                      
    }   
    function formatNumber(num,opt){  
        var reCat = /[0#,.]{1,}/gi;  
        var zeroExc = opt.zeroExc == undefined ? true : opt.zeroExc ;  
        var pattern = opt.pattern.match(reCat)[0];  
        var numChar = num.toString();  
        return !(zeroExc && numChar == 0) ? opt.pattern.replace(pattern,_formatNumber(numChar,pattern)) : opt.pattern.replace(pattern,"0");  
    }  
	
	
	function x_next(x,y){
		var xx=x+1;
		if(xx>lenSize)xx=0;
		var cell=jQuery("#ratiodist_body table tr td input[x='"+xx+"'][y='"+y+"']");
		if(cell.is("input[readonly]")){
			x_next(xx,y);
		}else{
			dwr.util.selectRange(cell[0],0,15);
		}
	}
	function x_pre(x,y){
		var xx=x-1;
		if(xx<0)xx=lenSize;
		var cell=jQuery("#ratiodist_body table tr td input[x='"+xx+"'][y='"+y+"']");
		if(cell.is("input[readonly]")){
			x_pre(xx,y);
		}else{
			dwr.util.selectRange(cell[0],0,15);
		}
	}
	
	function y_next(x,y){
		var yy=y+1;
		if(yy>=lenColor)yy=0;
		var cell=jQuery("#ratiodist_body table tr td input[x='"+x+"'][y='"+yy+"']");
		if(cell.is("input[readonly]")){
			y_next(x,yy);
		}else{
			dwr.util.selectRange(cell[0],0,15);
		}
	}
	function y_pre(x,y){
		var yy=y-1;
		if(yy<0)yy=lenColor-1;
		var cell=jQuery("#ratiodist_body table tr td input[x='"+x+"'][y='"+yy+"']");
		if(cell.is("input[readonly]")){
			y_pre(x,yy);
		}else{
			dwr.util.selectRange(cell[0],0,15);
		}
	}

	var lastInput=jQuery("#ratiodist_body table tr td input:not([readonly]):last")[0];
	jQuery("#ratiodist_body table tr td input:not([readonly])").bind("keydown",function(event){
		if(event.which==13&&event.shiftKey==true){
			updateItem(this);
			save();
			return;
		}
		if(event.which==13){
			if(this.value&&isNaN(parseFloat(this.value))){
				dwr.util.selectRange(this,0,20);
				return;
			}
			if(this==lastInput){
				updateItem(this);
				save();
				return;
			}
			var index=jQuery("#ratiodist_body table tr td input:not([readonly])").index(this);
			index++;
			var nextCell=jQuery("#ratiodist_body table tr td input:not([readonly])")[index];
			if(nextCell){
				dwr.util.selectRange(nextCell,0,20);
			}else{
				dwr.util.selectRange(jQuery("#ratiodist_body table tr td input:not([readonly])")[0],0,15);
			}
		}
	});
	jQuery("#ratiodist_body table tr td input:not([readonly])").bind("keyup",function(event){
		var x=parseInt(jQuery(this).attr("x"),10);
		var y=parseInt(jQuery(this).attr("y"),10);
		if(event.which==37){
			if(this.value&&isNaN(parseFloat(this.value))){
				dwr.util.selectRange(this,0,20);
			}else{
				x_pre(x,y);
			}
		}else if(event.which==39){
			if(this.value&&isNaN(parseFloat(this.value))){
				dwr.util.selectRange(this,0,20);
			}else{
				x_next(x,y);
			}
		}else if(event.which==38){
			if(this.value&&isNaN(parseFloat(this.value))){
				dwr.util.selectRange(this,0,20);
			}else{
				y_pre(x,y);
			}
		}else if(event.which==40){
			if(this.value&&isNaN(parseFloat(this.value))){
				dwr.util.selectRange(this,0,20);
			}else{
				y_next(x,y);
			}
		}
	});
	jQuery("#ratiodist_body table tr td input:not([readonly]):first").focus();
	jQuery("#ratiodist_body table tr td input:not([readonly])").bind("change",function(){
			if(this.value&&isNaN(parseFloat(this.value))){
				alert("请输入正确的数字！");
				this.value="";
			}else{
				updateItem(this);
			}
	});

	function closeAlert(){
		art.dialog.get("art_itemdetail_div").close();
	}
	function checkCanSave(){
		if(jQuery("#ratiodist_save").attr("disabled")=="true"){
			return false;
		}
		return true;
	}
	function freshRatioDist(){
		gc.refreshGrid();
	}
	function save(){
		art.dialog.get("art_itemdetail_div").close();
		oc._toggleButtons(true);		
		if(oc._checkObjectInputs()==false){
			oc._toggleButtons(false);
	       	return;
    	}
		if(!checkCanSave()){
			alert("不能重复保存！");
			return;
		}
		jQuery("#ratiodist_save").attr("disabled","true");
		var colDate=new Array();
		var cols=gc._gridMetadata.columns,v,inx=0;
	  for(i=5;i<cols.length;i++){
			 col=cols[i];
			 if(col.isUploadWhenCreate){
			 	v= gc._getValue("eo_"+ col.name);
				if(jQuery.trim(v)){
				 	colDate[inx]={};
				 	colDate[inx].clink=col.clink;
				 	colDate[inx].columnId=col.columnId;
				 	colDate[inx].name=col.name;
				 	colDate[inx].value=v;
				 	colDate[inx].type=col.type;
				 	inx++;
				}
			 }
		}
		jQuery.post("/material/ratiodistitem.jsp",{aliasQtyColumn:"<%=aliasQtyColumn%>",colDate:Object.toJSON(colDate),itemdatas:Object.toJSON(cell_datas),ymtid:<%=ymtid%>,objId:<%=objId%>,tableId:<%=tableId%>,mstTableId:<%=mstTableId%>},function(data){
			jQuery("#ratiodist_save").removeAttr("disabled");
			if(jQuery.trim(data)=="success"){
				freshRatioDist();
				//Alerts.killAlert($("ratiodist_body"));
				var focusInput=$("eo_"+$("check_material_attribute").value);
				dwr.util.selectRange(focusInput,0,this.MAX_INPUT_LENGTH);
				gc._lastFocusElement=focusInput;
				if( dwr.util.getValue("clear_after_insert")==true) gc.newLine(false);
			}else{
				alert(data);
			}
		});
	}
	jQuery("#ratiodist_save").bind("click",save);
</script>