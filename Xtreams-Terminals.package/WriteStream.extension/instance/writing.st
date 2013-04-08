"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: converting
"
writing
	^[:object | self nextPut: object] writing
		contentsSpecies: self contentsSpecies;
		yourself