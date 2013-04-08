"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: api
"
unmarshal: reading
	| encoded size storeString |
	encoded := reading encoding: encoding.
	size := Integer readFrom: (encoded ending: Character cr) rest readStream.
	size = 0 ifTrue: [Incomplete zero raiseSignal].
	storeString := (encoded limiting: size) rest.
	^Kernel.Compiler evaluate: storeString