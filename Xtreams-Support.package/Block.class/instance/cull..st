"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
cull: value

    ^self numArgs = 1 ifTrue: [ self value: value ] ifFalse: [ self value ]
