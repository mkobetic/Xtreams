line-end
setLineEndAuto

	(Smalltalk os platformName beginsWith: 'Win')
		ifTrue:	[self setLineEndCRLF]
		ifFalse:	[self setLineEndLF]