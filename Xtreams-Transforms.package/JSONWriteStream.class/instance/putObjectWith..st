"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
putObjectWith: aBlock

	self trackingDepthDo: [ | empty |
		empty := true.
		destination write: '{'.
		aBlock value: [ :name :value |
			empty
				ifTrue: [ empty := false ]
				ifFalse: [ destination write: ', ' ].
			self putString: name.
			destination write: ': '.
			self put: value ].
		destination write: '}' ]