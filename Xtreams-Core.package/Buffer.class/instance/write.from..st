"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
write: anInteger from: aStreamable

	^aStreamable streamingWrite: anInteger into: self
