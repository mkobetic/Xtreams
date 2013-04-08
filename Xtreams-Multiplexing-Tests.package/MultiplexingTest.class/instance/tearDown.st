"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
tearDown
	client close.
	server close.
	sockets reverseDo: #close.
	super tearDown