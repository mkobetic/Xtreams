"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: menus
"
xtreamsMenu

	<itemInMenu: #(menuBar) position: 10.04>
	^(UI.MenuItem labeled: '&Xtreams')
		nameKey: #xtreams;
		submenu: UI.Menu new