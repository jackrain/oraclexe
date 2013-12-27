/**
  Add maxbutton in fireMessageBox() and fixed center() bugs.
  be assigned with id
*/
var Alerts = {
	
	background: null,
	message: null,
	messageArray: new Array(),
	fadeTimer: 0,
	OPACITY: 51,
	STEPS: 3,

	bgFadeIn: function(max, steps, opacity) {
		var background = Alerts.background;
		Element.changeOpacity(background, max);
		//no steps now, for fast feeling :-)
		/*var background = Alerts.background;
		var delta = max/steps
		
		if (opacity == null) {
			opacity = delta;
		}
		
		if (background && opacity <= max) {
			Element.changeOpacity(background, opacity);
			opacity += delta;
			setTimeout("Alerts.bgFadeIn(" + max + "," + steps + "," + opacity + ")", 0);
		}*/
	},

	bgFadeOut: function(max, steps, opacity) {
		var background = Alerts.background;
		if (background) {
			background.parentNode.removeChild(background);
			setSelectVisibility("visible", Alerts.message);
			Alerts.background = null;
		}
		//no steps now, for fast feeling :-)
		/*var background = Alerts.background;
		if (background) {
			var delta = max/steps
			
			if (opacity == null) {
				opacity = max - delta;
			}
			
			if (opacity >= 0) {
				Element.changeOpacity(background, opacity);
				opacity -= delta;
				setTimeout("Alerts.bgFadeOut(" + max + "," + steps + "," + opacity + ")", 0);
			}
			else {
				background.parentNode.removeChild(background);
				setSelectVisibility("visible", Alerts.message);
				Alerts.background = null;
			}
		}*/
	},
	
	createWrapper: function(message, title, options) {
		var outer = document.createElement("div");
		var inner = document.createElement("div");
		var heading = document.createElement("table");
		if (!options) options = new Object();
		
		var maxButton= options.maxButton;
		var maxURL= options.maxURL;
		
		outer.className = "pop-up-outer";
		if(options.queryindex!=undefined){
			outer.id="pop-up-outer_"+options.queryindex;
		}
		outer.align = "center";
		inner.className = "pop-up-inner";
		
		heading.className = "pop-up-header";
		heading.border = 0;
		heading.width = "100%";
		heading.cellSpacing = 0;
		heading.cellPadding = 0;
		heading.insertRow(0);
		
		var row = heading.rows[0];
		row.insertCell(0);
		row.insertCell(1);
		
		var cell0 = row.cells[0];
		var cell1 = row.cells[1];
		cell0.className = "pop-up-title";
		cell0.id="pop-up-title-"+(Alerts.messageArray.length);
		cell0.width = "99%";
		
		if (title) {
			cell0.innerHTML = title;
			//alert(title);
		}
		
		var closeButton= options.closeButton;
		if(closeButton==null || closeButton==undefined) closeButton=true;
		//cell1.id = "pop-up-close-c";
		cell1.className = "pop-up-close";
		cell1.width = "1%";
		if(closeButton){
			cell1.innerHTML = "<a href=\"javascript:void(0)\" title='Close"+"' onclick=\"Alerts.killAlert(this)\"><img border=\"0\" src=\"/html/nds/images/close.gif\"/></a>"
		}
		if(maxButton){
			cell0.width = "98%";
			row.insertCell(1);
			var cell2 = row.cells[1];
			cell1.id = "pop-up-close-x";
			cell2.className = "pop-up-close";
			cell2.width = "1%";
			cell2.innerHTML = "<a href=\"javascript:void(0)\" title='Single window"+"' onclick=\"Alerts.killAlert(this);popup_window('"+maxURL+"','_blank');\"><img border=\"0\" src=\"/html/nds/images/maxbutton.gif\"/></a>"
						
		}
		
		inner.appendChild(heading);
		inner.appendChild(message);
		outer.appendChild(inner);
		
		message.wrapper = outer;
		
		//Drag.makeDraggable(outer, cell0);
		
		return outer;
	},

	killAlert : function(oLink) {
		if (oLink) {
			var wrapper = oLink;
			var popc=document.getElementById("popup-iframe-0");
			while (wrapper.parentNode) {
				if (wrapper.className && wrapper.className.match("pop-up-outer")) {
					break;
				}
				wrapper = wrapper.parentNode;
			}
			var body = document.getElementsByTagName("body")[0];
			if(popc!=null){
				if(popc.contentWindow.masterObject!=undefined){
				var webact_id=popc.contentWindow.masterObject.table.webact_id;
				if(webact_id!=null){
					if(popc.contentWindow.oc!=undefined){
						popc.contentWindow.oc.webaction(webact_id);
				}
			}
			}
			}
			var options = wrapper.options;
			var background = null;
			var showSelects = false;
			if(options.queryindex!=undefined){
				wrapper=$("pop-up-outer_"+options.queryindex);
			}
			Alerts.remove(wrapper);
			body.removeChild(wrapper);
			
			if (Alerts.messageArray.length > 0) {
				Alerts.message = Alerts.messageArray[Alerts.messageArray.length - 1];
				Alerts.message.style.zIndex = ZINDEX.ALERT + 1;
				setSelectVisibility("visible", Alerts.message);
				background = wrapper.background;
			}
			else {
				Alerts.message = null;
				//setSelectVisibility("visible");
				background = Alerts.background;
			}
			
			if (background) {
				//body.removeChild(background);
				//Alerts.background = null;
				Alerts.bgFadeOut(Alerts.OPACITY, Alerts.STEPS);
			}
			
			if (options && options.onClose) options.onClose();
		}
	},

	fireMessageBox : function (options) {
		/*
		 * OPTIONS:
		 * modal (boolean) - show shaded background
		 * message (string) - default HTML to display
		 * height (int) - starting height of message box
		 * width (int) - starting width of message box
		 * maxButton(boolean) - show max button on upper right corner(yfzhu)
		 * maxURL(string) - max url for button
		 * onClose (function) - executes after closing
		 * closeButton(boolean) default to true
		 * 
		 * modify by Robin 20100810 add 'top' , 'left' and 'innerAlign'
		 * top(int) - starting top of message box
		 * left(int) -  starting left of message box
		 * innerAlign(string)- align style of inner message box(left,right,center)
		 * modify end
		 */
		var body = document.body;
		
		if (!options){
			options = new Object();
		}
		
		var modal = options.modal;
		var myMessage = options.message;
		var msgHeight = options.height;
		var msgWidth = options.width;
		var noCenter = options.noCenter;
		var title = options.title;
		var maxButton = options.options;
		//edit by robin
		var msgTop=options.top;
		var msgLeft=options.left;
		var innerAlign=options.innerAlign;
		//end

		var message = document.createElement("div");
		if(innerAlign){
			message.align = innerAlign;
		}else{
			message.align = "left";
		}
		//alert(title);
		var wrapper = Alerts.createWrapper(message, title,options);
		wrapper.style.position = "absolute";
		wrapper.style.top = 0;
		wrapper.style.left = 0;
		wrapper.style.zIndex = ZINDEX.ALERT + 1;
		wrapper.options = options;
		//edit by robin		
		if(msgTop){
			wrapper.style.top=msgTop+"px";
		}
		if(msgLeft){
			wrapper.style.left=msgLeft+"px";
		}
		//end
		if (myMessage) {
			message.innerHTML = myMessage;
		}
		else {
			message.innerHTML = "<div class=\"portlet-loading\"></div>";
		}
		if (msgHeight) {
			if (is_ie) {
				message.style.height = msgHeight + "px";
			}
			else {
				message.style.minHeight = msgHeight + "px";
			}
		}

		if (msgWidth) {
			wrapper.style.width = msgWidth + "px";
		}
		
		if (!Alerts.background && modal) {
			var background = document.createElement("div");
			background.id = "alert-message";
			background.style.position = "absolute";
			background.style.top = "0";
			background.style.left = "0";
			background.style.zIndex = ZINDEX.ALERT;
			
			Alerts.background = background;
			wrapper.background = background;
			
			background.style.backgroundColor = "#000000";
			Element.changeOpacity(background, 0);
			body.appendChild(background);
			Alerts.bgFadeIn(Alerts.OPACITY, Alerts.STEPS);
		}
		setSelectVisibility("hidden");
		
		if (Alerts.messageArray.length > 0) {
			var lastMsg = Alerts.messageArray[Alerts.messageArray.length - 1];
			lastMsg.style.zIndex = ZINDEX.ALERT - 1;
			setSelectVisibility("hidden", lastMsg);
		}

		setSelectVisibility("visibile", message);
		
		Alerts.message = message;
		Alerts.messageArray.push(wrapper);
		
		Alerts.resize();
		Event.observe(window, "resize", Alerts.resize);
		
		if (noCenter) {
			Alerts.center();
		}
		else {
			if(!msgTop&&!msgLeft)Alerts.center(msgHeight, msgWidth);
		}

		Event.observe(window, "resize", Alerts.center);


		
		
		body.appendChild(wrapper);
		window.focus();
		return message;
	},
	
	popupIframe : function(url, options) {
		if(options.maxButton)options.maxURL= url;
		var msgHeight = options.height;
		var msgWidth = options.width;
		var message = Alerts.fireMessageBox(options);
		var iframe = document.createElement("iframe");
		iframe.className="popup-iframe";
		iframe.id="popup-iframe-"+ (Alerts.messageArray.length-1);
		message.height = "";
		iframe.frameBorder = 0;
		if (msgWidth) iframe.style.width = "100%";
		
		message.appendChild(iframe);
		iframe.src = url;
		if (!options.noCenter) {
			Alerts.center(msgHeight, msgWidth);
		}
		return message;
	},
	
	center : function(height, width,topabs) {//modify by zhou 2009.12.8 add a param topabs
		if (Alerts.message) {
	        var message = Alerts.message.wrapper;
            var body = document.getElementsByTagName("body")[0];
            var mode = message.options.centerMode;
            if (!mode) {
	            if (height && width) {
	            	mode = message.options.centerMode = "xy";
	            }
	            else if (height && !width) {
	            	mode = message.options.centerMode = "y";
	            }
	            else if (!height && width) {
	            	mode = message.options.centerMode = "x";
	            }
                else if(height&&width&&topabs){//modify by zhou 2009.12.8
                     mode=message.options.centerMode="abs";       
                }
	            else {
	            	mode = message.options.centerMode = "none";
	            }
            }
            if(isNaN(width)) width=message.offsetWidth;
            if(isNaN(height)) height=message.offsetHeight;
            //width = width || message.offsetWidth;
            //height = height || message.offsetHeight;
            var centerLeft;
            var centerTop;

            if (!is_safari) {
                var centerLeft = (body.clientWidth - width) / 2;
                var centerTop = body.scrollTop + ((body.clientHeight - height) / 2);
            }
            else {
                var centerLeft = (body.offsetWidth - width) / 2;
                var centerTop = (body.offsetHeight - height) / 2;
            }
            if(mode=="abs"){//modify by zhou 2009.12.8
                if(topabs){
                    message.style.top=topabs + "px";
                    message.style.left = centerLeft + "px";
                }
                return;
            }
			if (mode == "xy" || mode == "y"){
	            message.style.top = centerTop + "px";
            }
            else {
	            message.style.top = (body.scrollTop + 10) + "px";
            }
            
            if (mode == "xy" || mode == "x") {
	            message.style.left = centerLeft + "px";
            }
            else {
	            message.style.left = "20px";
            }
        }       
        
	},
	
    resize: function() {
    	if (Alerts.background) {
	        var background = Alerts.background;
	        var body = document.getElementsByTagName("body")[0];
	
	        if (!is_safari) {
	        	var scrollHeight = body.scrollHeight;
	        	var clientHeight = body.clientHeight;
	        	
	            background.style.height = (scrollHeight > clientHeight ? scrollHeight : clientHeight) + "px";
	            //background.style.width = (body.offsetWidth > body.clientWidth ? body.offsetWidth : body.clientWidth) + "px";
	            background.style.width = "100%";
	        }
	        else {
	            background.style.height = body.offsetHeight + "px";
	            background.style.width = body.offsetWidth + "px";
	        }
    	}
    },
    
    resizeIframe: function(options) {
    	if (Alerts.message && options) {
    		var iframe = Alerts.message.getElementsByTagName("iframe")[0];
			var loading = document.getElementsByClassName("portlet-loading", Alerts.message);
			
			if (loading.length > 0) {
				loading[0].parentNode.removeChild(loading[0]);
			}
    		
    		if (iframe) {
	    		if (options.height) {
	    			iframe.height = options.height;
	    		}
    		
	    		if (options.width) {
	    			iframe.width = options.width;
	    		}
    		}
    	}
    	
    	Alerts.resize();
    },

    remove: function(obj) {
    	var msgArray = Alerts.messageArray;
    	
    	for (var i = 0; i < msgArray.length; i++) {
    		if (msgArray[i] == obj) {
    			msgArray.splice(i, 1);
    			break;
    		}
    	}
    }
};
