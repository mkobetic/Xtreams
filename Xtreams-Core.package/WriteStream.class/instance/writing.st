"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
writing
	^[:object | self nextPut: object] writing
		contentsSpecies: self contentsSpecies;
		yourself
