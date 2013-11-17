"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
nextUnsignedShortMSB: bigEndian

        character isNil ifFalse: [ ^character codePoint ].
        ^bigEndian
            ifTrue: [ (stream get bitShift: 8) bitOr: stream get ]
            ifFalse: [ | first | first := stream get.
                (stream get bitShift: 8) bitOr: first ] 
