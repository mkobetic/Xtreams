"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
testPositioningFloats

	| stream |
	self prepareFloats.
	stream := pointer reading.
	stream length: values size.
	stream ++ 10.
	self assert: stream position = 10.
	stream -- 5.
	self assert: stream position = 5.
	stream += 10.
	self assert: stream position = 10.
	stream -= 10.
	self assert: stream position = (values size - 10).
	self assert: ([ stream ++ 20. false ] on: Incomplete do: [ :ex | ex count = 10 ])