<%
/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/portlet/translator/init.jsp" %>

<%
Translation translation = (Translation)request.getAttribute(WebKeys.TRANSLATOR_TRANSLATION);

if (translation == null) {
	translation = new Translation(PropsUtil.get(PropsUtil.TRANSLATOR_DEFAULT_LANGUAGES), StringPool.BLANK, StringPool.BLANK);
}
%>

<form accept-charset="UTF-8" action="<portlet:actionURL />" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">

<c:if test="<%= Validator.isNotNull(translation.getToText()) %>">
	<%= translation.getToText() %>

	<br><br>
</c:if>

<textarea class="form-text" name="<portlet:namespace />text" style="height: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_HEIGHT %>px; width: <%= ModelHintsDefaults.TEXTAREA_DISPLAY_WIDTH %>px;" wrap="soft"><%= translation.getFromText() %></textarea>

<br><br>

<select name="<portlet:namespace />id">
	<option <%= (translation.getTranslationId().equals("en_zh")) ? "selected" : "" %> value="en_zh"><%= LanguageUtil.get(pageContext, "en_zh") %></option>
	<option <%= (translation.getTranslationId().equals("en_zt")) ? "selected" : "" %> value="en_zt"><%= LanguageUtil.get(pageContext, "en_zt") %></option>
	<option <%= (translation.getTranslationId().equals("en_nl")) ? "selected" : "" %> value="en_nl"><%= LanguageUtil.get(pageContext, "en_nl") %></option>
	<option <%= (translation.getTranslationId().equals("en_fr")) ? "selected" : "" %> value="en_fr"><%= LanguageUtil.get(pageContext, "en_fr") %></option>
	<option <%= (translation.getTranslationId().equals("en_de")) ? "selected" : "" %> value="en_de"><%= LanguageUtil.get(pageContext, "en_de") %></option>
	<option <%= (translation.getTranslationId().equals("en_it")) ? "selected" : "" %> value="en_it"><%= LanguageUtil.get(pageContext, "en_it") %></option>
	<option <%= (translation.getTranslationId().equals("en_ja")) ? "selected" : "" %> value="en_ja"><%= LanguageUtil.get(pageContext, "en_ja") %></option>
	<option <%= (translation.getTranslationId().equals("en_ko")) ? "selected" : "" %> value="en_ko"><%= LanguageUtil.get(pageContext, "en_ko") %></option>
	<option <%= (translation.getTranslationId().equals("en_pt")) ? "selected" : "" %> value="en_pt"><%= LanguageUtil.get(pageContext, "en_pt") %></option>
	<option <%= (translation.getTranslationId().equals("en_es")) ? "selected" : "" %> value="en_es"><%= LanguageUtil.get(pageContext, "en_es") %></option>
	<option <%= (translation.getTranslationId().equals("zh_en")) ? "selected" : "" %> value="zh_en"><%= LanguageUtil.get(pageContext, "zh_en") %></option>
	<option <%= (translation.getTranslationId().equals("zt_en")) ? "selected" : "" %> value="zt_en"><%= LanguageUtil.get(pageContext, "zt_en") %></option>
	<option <%= (translation.getTranslationId().equals("nl_en")) ? "selected" : "" %> value="nl_en"><%= LanguageUtil.get(pageContext, "nl_en") %></option>
	<option <%= (translation.getTranslationId().equals("fr_en")) ? "selected" : "" %> value="fr_en"><%= LanguageUtil.get(pageContext, "fr_en") %></option>
	<option <%= (translation.getTranslationId().equals("fr_de")) ? "selected" : "" %> value="fr_de"><%= LanguageUtil.get(pageContext, "fr_de") %></option>
	<option <%= (translation.getTranslationId().equals("de_en")) ? "selected" : "" %> value="de_en"><%= LanguageUtil.get(pageContext, "de_en") %></option>
	<option <%= (translation.getTranslationId().equals("de_fr")) ? "selected" : "" %> value="de_fr"><%= LanguageUtil.get(pageContext, "de_fr") %></option>
	<option <%= (translation.getTranslationId().equals("it_en")) ? "selected" : "" %> value="it_en"><%= LanguageUtil.get(pageContext, "it_en") %></option>
	<option <%= (translation.getTranslationId().equals("ja_en")) ? "selected" : "" %> value="ja_en"><%= LanguageUtil.get(pageContext, "ja_en") %></option>
	<option <%= (translation.getTranslationId().equals("ko_en")) ? "selected" : "" %> value="ko_en"><%= LanguageUtil.get(pageContext, "ko_en") %></option>
	<option <%= (translation.getTranslationId().equals("pt_en")) ? "selected" : "" %> value="pt_en"><%= LanguageUtil.get(pageContext, "pt_en") %></option>
	<option <%= (translation.getTranslationId().equals("ru_en")) ? "selected" : "" %> value="ru_en"><%= LanguageUtil.get(pageContext, "ru_en") %></option>
	<option <%= (translation.getTranslationId().equals("es_en")) ? "selected" : "" %> value="es_en"><%= LanguageUtil.get(pageContext, "es_en") %></option>
</select>

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "translate") %>">

</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		document.<portlet:namespace />fm.<portlet:namespace />text.focus();
	</script>
</c:if>
