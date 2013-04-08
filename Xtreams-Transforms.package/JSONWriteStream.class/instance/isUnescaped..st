"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
isUnescaped: aCharacter
"Should the character be escaped?
	unescaped = %x20-21 / %x23-5B / %x5D-10FFFF
"
	^aCharacter < $ "space" and: [ aCharacter == $" or: [ aCharacter == $\ ] ]