"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteMaxDepthExceededError
	"
	Objects with references deeper than certain limit can not be JSON-ified. Encoding should result in error.
	Here we use a circular reference for inifinite depth.
	"
	<test>

	| a b |
	a := Dictionary new.
	b := Dictionary new.
	a at: #b put: b.
	self shouldnt: [JSON encode: a] raise: Error.
	self shouldnt: [JSON encode: b] raise: Error.
	"Make a circular reference"
	b at: #a put: a.
	self should: [JSON encode: a] raise: Error.
	self should: [JSON encode: b] raise: Error