"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: class initialization
"
initializeActionMap
"
	self initializeActionMap
"
	ActionMap := IdentityDictionary new.
	(Pragma allNamed: #action: in: self) do: [ :pragma || class |
		class := pragma arguments first value.
		ActionMap at: class put: pragma selector ].
	^ActionMap