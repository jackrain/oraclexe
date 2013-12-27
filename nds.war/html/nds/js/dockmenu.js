var DockMenu = {
	init: function() {
		var instance = this;
		instance._dock = null;
		instance._dockList = null;
		var dock = jQuery('.portal-dock');

		if (!dock.is('.interactive-mode')) {
			return;
		}

		var dockList = dock.find('.portal-dock-list');

		if (dockList.length > 0){
			instance._dock = dock;
			instance._dockList = dockList;

			dockList.hide();
			dockList.wrap('<div class="portal-dock-list-container"></div>');

			var dockData = {
				dock: dock,
				dockList: dockList
			};

			dock.css(
				{
					position: 'absolute',
					zIndex: 80
				}
			);

			var dockOver = function(event) {
				event.data = dockData;

				jQuery(document).one(
					'click',
					function(internalEvent) {
						var currentEl = jQuery(internalEvent.target);
						var dockParent = currentEl.parents('.portal-dock');

						if ((dockParent.length == 0) && !currentEl.is('.portal-dock')) {
							instance._toggle(event, 'hide');
						}
					}
				);

				instance._toggle(event, 'show');
			};

			var dockOut = function(event) {
				event.data = dockData;
				instance._toggle(event, 'hide');
			};
			dock.hoverIntent(
				{
					interval: 0,
					out: dockOut,
					over: dockOver,
					timeout: 500
				}
			);
			var alike = jQuery('#atest');
			alike.hoverIntent(
				{
					interval: 0,
					out: dockOut,
					over: dockOver,
					timeout: 500
				}
			);
			var dockParent = dock.parent();
			dockParent.css(
				{
					position: 'relative',
					zIndex: 70
				}
			);

			instance._handleDebug();
		}
	},

	_handleDebug: function() {
		var instance = this;

		var dock = instance._dock;
		var dockList = instance._dockList;
		if (dock.is('.debug')) {
			dock.show();
			dockList.show();
			dockList.addClass('expanded');
		}
	},

	_toggle: function(event, state) {
		var params = event.data;

		var dock = params.dock;
		var dockList = params.dockList;
	 /*
			dockList.show();
			dock.addClass('expanded');*/
		if (state == 'hide') {
			dockList.hide();
			dock.removeClass('expanded');
		}
		else if (state == 'show') {
			dockList.show();
			dock.addClass('expanded');
		}
		else {
			dockList.toggle();
			dock.toggleClass('expanded');
		}
	}

};