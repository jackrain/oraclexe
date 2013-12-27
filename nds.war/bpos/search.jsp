<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>


<div id="TMPsearchdoc_content">
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><div id="treatment_td">
      <div id="treatment_text">单据查询：</div>
    </div></td>
  </tr>
  <tr><td height="50">
  <table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="80"><div class="desc-txt">单据号：</div></td>
    <td width="100"><input name="text" id="TMPdocno" type="text" class="q_input_80" /></td>
    <td width="80"><div class="desc-txt">开始时间：</div></td>
    <td width="135"><input name="text2" id="TMPdatebeg" type="text" class="q_input_80" />
      <img src="images/datenum.gif" width="16" height="18" align="absmiddle" /></td>
    <td width="80"><div class="desc-txt">结束时间：</div></td>
    <td width="135"><input name="text3" type="text" id="TMPdateend" class="q_input_80" />
      <img src="images/datenum.gif" width="16" height="18" align="absmiddle" /></td>
    <td width="80"><div class="desc-txt">上传状态：</div></td>
    <td width="100"><select style="display:block" id="TMPupload">
    	<option value="0" selected="selected">上传</option>
    	<option value="1">未上传</option>
      &nbsp;
    </select></td>
    <td width="50"><input name="button" type="button" class="qinput" id="TMPsearchdoc" onclick="bxl.docNO()" value="查询"/></td>
  
  </tr>
</table>
  </td></tr>
  <tr>
    <td>
	<div class="search-table">
      <table border="0" align="center" cellpadding="1" cellspacing="1" style="visibility: visible; opacity: 1; overflow:auto; table-layout: fixed;">
        <tr class="search-table-head">
          <td width="53" class="search-title">序号</td>
          <td width="147" class="search-title">单据号</td>
          <td width="71" class="search-title">日期</td>
          <td width="47" class="search-title">总数量</td>
          <td width="54" class="search-title">总金额</td>
          <td width="43" class="search-title">VIP</td>
          <td width="60" class="search-title">操作员</td>
          <td width="67" class="search-title">上传标记</td>
          <td width="74" class="search-title">备注</td>
          <td width="143" class="search-title">失败原因</td>
        </tr>
        <tr class="search-row">
          <td class="search-text">1</td>
          <td class="search-text">KX1080612SH010000001</td>
          <td class="search-text">2010-6-12</td>
          <td class="search-textR">1000</td>
          <td class="search-textR">3000000</td>
          <td class="search-text">SH001</td>
          <td class="search-text">SH001</td>
          <td class="search-text">SH001</td>
          <td class="search-text">小窗查看新鲜事不留脚印小窗查看新鲜事</td>
          <td class="search-text">小窗查看新鲜事不留脚印小窗查看新鲜事  不留脚印小窗查看新鲜事  不留脚印</td>
        </tr>
        <tr class="search-conduct">
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-textR">1000</td>
          <td class="search-textR">3000000</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
        </tr>
        <tr class="search-row">
          <td class="search-text">1</td>
          <td class="search-text">KX1080612SH010000001</td>
          <td class="search-text">2010-6-12</td>
          <td class="search-textR">1000</td>
          <td class="search-textR">3000000</td>
          <td class="search-text">SH001</td>
          <td class="search-text">SH001</td>
          <td class="search-text">SH001</td>
          <td class="search-text">小窗查看新鲜事不留脚印小窗查看新鲜事</td>
          <td class="search-text">小窗查看新鲜事不留脚印小窗查看新鲜事  不留脚印小窗查看新鲜事  不留脚印</td>
        </tr>
        <tr class="search-conduct">
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-textR">1000</td>
          <td class="search-textR">3000000</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
        </tr>
        <tr class="search-row">
          <td class="search-text">1</td>
          <td class="search-text">KX1080612SH010000001</td>
          <td class="search-text">2010-6-12</td>
          <td class="search-textR">1000</td>
          <td class="search-textR">3000000</td>
          <td class="search-text">SH001</td>
          <td class="search-text">SH001</td>
          <td class="search-text">SH001</td>
          <td class="search-text">小窗查看新鲜事不留脚印小窗查看新鲜事</td>
          <td class="search-text">小窗查看新鲜事不留脚印小窗查看新鲜事  不留脚印小窗查看新鲜事  不留脚印</td>
        </tr>
        <tr class="search-conduct">
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-textR">1000</td>
          <td class="search-textR">3000000</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
          <td class="search-text">&nbsp;</td>
        </tr>
      </table>
    </div></td>
  </tr>	
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td><div id="treatment_td" align="center"><div id="treatment_text">
<input type="button" value="打印" id="TMPprintdoc" onclick="javascript:bxl.print()" class="qinput" id="btn-search"/>
&nbsp;
<input type="button" id="TMPshowdoc" value="查看" onclick="javascript:bxl.showdoc()" class="qinput" id="btn-cancel"/>
&nbsp;
<input id="TMPcloseSearch" type="button" class="qinput" value="取消" onclick="bxl.closeSearch()"/></div>
	</div></td>
</tr>
	
</td></tr></table>	
  </div>

