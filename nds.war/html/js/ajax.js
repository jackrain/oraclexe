function AjaxRequest(url, options) {
	
	var xmlHttpReq;
	var opts = options;
	var returnArgs = opts.returnArgs;
	var method = opts.method;
	var ajaxId = opts.ajaxId;

	if (window.XMLHttpRequest) {
		xmlHttpReq = new XMLHttpRequest();

		if (xmlHttpReq.overrideMimeType) {
			xmlHttpReq.overrideMimeType("text/html");
		}
	}
	else if (window.ActiveXObject) {
		try {
			xmlHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e) {
			try {
				xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e) {
				try {
					xmlHttpReq = new XMLHttpRequest();
				}
				catch (e) {
				}
			}
		}
	}
	
	var onComplete = opts.onComplete;
	var returnFunction = function() {
			if (xmlHttpReq.readyState == 4) {
				try {
					if (xmlHttpReq.status == 200) {
						var ajaxId;
						try {
							ajaxId = xmlHttpReq.getResponseHeader("Ajax-ID");
						}
						catch (e) {
							ajaxId = "";
						}

						if (onComplete) {
							onComplete(xmlHttpReq, returnArgs);
						}
		
						if (ajaxId && ajaxId != "") {
							AjaxUtil.remove(parseInt(ajaxId));
						}
					}
				}
				catch(e) {
				}
			}
		}

	var send = function(url) {
		var urlArray = url.split("?");
		var path = urlArray[0];
		var query = urlArray[1];
		
		try {
			if (method == "get") {
				xmlHttpReq.open("GET", url, true);
				xmlHttpReq.onreadystatechange = returnFunction;
				xmlHttpReq.send("");
			}
			else {
				xmlHttpReq.open("POST", path, true);
				xmlHttpReq.setRequestHeader("Method", "POST " + path + " HTTP/1.1");
				xmlHttpReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				xmlHttpReq.setRequestHeader("Ajax-ID", ajaxId);
				xmlHttpReq.onreadystatechange = returnFunction;
				xmlHttpReq.send(query);
			}
		}
		catch (e) {
		}
	}
	
	send(url);

	this.resend = function(url, options) {
		opts = options;
		onComplete = opts.onComplete;
		
		send(url);
	};
	
	this.getId = function() {
		return ajaxId;
	};
	
	this.cleanUp = function() {
		xmlHttpReq.onreadystatechange = function() {};
		returnFunction = null;
		returnArgs = null;
		xmlHttpReq = null;
	};
}

var AjaxUtil = {
	counter : 1,
	requests : new Array(),
	
	request : function(url, options) {
		/*
		 * OPTIONS:
		 * onComplete (function) - function to call after response is received
		 * returnArgs (object) - object to pass to return function
		 * reverseAjax (boolean) - use reverse ajax. (only one at a time)
		 * method (string) - use "get" or "post". Default is post.
		 */
		var opts = (options == null) ? (new Object()) : options;
		var ajaxId = (opts.reverseAjax) ? 0 : AjaxUtil.getNextId();
		opts.ajaxId = ajaxId;
		
		var request;
		
		if (ajaxId == 0 && AjaxUtil.requests[0]) {
			request = AjaxUtil.requests[0];
			request.resend(url, opts);
		}
		else {
			request = new AjaxRequest(url, opts);
			AjaxUtil.requests[ajaxId] = request;
		}
		
		if (!opts.onComplete) {
			AjaxUtil.remove(ajaxId);
		}
	},
	
	update : function(url, id, options) {
		var element = $(id);

		if (element) {
			if (options == null) {
				options = new Object();
			}
			
			var origOnComplete = options.onComplete;

			options.onComplete = function(xmlHttpReq, returnArgs) {
				element.innerHTML = xmlHttpReq.responseText;
				executeLoadedScript(element);

				if (origOnComplete) {
					origOnComplete();
				}
			}
			
			AjaxUtil.request(url, options);
		}
	},
	
	getNextId : function() {
		var id = AjaxUtil.counter++;

		if (AjaxUtil.counter > 20) {
			/* Reset array in a round-robin fashion */
			/* Reserve index 0 for reverse ajax requests */
			AjaxUtil.counter = 1;
		}

		return id;
	},

	remove : function(id) {
		if (id) {
			var request = AjaxUtil.requests[id];
			
			if (request) {
				request.cleanUp();
				request = null;
			}
		}
	}
}

