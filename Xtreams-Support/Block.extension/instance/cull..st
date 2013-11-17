"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: xtreams
"
cull: value

    ^self numArgs = 1 ifTrue: [ self value: value ] ifFalse: [ self value ]
