"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: instance creation
"
on: aDestination

	^self on: aDestination buffer: (Buffer new: DefaultBufferSize class: aDestination contentsSpecies)