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

<%@ include file="/html/common/init.jsp" %>

<%
String referer = null;
referer = "/";
/**
yfzhu marked following so direct to guest home only 20080325

String refererParam = request.getParameter(WebKeys.REFERER);
String refererRequest = (String)request.getAttribute(WebKeys.REFERER);
String refererSession = (String)session.getAttribute(WebKeys.REFERER);

if ((refererParam != null) && (!refererParam.equals(StringPool.NULL)) && (!refererParam.equals(StringPool.BLANK))) {
	referer = refererParam;
}
else if ((refererRequest != null) && (!refererRequest.equals(StringPool.NULL)) && (!refererRequest.equals(StringPool.BLANK))) {
	referer = refererRequest;
}
else if ((refererSession != null) && (!refererSession.equals(StringPool.NULL)) && (!refererSession.equals(StringPool.BLANK))) {
	referer = refererSession;
}
else {
	if (referer == null) {
		referer = themeDisplay.getPathMain();
	}
}*/
%>
