"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
putEscapedCharacter: aCharacter

	| code |
	aCharacter = Character tab ifTrue: [^destination write: '\t'].
	aCharacter = Character cr ifTrue: [^destination write: '\n'].
	aCharacter = Character lf ifTrue: [^destination write: '\r'].
	aCharacter = $/ ifTrue: [^destination write: '\/'].
	aCharacter = $\ ifTrue: [^destination write: '\\'].
	aCharacter = $" ifTrue: [^destination write: '\"'].
	aCharacter = Character backspace ifTrue: [^destination write: '\b'].
	aCharacter = Character newPage ifTrue: [^destination write: '\f'].
	"otherwise use \uXXXX"
	destination write: '\u'.
	code := aCharacter codePoint.
	#(-12 -8 -4 0) do: [:shift |
		destination write: 1
			from: '0123456789abcdef'
			at: ((code bitShift: shift) bitAnd: 15) + 1 ]