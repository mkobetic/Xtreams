"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
initializeMarshaling
	(marshaling := Dictionary new)
		"singletons"
		at: UndefinedObject put: [:writing :object | writing uint8 put: self class nil];
		at: True put: [:writing :object | writing uint8 put: self class true];
		at: False put: [:writing :object | writing uint8 put: self class false];

		"numbers"
		at: Float put: [:writing :object | writing uint8 put: self class float. writing float put: object];
		at: Double put: [:writing :object | writing uint8 put: self class double. writing double put: object];
		at: SmallDouble put: [:writing :object | writing uint8 put: self class double. writing double put: object];
		yourself.

	Integer allSubclassesDo: [:each |
		marshaling at: each put: [:writing :object | self write: writing integer: object]].

	SequenceableCollection allSubclassesDo: [:each |
		marshaling at: each put: [:writing :object | self write: writing array: object]].
	(KeyedCollection withAllSubclasses, Dictionary withAllSubclasses) do: [:each |
		marshaling at: each put: [:writing :object | self write: writing map: object]].
	(CharacterArray withAllSubclasses, IntegerArray withAllSubclasses) do: [:each |
		marshaling at: each put: [:writing :object | self error: each name, ' are not supported by the MessagePack protocol']].
	marshaling at: ByteArray put: [:writing :object | self write: writing raw: object]