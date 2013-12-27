/**
Create onaction fucntion on element, onaction function has one argument
for list object query, it will be an array with length at most 6 (specified in nds.control.web.AjaxController#PARTIAL_DATA_COLUMNS, first one is always id)
for dropdown query, it will be the id for selected element (in string)
see object_query.jsp#ObjectQuery.returnRow and object_query.jsp#DropdownQuery.returnRow for more
*/
function createAction(ele, func){
	$(ele).onaction=new Function("args", func+"(args)");
}
//bai
/**
 Works on l_v_order.s_location_id, when location changed, update address,contactor,phone
*/
function lms_set_s_location(args){
	$("column_24006").value=args[1];//contactorfrom
	$("column_24007").value=args[2];//phonefrom
	$("column_24008").value=args[3];//city__name
	$("column_24010").value=args[4];//locaionfrom
	$("fk_column_24008").value="";
}

function lms_set_r_location(args){
	$("column_24016").value=args[1];//contactorto
	$("column_24017").value=args[2];//phoneto
	$("column_24018").value=args[3];//rcity__name
	$("column_24019").value=args[4];//locaionto
	$("fk_column_24018").value="";
}
function lms_set_s_bpartner(args){
	$("column_25177").value="";
	$("fk_column_25177").value="";
	$("column_24006").value="";
	$("column_24007").value="";
	$("column_24008").value="";
	$("column_24010").value="";
	$("fk_column_24008").value="";
}
function lms_set_r_bpartner(args){
	$("column_25178").value="";
	$("fk_column_25178").value="";
	$("column_24016").value="";
	$("column_24017").value="";
	$("column_24018").value="";
	$("column_24019").value="";
	$("fk_column_24018").value="";
}
function nea_cls_filterobj(args){
	var a=$('objtb').getElementsBySelector('[name="filterobj"]');
	if(a.length>0){
		var b=a[0].id;
		a[0].value="";
		$(b+"_fd").value="";
	}
}