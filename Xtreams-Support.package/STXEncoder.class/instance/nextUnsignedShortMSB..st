"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
nextUnsignedShortMSB: bigEndian

        character isNil ifFalse: [ ^character codePoint ].
        ^bigEndian
            ifTrue: [ (stream get bitShift: 8) bitOr: stream get ]
            ifFalse: [ | first | first := stream get.
                (stream get bitShift: 8) bitOr: first ] 
