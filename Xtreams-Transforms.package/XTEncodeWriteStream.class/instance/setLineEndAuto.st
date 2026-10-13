line-end
setLineEndAuto

	(OSPlatform current platformName beginsWith: 'Win')
		ifTrue: [ self setLineEndCRLF ]
		ifFalse: [ self setLineEndLF ]