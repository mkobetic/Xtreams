"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
encoding: anEncoding

        | newEncoder  encoding|
        encoding := anEncoding = #utf16 ifTrue: [ #utf16le ] ifFalse: [ anEncoding ].
        newEncoder := CharacterEncoder encoderFor: encoding.
        newEncoder isNullEncoder ifTrue: [ self error: 'Unsupported encoding ', anEncoding ].
        self encoder: newEncoder
