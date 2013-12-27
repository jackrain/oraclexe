/*
 * Origian code from http://typetester.maratz.com/
 * Modified by Liferay
 */
 
function ColorPicker (src, func) {
	var cp = document.createElement("div");
	var image = document.createElement("img");
	var body = document.getElementsByTagName("body")[0];
	var textInput = null;
	var originalValue = "";
	var self = this;
	
	cp.id = "color-picker-div";
	cp.style.height = "192px";
	cp.style.width = "100px";
	cp.style.position = "absolute";
	cp.style.display = "none";
	cp.style.cursor= "crosshair";
	cp.style.zIndex = 1;
	
	image.style.height = "192px";
	image.style.width = "100px";
	image.src = src;
	
	cp.appendChild(image);

	body.insertBefore(cp, body.childNodes[0]);
	
	/*
	 * Public methods
	 */
	 
	this.hide = function () {
		cp.style.display = "none";
		if (func != null) {
			func();
		}
	}
	
	this.toggle = function (obj) {
		if (cp.style.display == "none") {
			var nwOffset = Coordinates.northwestOffset(obj, true);
			cp.style.left = nwOffset.x + 25 + "px";
			cp.style.top = nwOffset.y + "px";
			cp.style.display = "block";
			// Grab the first input field in the parent node
			textInput = obj.parentNode.getElementsByTagName("INPUT")[0];
			originalValue = textInput.value;
		}
		else {
			self.hide();
		}
	};
	
	
	/*
	 * Private methods
	 */
	 
	var getColor = function (event, obj) {
		var nwOffset = Coordinates.northwestOffset(obj, true);
	
		mousePos.update(event);
	
		var x = mousePos.x - nwOffset.x;
		var y = mousePos.y - nwOffset.y;
	
		var rmax = 0;
		var gmax = 0;
		var bmax = 0;
	
		if (y <= 32) {
			rmax = 255;
			gmax = (y / 32.0) * 255;
			bmax = 0;
		} else if (y <= 64) {
			y = y - 32;
			rmax = 255 - (y / 32.0) * 255;
			gmax = 255;
			bmax = 0;
		} else if (y <= 96) {
			y = y - 64;
			rmax = 0;
			gmax = 255;
			bmax = (y / 32.0) * 255;
		} else if (y <= 128) {
			y = y - 96;
			rmax = 0;
			gmax = 255 - (y / 32.0) * 255;
			bmax = 255;
		} else if (y <= 160) {
			y = y - 128;
			rmax = (y / 32.0) * 255;
			gmax = 0;
			bmax = 255;
		} else {
			y = y - 160;
			rmax = 255;
			gmax = 0;
			bmax = 255 - (y / 32.0) * 255;
		}

		if (x <= 50) {
			var r = Math.abs(Math.floor(rmax * x / 50.0));
			var g = Math.abs(Math.floor(gmax * x / 50.0));
			var b = Math.abs(Math.floor(bmax * x / 50.0));
		} else {
			x -= 50;
			var r = Math.abs(Math.floor(rmax + (x / 50.0) * (255 - rmax)));
			var g = Math.abs(Math.floor(gmax + (x / 50.0) * (255 - gmax)));
			var b = Math.abs(Math.floor(bmax + (x / 50.0) * (255 - bmax)));
		}
	
		return rgb2hex(r, g, b);
	};

	var rgb2hex = function (r, g, b) {
		color = '#';
		color += hex(Math.floor(r / 16));
		color += hex(r % 16);
		color += hex(Math.floor(g / 16));
		color += hex(g % 16);
		color += hex(Math.floor(b / 16));
		color += hex(b % 16);
		return color;
	};

	var hex = function (dec){
		return (dec).toString(16);
	};

	var onEnd = function (event) {
		var color = getColor(event, image);
		originalValue = color;
		textInput.value = color;
		self.hide();
	};

	var onMove = function (event) {
		var color = getColor(event, image);
		textInput.value = color;
		textInput.onchange();
	};

	var reset = function () {
		textInput.value = originalValue;
		textInput.onchange();
	};


	/*
	 * Events
	 */
	 
	image.onmousemove = onMove;
	image.onclick = onEnd;
	image.onmouseout = reset;
}
