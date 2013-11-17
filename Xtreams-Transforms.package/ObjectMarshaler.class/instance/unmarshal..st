"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: api
"
unmarshal: reading
	| object reference classId class objectIndex referenceIndex |
	self get: reading class_id: [:id :behavior | classId := id. class := behavior].
	(immediate at: classId) ifTrue: [^self perform: (read at: classId) with: reading with: class].
	objectIndex := (self get: reading integer: nil) * 2.
	referenceIndex := objectIndex - 1.
	objectIndex > reading objects size ifTrue: [reading grow: objectIndex].
	(object := reading objects at: objectIndex) ~~ reading nothing ifTrue:
		[reading objects at: referenceIndex put: true.
		^object].
	reading objects at: objectIndex put: (reference := Object new).
	object := self perform: (read at: classId) with: reading with: class.
	(rehash at: classId) ifTrue: [object rehash].
	^(reading objects at: referenceIndex)
		ifTrue:	[reference become: object. reference]
		ifFalse:	[reading objects at: objectIndex put: object. object]
