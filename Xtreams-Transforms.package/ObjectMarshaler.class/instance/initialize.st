"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
initialize
	self initializeVersion.
	classesMutex := Semaphore forMutualExclusion.
	classes := Array new.

	read := Array new.
	(Pragma allNamed: #reads: from: self class to: ObjectMarshaler sortedByArgument: 1) do: [:pragma |
		classes := classes copyWith: pragma arguments first asStrictReference value.
		read := read copyWith: pragma selector].

	analyse := Array new: classes size.
	(Pragma allNamed: #analyse: from: self class to: ObjectMarshaler sortedByArgument: 1) do: [:pragma |
		| class id |
		class := pragma arguments first asStrictReference value.
		(id := classes indexOf: class) isZero
			ifTrue:
				[classes := classes copyWith: class.
				read := read copyWith: nil.
				analyse := analyse copyWith: pragma selector]
			ifFalse:
				[analyse at: id put: pragma selector]].

	write := Array new: classes size.
	(Pragma allNamed: #writes: from: self class to: ObjectMarshaler sortedByArgument: 1) do: [:pragma |
		| class id |
		class := pragma arguments first asStrictReference value.
		(id := classes indexOf: class) isZero
			ifTrue:
				[classes := classes copyWith: class.
				read := read copyWith: nil.
				analyse := analyse copyWith: nil.
				write := write copyWith: pragma selector]
			ifFalse:
				[write at: id put: pragma selector]].

	rehash := Array new: classes size.
	classes keysAndValuesDo: [:index :class | rehash at: index put: (class canUnderstand: #rehash)].

	immediate := Array new: classes size.
	classes keysAndValuesDo: [:index :class | immediate at: index put: class hasImmediateInstances].

	"true, false and nil are not immediate in the #isImmediate sense, but they are in the bytes sense"
	immediate
		at: (classes indexOf: UndefinedObject) put: true;
		at: (classes indexOf: True) put: true;
		at: (classes indexOf: False) put: true