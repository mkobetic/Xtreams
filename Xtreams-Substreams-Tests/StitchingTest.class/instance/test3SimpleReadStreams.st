"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
test3SimpleReadStreams

	| stream contents |
	stream := (1 to: 5) reading, (6 to: 7) reading, (8 to: 10) reading.
	contents := stream rest.
	self assert: contents = (1 to: 10)
