"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
cull: value1 cull: value2

    ^self numArgs < 2 ifTrue: [ self cull: value1 ] ifFalse: [ self value: value1 value: value2 ]
