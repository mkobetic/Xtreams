"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading class: aClass
	<reads: 'Core.Behavior'>

	| class |
	self get: reading class_id: [:id :behavior | class := behavior].
	^class