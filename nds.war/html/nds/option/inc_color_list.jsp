<%
/**
  主题颜色选择  
*/
	Configurations conf= (Configurations)WebUtils.getServletContextManager().getActor( nds.util.WebKeys.CONFIGURATIONS);
	String defaultThemeId= conf.getProperty("theme.defalut","01");
  
	String selectedThemeId=userWeb.getUserOption("THEMEID", defaultThemeId);
%>
<div align="center"><%=PortletUtils.getMessage(pageContext, "select_color",null)%></div>	
  <table width="643"  border="0" align="center">
  <tr>
    <td width="200" align="center"><label for="01"><%= PortletUtils.getMessage(pageContext, "color_01" ,null)%></label><input id="01" type="radio" name="themeid" value="01" <%="01".equals(selectedThemeId)?"checked":""%>/><br><a href="/html/nds/themes/classic/thumbnail/01_big.jpg" target="_blank"><img vspace="0" hspace="0" border="0" src="/html/nds/themes/classic/thumbnail/01_small.gif"/></a></td>
    <td width="200" align="center"><label for="02"><%= PortletUtils.getMessage(pageContext, "color_02" ,null)%></label><input id="02" type="radio" name="themeid" value="02" <%="02".equals(selectedThemeId)?"checked":""%>/><br><a href="/html/nds/themes/classic/thumbnail/02_big.jpg" target="_blank"><img vspace="0" hspace="0" border="0" src="/html/nds/themes/classic/thumbnail/02_small.gif"/></a></td>
    <td width="200" align="center"><label for="03"><%= PortletUtils.getMessage(pageContext, "color_03" ,null)%></label><input type="radio" id="03" name="themeid" value="03" <%="03".equals(selectedThemeId)?"checked":""%>/><br><a href="/html/nds/themes/classic/thumbnail/03_big.jpg" target="_blank"><img vspace="0" hspace="0" border="0" src="/html/nds/themes/classic/thumbnail/03_small.gif"/></a></td>
  </tr>
  <tr>
    <td align="center"><label for="04"><%= PortletUtils.getMessage(pageContext, "color_04" ,null)%></label><input type="radio" id="04" name="themeid" value="04" <%="04".equals(selectedThemeId)?"checked":""%>/><br><a href="/html/nds/themes/classic/thumbnail/04_big.jpg" target="_blank"><img vspace="0" hspace="0" border="0" src="/html/nds/themes/classic/thumbnail/04_small.gif"/></a></td>
    <td align="center"><label for="05"><%= PortletUtils.getMessage(pageContext, "color_05" ,null)%></label><input type="radio" id="05" name="themeid" value="05" <%="05".equals(selectedThemeId)?"checked":""%>/><br><a href="/html/nds/themes/classic/thumbnail/05_big.jpg" target="_blank"><img vspace="0" hspace="0" border="0" src="/html/nds/themes/classic/thumbnail/05_small.gif"/></a></td>
    <td align="center"><label for="06"><%= PortletUtils.getMessage(pageContext, "color_06" ,null)%></label><input type="radio" id="06" name="themeid" value="06" <%="06".equals(selectedThemeId)?"checked":""%>/><br><a href="/html/nds/themes/classic/thumbnail/06_big.jpg" target="_blank"><img vspace="0" hspace="0" border="0" src="/html/nds/themes/classic/thumbnail/06_small.gif"/></a></td>
  </tr>
  <tr>
    <td align="center"><label for="07"><%= PortletUtils.getMessage(pageContext, "color_07" ,null)%></label><input type="radio" id="04" name="themeid" value="07" <%="07".equals(selectedThemeId)?"checked":""%>/><br><a href="/html/nds/themes/classic/thumbnail/07_big.jpg" target="_blank"><img vspace="0" hspace="0" border="0" src="/html/nds/themes/classic/thumbnail/07_small.gif"/></a></td>
    <td align="center"><label for="07"><%= PortletUtils.getMessage(pageContext, "color_07" ,null)%></label><input type="radio" id="07" name="themeid" value="07" <%="07".equals(selectedThemeId)?"checked":""%>/><br><a href="/html/nds/themes/classic/thumbnail/07_big.jpg" target="_blank"><img vspace="0" hspace="0" border="0" src="/html/nds/themes/classic/thumbnail/07_small.gif"/></a></td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
</table>
