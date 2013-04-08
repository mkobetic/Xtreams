"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
initialize
	super initialize.
	actions := Dictionary new.
	(Tools.Pragma allNamed: #action:arguments: in: self class)
		do: [:pragma | actions at: pragma arguments first put: [:object |
			| arguments |
			arguments := (pragma arguments at: 2) collect: [:i | i <= object size ifTrue: [object at: i] ifFalse: [nil]].
			self perform: pragma selector withArguments: arguments]].
	(Tools.Pragma allNamed: #action: in: self class)
		do: [:pragma | actions at: pragma arguments first put: [:object |
			self perform: pragma selector with: object]].