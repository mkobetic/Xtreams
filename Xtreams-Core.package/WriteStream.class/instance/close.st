"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
close
	"Close the destination from any more writes."

	self flush.
	destination close