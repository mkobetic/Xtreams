"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
float

	^(Array with: 4 with: "FloatArray" Array with: [:b :i | b floatAt: i] with: [:b :i :o | b floatAt: i put: o])
