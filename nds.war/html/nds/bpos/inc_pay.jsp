<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script language="javascript" src="/html/nds/bpos/jsm.js"></script>
<script>
/*
document.onkeydown = function(){
	//f12
	if(window.event && window.event.keyCode == 123) { 
		event.stopPropagation();
		return false;
	}
}
*/
</script>
<div id="TMPpayment_content"> 
	<table width="605" border="0" cellspacing="0" cellpadding="0">
		<tr>
            <td width="21"></td>
            <td width="556" height="20"></td>
            <td width="18"></td>
        </tr>
		<tr>
            <td width="21"></td>
            <td width="566" valign="top">
				<table width="566" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="291" rowspan="2" valign="top">
							<div id="TMPquery-search-tab">
								<ul class="ui-tabs-nav">
									<li class="ui-tabs-selected"><a href="#qtab1"><span style="color: white;">付&nbsp;&nbsp;&nbsp;款</span></a></li>
								</ul>
								<div id="TMPqtab1" class="ui-tabs-panel" style="display: block;">
									<div id="TMPq_search_condition" class="left">
										<table id="pay" cellspacing="1" cellpadding="1" border="0" width="290">
											<tbody>
												<tr>
													<td nowrap="" height="18" width="10%" align="right">
														<div class="desc-txt">应付金额：</div>
													</td>
													<td nowrap="" height="18" width="21%" align="left">
														<input id="TMPpaynum" name="TMPpaynum" type="text" class="q_input"  align="right" style=" width: 182px; "/>
													</td>
												</tr>
												<tr>
													<td nowrap="" height="18" width="10%" align="right">
														<div class="desc-txt">付款方式：</div>
													</td>
													<td nowrap="" height="18" width="21%" align="left">
														<select name="TMPpayselect" id="TMPpayselect" class="q_input" style=" width: 182px; ">
														</select>
													</td>
												</tr>
												<tr>
													<td nowrap="" height="18" align="right"><div class="desc-txt">付款金额：</div></td>
													<td nowrap="" height="18" align="left"><input id="TMPcurrpay" name="TMPcurrpay" type="text" class="q_input" onKeyPress="onReturnpay(event);" style=" width: 182px; " /></td>
												</tr>
												<tr>
												  <td nowrap="" height="18" align="right"><div class="desc-txt">已付金额：</div></td>
												  <td nowrap="" height="18" align="left"><input id="TMPpaidnum"  name="TMPpaidnum" type="text" class="q_input" style=" width: 182px; " /></td>
												  </tr>
												<tr>
												  <td nowrap="" height="18" align="right"><div class="desc-txt">未付总额：</div></td>
												  <td nowrap="" height="18" align="left"><input id="TMPunpaidnum" name="TMPunpaidnum" type="text" class="q_input" style=" width: 182px; " /></td>
												  </tr>
												<tr>
												  <td nowrap="" height="18" align="right"><div class="desc-txt">找&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;零：</div></td>
												  <td nowrap="" height="18" align="left"><input id="TMPchange" name="TMPchange" type="text" class="q_input" style=" width: 182px; " /></td>
												</tr>
												<tr style="display:none;">
												  <td nowrap="" height="18" align="right"><div class="desc-txt">收银员：</div></td>
												  <td nowrap="" height="18" align="left"><input id="TMPempname" name="TMPempname" type="text" class="q_input" style=" width: 182px; " /></td>
												</tr>
											</tbody>
										</table>
										<textarea id="TMPdiscription"  name="TMPdiscription" cols="40" rows="3" readonly disabled></textarea>
									</div>
								</div>      
							</div>
						</td>
						<td width="275" valign="top">
							<div id="TMPquery-search">
								<div id="TMPq_border">
								  <table width="265" border="1" align="center" cellpadding="0" cellspacing="0" id="modify_table"> 	
								   <thead>
									<tr id="TMPmodify_table_tr">
									  <td width="50" align='center'>付款方式</td>
									  <td width="66" align='center'>金额</td>
									</tr>
								   </thead>
									<tbody id="TMPpaymentcontent">
									<tr id="TMPr_payment" class="emtbts" style="display:none;">
									  <td width="50" nowrap align='center' id="TMPpayway"></td>
									  <td width="66" nowrap align='right' id="TMPpaycount"></td>
									</tr>
									</tbody>
								  </table>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="bottom"><div id="TMPqbtns">
						<input type="button" id="submitandprint" value="提交并打印" onclick="javascript:bpos.doSubmitPrint()" class="qinput" style="padding: 2px 4px;" />
						&nbsp;
						<input type="button" id="submit" value="提交" onclick="javascript:bpos.save()" class="qinput" style="padding: 2px 4px;" />
						&nbsp;
						<input type="button" id="repay" value="重付" onclick="javascript:bpos.repay()" class="qinput" style="padding: 2px 4px;" />
						&nbsp;
						<input  type="button" id="cancle" class="qinput" value="取消"  onclick="javascript:bpos.payclose()" style="padding: 2px 4px;"/>
						&nbsp;</div>
						</td>
					</tr>
				</table>
			</td>
            <td width="18"></td>
		</tr>
		<tr>
            <td></td>
            <td>&nbsp;</td>
            <td></td>
		</tr>
	</table>	
</div>

