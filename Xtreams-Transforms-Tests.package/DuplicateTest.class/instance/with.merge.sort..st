"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utility
"
with: aStream merge: anotherStream sort: aSortBlock
	"Given two streams, assumed to be individually ordered, merge them into an ordered output by ensuring both streams are positionable, giving them the same duplicating stream, then reading them in the sort order."

	| mergedStream positionableParamStream positionableSelfStream |
	mergedStream := aStream contentsSpecies new writing.
	positionableParamStream := anotherStream positioning duplicating: mergedStream.
	positionableSelfStream := aStream positioning duplicating: mergedStream.
	[[(aSortBlock value: positionableSelfStream peek value: positionableParamStream peek)
		ifTrue: [positionableSelfStream get]
		ifFalse: [positionableParamStream get]] repeat]
			on: Incomplete
			do: [positionableParamStream rest; close.
				positionableSelfStream rest; close].
	^mergedStream conclusion