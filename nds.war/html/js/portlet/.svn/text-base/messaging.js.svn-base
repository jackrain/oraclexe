var Messaging = {
	checkRoster : false,
	currentChatBox : null,
	initialized : false,
	inputCount : 1,
	mainDiv : null,
	msgQueue : new Array(),
	userId : null,
	windowCount : 0,
	zIndex : 1,

	chat : function(msgObj) {
		if (!msgObj && Messaging.msgQueue.length == 0) return; 
		
		var msg = msgObj || Messaging.msgQueue.shift();
		var chatBox = $("msg-chat-box" + msg.toId);

		if (!chatBox) {
			var url = themeDisplay.getPathMain() + "/messaging/action?cmd=chatbox" +
				"&toId=" + msg.toId +
				"&toName=" + encodeURIComponent(msg.toName) +
				"&top=" + (msg.top || 15 * this.windowCount) +
				"&left=" + (msg.left || 15 * this.windowCount++) +
				"&zIndex=" + (ZINDEX.CHAT_BOX + this.zIndex++);
				
			if (msg.status && msg.status == "unavailable") {
				url += "&addUser=1";
			}
			
			if (msg.messages) {
				url += "&messages=" + encodeURIComponent(msg.messages);
			}
			
			AjaxUtil.request(url, {
				returnArgs: msg,
				onComplete: function(xmlHttpReq, returnArgs) {
					var chatBox = Messaging.createChatBox(xmlHttpReq.responseText);
					Messaging.populateChatBox(chatBox, returnArgs);
				}
			});
		
		}
		else {
			this.populateChatBox(chatBox, msg);
		}
	},
	
	populateChatBox : function(chatBox, msg) {
		var typeArea = document.getElementsByClassName("msg-type-area", chatBox)[0];
		var chatArea = document.getElementsByClassName("msg-chat-area", chatBox)[0];

		if (msg.body != null) {
			var name = msg.toName.split(/[ ,.-]/);
			var initials = "";
			for (var i = 0; i < name.length; i++) {
				initials += name[i].charAt(0);
			}
			chatArea.innerHTML += "<span style='color: #FF0000'>" + initials + ": </span>" + msg.body + "<br/>";
		}

		this.saveCookie();

		chatArea.scrollTop = chatArea.scrollHeight;
		typeArea.focus();

		if (is_ie) {
			// need double focus for IE
			typeArea.focus();
		}

		Messaging.chat();
	},

	getChats : function() {
		var url = themeDisplay.getPathMain() + "/messaging/action?cmd=getChats";
		AjaxUtil.request(url, {
			onComplete: function(xmlHttpReq) {
				var msg = eval("(" + xmlHttpReq.responseText + ")");
				Messaging.getChatsReturn(msg);
			}
		});
	},

	getChatsReturn : function(msg) {
		var status = msg.status;

		if (status == "success") {
			var chatMsg = msg.chat;
			if (chatMsg && chatMsg.length > 0) {
				for (var i = 0; i < chatMsg.length; i++) {
					// swap "from" and "to"
					var tmpName = chatMsg[i].fromName;
					var tmpId = chatMsg[i].fromId;
					chatMsg[i].fromName = chatMsg[i].toName;
					chatMsg[i].fromId = chatMsg[i].toId;
					chatMsg[i].toName = tmpName;
					chatMsg[i].toId = tmpId;
					Messaging.msgQueue.push(chatMsg[i]);
				}
				Messaging.chat();
				window.focus();
			}
		}
	},

	createChatBox: function(boxHTML) {
		var chatDiv = document.createElement("div");
		chatDiv.innerHTML = boxHTML;
		
		var chatBox = document.getElementsByClassName("msg-chat-box", chatDiv)[0];
		var chatTitle = document.getElementsByClassName("msg-chat-title", chatBox)[0];
		
		
		Drag.makeDraggable(chatBox, chatTitle);
		chatBox.onDragEnd = function() { Messaging.saveCookie(); };

		chatDiv.removeChild(chatBox);
		this.mainDiv.appendChild(chatBox);
		
		return chatBox;
	},
	
	error : function() {
		alert("User does not exist");
	},

	init : function(userId) {
		var body = document.getElementsByTagName("body")[0];
		var mainDiv = $("messaging-main-div");
		this.userId = userId;

		if (mainDiv == null) {
			mainDiv = document.createElement("div");
			mainDiv.id = "messaging-main-div";
			Element.setStyle(mainDiv, {
				left: 0,
				position: "absolute",
				textAlign: "left",
				top: 0,
				width: "100%",
				zIndex: ZINDEX.CHAT_BOX
			});

			body.insertBefore(mainDiv, body.childNodes[0]);
		}
		
		this.mainDiv = mainDiv;

		var msgJSON = Cookie.read(this.userId + "_chats");
		
		if (msgJSON) {
			var chatArray = $J(decodeURIComponent(msgJSON));
			chatArray.each(function(item){
				Messaging.msgQueue.push(item);
			});
			
			Messaging.chat();
		}

		this.initialized = true;
		Messaging.getChats();
	},

	maximizeChat : function(id) {
		var chatBox = $(id);
		var widthDiv = document.getElementsByClassName("msg-chat-box-width")[0];
		var chatArea = document.getElementsByClassName("msg-chat-area")[0];
		
		chatBox.style.left = Viewport.scroll().x + "px";
		chatBox.style.top = Viewport.scroll().y + "px";
		widthDiv.style.width = (Viewport.frame().x - 30) + "px";
		chatArea.style.height = (Viewport.frame().y - 100) + "px";
	},

	minimizeChat : function(id) {
		var chatBox = $(id);
		var widthDiv = document.getElementsByClassName("msg-chat-box-width")[0];
		var chatArea = document.getElementsByClassName("msg-chat-area")[0];
		
		widthDiv.style.width = 250 + "px";
		chatArea.style.height = 100 + "px";
	},

	removeChat : function(id) {
		var chatBox = $(id);
		
		Element.remove(chatBox);
		this.saveCookie();
	},

	saveCookie : function() {
		var chatList = document.getElementsByClassName("msg-chat-box", this.mainDiv);
		var chatArray = new Array();
		
		chatList.each(function(item){
			var msgObj = new Object();
			msgObj.toName = document.getElementsByClassName("msg-to-name", item)[0].innerHTML;
			msgObj.toId = document.getElementsByClassName("msg-to-input-id", item)[0].value;
			msgObj.top = parseInt(item.style.top);
			msgObj.left = parseInt(item.style.left);
			msgObj.messages = document.getElementsByClassName("msg-chat-area", item)[0].innerHTML;
			
			chatArray.push(msgObj);
		})
		
		Cookie.create(this.userId + "_chats", encodeURIComponent(chatArray.toJSONString()), 99);
	},

	sendChat : function(obj, e) {
		var keycode;
		var chatBox = obj.parentNode;
		var toInput;
		var toAddr;
		var typeArea;
		var chatArea;
		var query = "cmd=sendChat";

		if (window.event) keycode = window.event.keyCode;
		else if (e) keycode = e.which;
		else return;

		if (keycode == 13) {
			var inputList = chatBox.getElementsByTagName("input");

			for (var i = 0; i < inputList.length ; i++) {
				if (inputList[i].className) {
					if (inputList[i].className.match("msg-to-input-id")) toInput = inputList[i];
					if (inputList[i].className.match("msg-to-input-addr")) toAddr = inputList[i];
					if (inputList[i].className.match("msg-type-area")) typeArea = inputList[i];
				}
			}

			if (typeArea.value == "") return;

			var divList = chatBox.getElementsByTagName("div");
			for (var i = 0; i < divList.length ; i++) {
				if (divList[i].className && divList[i].className.match("msg-chat-area")) chatArea = divList[i];
			}

			query += "&text=" + encodeURIComponent(typeArea.value);

			if (toAddr != null) {
				query += "&tempId=" + toInput.value + "&toAddr=" + toAddr.value;
			}
			else {
				query += "&toId=" + toInput.value;
			}

			loadPage(themeDisplay.getPathMain() + "/messaging/action", query, Messaging.sendChatReturn);

			chatArea.innerHTML += "<span style='color: #0000FF'>Me: </span>" + typeArea.value + "<br/>";
			chatArea.scrollTop = chatArea.scrollHeight;
			typeArea.value = "";
			
			Messaging.saveCookie();
		}
	},

	sendChatReturn : function(xmlHttpReq) {
		var msg = eval("(" + xmlHttpReq.responseText + ")");

		if (msg.status == "success") {
			Messaging.populateChatBox(msg);
		}
		else {
			Messaging.error();
		}
	}
}

