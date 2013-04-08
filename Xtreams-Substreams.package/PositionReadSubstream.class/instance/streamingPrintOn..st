"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: printing
"
streamingPrintOn: out

	super streamingPrintOn: out.
	out write: ' position: '; print: position.