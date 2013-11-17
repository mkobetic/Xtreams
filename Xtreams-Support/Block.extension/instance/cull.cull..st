"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: xtreams
"
cull: value1 cull: value2

    ^self numArgs < 2 ifTrue: [ self cull: value1 ] ifFalse: [ self value: value1 value: value2 ]
