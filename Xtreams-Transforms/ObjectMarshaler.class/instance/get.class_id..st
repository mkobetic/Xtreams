"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading class_id: aBlock
	| id class className classIsMeta classFormat classInstVarSize classInstVarNames |
	id := self get: reading integer: nil.
	id > classes size ifFalse: [^aBlock value: id value: (classes at: id)].
	className := self get: reading string: String "asStrictReference value".
	classIsMeta := self unmarshal: reading.
	classFormat := self get: reading integer: Integer.
	classInstVarSize := self get: reading integer: Integer.
	classInstVarNames := (1 to: classInstVarSize) collect: [:each | self get: reading string: String].
	classesMutex critical: [
		class := self resolveClass: className isMeta: classIsMeta format: classFormat instVarNames: classInstVarNames.
		self includeClass: class].
	^aBlock value: id value: class
