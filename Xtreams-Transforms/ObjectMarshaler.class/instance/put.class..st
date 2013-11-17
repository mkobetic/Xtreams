"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing class: class
	<writes: 'Core.Behavior'>

	| id behavior |
	classesMutex critical: [
		(id := classes indexOf: class) isZero ifFalse: [self put: writing integer: id. ^id].
		id := self includeClass: class].
	self put: writing integer: id.
	behavior := class.
	class isMeta ifTrue: [behavior := behavior soleInstance].
	self put: writing string: behavior absoluteName.
	self marshal: writing object: class isMeta.
	self put: writing integer: class format.
	self put: writing integer: class instSize.
	class allInstVarNames do: [:each | self put: writing string: each].
	^id
