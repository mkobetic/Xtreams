"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading class: aClass
	<reads: 'Core.Behavior'>

	| class |
	self get: reading class_id: [:id :behavior | class := behavior].
	^class
