"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: menus
"
xtreamsLogToTranscript

	<itemInMenu: #(menuBar xtreams) position: 5.5>
	^(UI.MenuItem labeled: 'Log To Transcript')
		indication: [ self xtreamsIsLogging ];
		value: [ Log := self xtreamsIsLogging ifTrue: [ nil writing ] ifFalse: [ Transcript writing ] ]