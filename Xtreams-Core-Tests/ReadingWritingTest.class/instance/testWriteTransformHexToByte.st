"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
        self assert: self input get = 16rAB.
        hex2Byte write: 'cdef'.
        hex2Byte close.
        result := self input read: 2.
        self assert: result = #[16rcd 16ref].
