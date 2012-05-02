initialize-release
initialize
	super initialize.
	actions := Dictionary new.
	(Pragma allNamed: #action:arguments: in: self class)
		do: [:pragma | actions at: pragma arguments first put: [:object |
			| arguments |
			arguments := (pragma arguments at: 2) collect: [:i | i <= object size ifTrue: [object at: i] ifFalse: [nil]].
			self perform: pragma selector withArguments: arguments]].
	(Pragma allNamed: #action: in: self class)
		do: [:pragma | actions at: pragma arguments first put: [:object |
			self perform: pragma selector with: object]].