"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
test2SimpleReadStreams

	| stream contents |
	stream := (1 to: 5) reading, (6 to: 7) reading.
	contents := stream rest.
	self assert: contents = (1 to: 7)
