var listControl;
var ListControl = Class.create();
// define constructor
ListControl.prototype = {
	initialize: function() {
		// init dwr
		this._gridQuery={};
	},
	/***
	* Invoke by buttons, include btn_begin,btn_next,btn_prev,btn_end
	@param t id of the button
	*/
	scrollPage: function (t) {
		//var t=event.target.id;
		var s;
		var qs=$("list_form_start").value;
		var qrange=parseInt( $("range_select").value,10);
		var qtot=$("list_form_totalrowcount").value;
		if(t=="begin_btn")s=0;
		else if(t=="prev_btn") s= qs-qrange;
		else if(t=="next_btn") s= qs+qrange;
		else if(t=="end_btn") s= qtot-qrange;
		else s= qs;
		
		$("list_form_start").value=s;
		$("list_form_range").value=qrange;
		this._executeQuery(qr);
	},
	_syncGridControl:function(qr){
		var totalRowCount=$("list_form_totalrowcount").value;
		var start=$("list_form_start").value;

		$("txtRange").innerHTML=((qr.start+1)+"-"+ (qr.start+qr.rowCount)+"/"+ qr.totalRowCount);
		//debug("_syncGridControl: qr:start="+ qr.start+",qr.rowCount:"+ qr.rowCount+",qr.totalRowCount"+qr.totalRowCount);
		if(qr.start>0){
			 $("begin_btn").setEnabled(true);
			 $("prev_btn").setEnabled(true);
		}else{
			 $("begin_btn").setEnabled(false);
			 $("prev_btn").setEnabled(false);
		}
		if((qr.start+qr.rowCount)< qr.totalRowCount){
			 $("next_btn").setEnabled(true);
			 $("end_btn").setEnabled(true);
		}else{
			 $("next_btn").setEnabled(false);
			 $("end_btn").setEnabled(false);
		}
	},
	/**
	 * mark all check box checked
	 */
	selectAll:function(){
		var i;
		var b= dwr.util.getValue($("chk_select_all"));
        var itemIdObjs=$("list_form").getElementsBySelector("input[name='itemid']");
        for(i=0;i< itemIdObjs.length;i++){
           dwr.util.setValue(itemIdObjs[i], b);
		}
	},
};
// define static main method
ListControl.main = function () {
	listControl=new ListControl();
};
