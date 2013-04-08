"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: instance creation
"
on: aSource

	^self on: aSource buffer: (Buffer new: DefaultBufferSize class: aSource contentsSpecies)