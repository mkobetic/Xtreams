"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: actions
"
putNull: ignored
	"All action: methods must have an argument accept the object to be written, even it it's nil."
	<action: #{Core.UndefinedObject}>

	destination write: 'null'