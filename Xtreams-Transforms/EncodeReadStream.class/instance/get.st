"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
get
        | character |
        buffer hasDataToRead ifTrue: [^super get].
        character := encoder decodeFrom: source.
        transparent ifTrue: [ ^character ]. 
        character == LF
           ifTrue: [crPreceeding
                ifTrue: 
                        [character := encoder decodeFrom: source.
                        crPreceeding := character = CR]
                ifFalse: 
                        [crPreceeding := false.
                        character := Character cr]]
            ifFalse: [crPreceeding := character = CR].
        ^character == CR ifTrue: [ LF ] ifFalse: [ character ]