var ReverseAjax = {
	initialize: function() {
		Event.observe(window, "unload", function() {ReverseAjax.release();});
		ReverseAjax.request();
	},
	
	request: function() {
		AjaxUtil.request(themeDisplay.getPathMain() + "/portal/reverse_ajax",
			{
				onComplete: ReverseAjax.response,
				reverseAjax: true
			});
	},
	
	response: function(xmlHttpRequest) {
		var res =$J(xmlHttpRequest.responseText);
		var status = res.status;
		
		if (status && status != "failure") {
			if (status == "success") {
				if (res.chatMessages) {
					Messaging.getChatsReturn(res.chatMessages);
				}
				if (res.chatRoster) {
					MessagingRoster.getEntriesReturn(res.chatRoster);
				}
			}

			ReverseAjax.request();
		}
	},
	
	release : function() {
		AjaxUtil.request(themeDisplay.getPathMain() + "/portal/reverse_ajax?release=1", {reverseAjax:true});
	}
}

function $J(JSONText) {
	return eval("(" + JSONText + ")");
}

function executeLoadedScript(el) {
	//alert(el.innerHTML);
	var scripts = el.getElementsByTagName("script");
	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src) {
			var head = document.getElementsByTagName("head")[0];
			var scriptObj = document.createElement("script");

			scriptObj.setAttribute("type", "text/javascript");
			scriptObj.setAttribute("src", scripts[i].src);

			head.appendChild(scriptObj);
		}
		else {
			try {
				if (is_safari) {
					eval(scripts[i].innerHTML);
				}
				else if (is_mozilla) {
					eval(scripts[i].textContent);
				}
				else {
					//eval(scripts[i].text);
					//http://ajaxian.com/archives/evaling-with-ies-windowexecscript
				 var dj_global = this; // global scope reference
				  if (window.execScript) {
				    window.execScript(scripts[i].text); // eval in global scope for IE
				  }else{
				    if(dj_global.eval) dj_global.eval(scripts[i].text);
				    else eval(scripts[i].text);					
				  }
				}				
			}
			catch (e) {
				if(console!=undefined){
					 console.log(e);
					 console.log(scripts[i].textContent);
				}
				alert("error executeLoadedScript:"+e);
			}
		}
	}
}

function loadForm(form, action, elId, returnFunction) {
	var pos = action.indexOf("?");

	var path = action;
	var queryString = "";

	if (pos != -1) {
		path = action.substring(0, pos);
		queryString = action.substring(pos + 1, action.length);
	}

	if (!endsWith(queryString, "&")) {
		queryString += "&";
	}

	for (var i = 0; i < form.elements.length; i++) {
		var e = form.elements[i];

		if ((e.name != null) && (e.value != null)) {
			queryString += e.name + "=" + encodeURIComponent(e.value) + "&";
		}
	}

	if (elId != null) {
		document.body.style.cursor = "wait";

		pos = path.indexOf("/portal/layout");
	
		path = path.substring(0, pos) + "/portal/render_portlet";

		returnFunction =
			function (xmlHttpReq) {
				document.getElementById(elId).innerHTML = xmlHttpReq.responseText;

				document.body.style.cursor = "default";
			};
	}

	loadPage(path, queryString, returnFunction);
}

/*
 * NOTE: loadPage() has been depricated.  Use AjaxUtil.request() instead
 */
function loadPage(path, queryString, returnFunction, returnArgs) {
	AjaxUtil.request(path + "?" + queryString, {
			onComplete: returnFunction,
			returnArgs: returnArgs
		});
}

function printJSON(data) {
	if (data && data.id) {
		var target = document.getElementById(data.id);

		if (target) {
			target.innerHTML = data.toString();
		}
	}
}