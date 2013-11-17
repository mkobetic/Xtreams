"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: instance creation
"
new: anInteger class: aClass
	^self on: (aClass newRecycled: anInteger)