var MessagingRoster = {
	highlightColor : "",
	lastSelected : null,

	addEntry : function(userId) {
		var url;

		if (userId) {
			url = themeDisplay.getPathMain() + "/chat/roster?cmd=addEntry&userId=" + userId;
		}
		else {
			var email = $("portlet-chat-roster-email").value;
			url = themeDisplay.getPathMain() + "/chat/roster?cmd=addEntry&email=" + email
		}

		AjaxUtil.request(url, {onComplete: MessagingRoster.addEntryReturn});
	},

	addEntryReturn : function(xmlHttpReq) {
		try {
			var msg = eval("(" + xmlHttpReq.responseText + ")");

			if (msg.status == "failure") {
				alert("No such user exists");
			}
			else {
				var rosterDiv = $("portlet-chat-roster-list");

				if (rosterDiv) {
					var entries = document.getElementsByClassName("portlet-chat-roster-entry");
					var userId = msg.user;

					var userExists = entries.any(function(item) {
						return (item.userId == userId);
					});

					if (!userExists || entries.length == 0) {
						var entryRow = MessagingRoster.createEntryRow(msg.user, msg.name);

						rosterDiv.appendChild(entryRow);
					}

					MessagingRoster.toggleEmail();
				}
			}
		}
		catch (err) {
		}
	},

	createEntryRow : function (userId, userName, online) {
			var tempDiv = document.createElement("div");
			var tempImg = document.createElement("img");
			var tempLink = document.createElement("a");
			tempImg.align = "absmiddle";
			tempImg.style.marginRight = "5px";

			if (online) {
				tempImg.src = themeDisplay.getPathThemeImage() + "/chat/user_online.gif";
			}
			else {
				tempImg.src = themeDisplay.getPathThemeImage() + "/chat/user_offline.gif";
			}

			tempLink.innerHTML = userName;
			tempLink.href = "javascript: void(0)";
			tempLink.onclick = MessagingRoster.onEntryLinkClick;

			tempDiv.appendChild(tempImg);
			tempDiv.appendChild(tempLink);
			tempDiv.onclick = MessagingRoster.onEntryClick;
			tempDiv.userId = userId;
			tempDiv.userName = userName;
			tempDiv.style.cursor = "pointer";
			tempDiv.className = "portlet-chat-roster-entry";

			return tempDiv;
	},

	deleteEntries : function () {
		if (MessagingRoster.lastSelected) {
			var userId = MessagingRoster.lastSelected.userId;
			var lastSelected = MessagingRoster.lastSelected;

			lastSelected.parentNode.removeChild(lastSelected);
			MessagingRoster.lastSelected = null;

			loadPage(themeDisplay.getPathMain() + "/chat/roster", "cmd=deleteEntries&entries=" + userId, MessagingRoster.deleteEntriesReturn);
		}
	},

	deleteEntriesReturn : function (xmlHttpReq) {
		try {
			var msg = eval("(" + xmlHttpReq.responseText + ")");
		}
		catch (err) {
		}
	},

	getEntries : function() {
		var url = themeDisplay.getPathMain() + "/chat/roster?cmd=getEntries";
		AjaxUtil.request(url, {
			onComplete: function(xmlHttpReq) {
				var msg = eval("(" + xmlHttpReq.responseText + ")");
				MessagingRoster.getEntriesReturn(msg);
			}
		});
	},

	getEntriesReturn : function(msg) {
		MessagingRoster.updateEntries(msg.roster);
	},

	updateEntries : function(roster) {
		var rosterDiv = $("portlet-chat-roster-list");

		if (rosterDiv != null) {
			rosterDiv.innerHTML = "";
		}
		else {
			Messaging.checkRoster = false;
			return;
		}

		for (var i = 0; i < roster.length; i++) {
			var entry = roster[i];
			var tempDiv =
				MessagingRoster.createEntryRow(
					entry.user,
					entry.name,
					entry.status == "available"
				);
			rosterDiv.appendChild(tempDiv);
		}
	},

	onEmailKeypress : function (obj, event) {
		var keyCode;

		if (window.event) keyCode = window.event.keyCode;
		else if (event) keyCode = event.which;
		else return;

		if (keyCode == 13) {
			MessagingRoster.addEntry();
		}
	},

	onEntryClick : function () {
		if (MessagingRoster.lastSelected != null) {
			MessagingRoster.lastSelected.style.backgroundColor = "transparent";
		}

		this.style.backgroundColor = MessagingRoster.highlightColor;

		MessagingRoster.lastSelected = this;
	},

	onEntryLinkClick : function () {
		var parent = this.parentNode;
		Messaging.chat({toId: parent.userId, toName: parent.userName});
	},

	toggleEmail : function() {
		emailDiv = $("portlet-chat-roster-email-div");

		if (emailDiv.style.display == "none") {
			emailDiv.style.display = "block";

			emailInput = $("portlet-chat-roster-email");
			emailInput.value = "";
			emailInput.focus();
		}
		else {
			emailDiv.style.display = "none";
		}
	}
}