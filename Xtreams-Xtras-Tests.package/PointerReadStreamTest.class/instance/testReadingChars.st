"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
testReadingChars

	| stream |
	self prepareFloats.
	stream := pointer reading.
	stream length: values size.
	self assert: stream rest = values.
	self should: [ stream get ] raise: Incomplete.