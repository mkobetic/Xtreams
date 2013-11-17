"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - encoding
"
testWriteEncodingCRLF

        | result isCRLF |
        (self output encoding: #ascii)
                write: 'hello\world\\\' withCRs;
                close.
        isCRLF := OperatingSystem isMSWINDOWSlike.
        result := self input read: (isCRLF ifTrue: [18] ifFalse: [14]).

        self assert: result = (isCRLF
                ifTrue: [#[104 101 108 108 111 13 10 119 111 114 108 100 13 10 13 10 13 10 ] ]
                ifFalse: [#[104 101 108 108 111 10 119 111 114 108 100 10 10 10 ] ])
