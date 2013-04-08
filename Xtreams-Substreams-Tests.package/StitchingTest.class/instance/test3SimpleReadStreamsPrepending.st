"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
test3SimpleReadStreamsPrepending

	| stream contents |
	stream := (1 to: 5) reading, ((6 to: 7) reading, (8 to: 10) reading).
	contents := stream rest.
	self assert: contents = (1 to: 10)