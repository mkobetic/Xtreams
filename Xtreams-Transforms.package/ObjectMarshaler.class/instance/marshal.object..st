"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: api
"
marshal: writing object: object
	| class classId objectId |
	class := object class.
	classId := self put: writing class: class.

	(immediate at: classId) ifTrue: [^self perform: (write at: classId) with: writing with: object].
	(objectId := writing objects identityIndexOf: object) isZero ifTrue:
		[(objectId := writing objects identityIndexOf: writing nothing) isZero ifTrue:
			[writing grow.
			objectId := writing objects size].
		writing objects at: objectId put: object.
		self put: writing integer: objectId.
		^self perform: (write at: classId) with: writing with: object].
	self put: writing integer: objectId