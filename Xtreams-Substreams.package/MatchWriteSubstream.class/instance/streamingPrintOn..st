"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: printing
"
streamingPrintOn: out

	super streamingPrintOn: out.
	out write: ' pattern: '.
	[	((out limiting: 30)
			collecting: [ :c | c = Character cr ifTrue: [ $\ ] ifFalse: [ c ] ]
		) print: pattern
	] on: Incomplete do: [ :ex | ]