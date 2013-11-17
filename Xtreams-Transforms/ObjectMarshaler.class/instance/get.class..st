"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading class: aClass
	<reads: 'Core.Behavior'>

	| class |
	self get: reading class_id: [:id :behavior | class := behavior].
	^class
