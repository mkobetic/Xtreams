"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: tests - transforming
"
testWriteTransformHexToByte
        | hex2Byte decoder result |
        decoder := [ :char | ('0123456789ABCDEF' indexOf: char asUppercase) - 1 ].
        hex2Byte :=
                self output transforming: [ :in :out |
                        out put: (((decoder value: in get) bitShift: 4) + (decoder value: in get)) ].
        hex2Byte buffer: (ElasticBuffer on: (String new: 16)).
        hex2Byte write: 'ab'.
        hex2Byte write: 'cdef'.
        hex2Byte close.
        self assert: self input get = 16rAB.
        result := self input read: 2.
        self assert: result = #[16rcd 16ref].
